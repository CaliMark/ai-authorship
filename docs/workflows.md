# Workflows for Different Situations

Practical guides for AI attribution across varied team setups, models, and remotes.

---

## Model Routing

### OpenRouter / Custom Providers

When using OpenRouter or a proxy, the model id in `git-ai` notes will reflect
the provider's naming (e.g. `openrouter/anthropic/claude-3.5-sonnet`). The
report displays it as-is. To get cleaner labels, set a short custom `id` in
`opencode.json`:

```json
{
  "provider": {
    "openrouter": {
      "apiKey": "...",
      "models": {
        "my-claude": {
          "id": "anthropic/claude-3.5-sonnet"
        }
      }
    }
  }
}
```

The report then shows `my-claude` instead of the full provider path.

### Local Models (LM Studio, Ollama, etc.)

When routing through a local server, the model id is whatever the server reports.
Typical examples: `qwen2.5-7b-instruct`, `llama-3.1-8b`. If the server does not
report a model name, git-ai records `unknown`, which the report hides by default
to keep labels clean.

---

## Multi-Agent Sessions

When two agents share a session (e.g. OpenCode delegates to Cline mid-session),
git-ai records both tools in the same `sessions` block. The report's `Agent(s)`
column shows the combined label (e.g. `opencode · cline`). The `tool_model_breakdown`
pie and summary break them out as separate slices.

If you deliberately route between models mid-session (e.g. `big-pickle` for
planning, `composer-2.5` for implementation), each model's lines are attributed
separately in the breakdown pies and per-commit `model_ai_lines` JSON field.

---

## Mixed Human + AI Commits

### What counts as "co-authored"

A commit is marked **co-authored** (`✓` in the Co column) when it contains
**both** `human_additions > 0` **and** `ai_additions > 0`. The report counts
these in the summary line: "Co-authored commits (human + AI lines): N".

### When does this happen?

- A human edits AI-generated code in the same commit (e.g. fixes a typo in a
  file the agent just wrote).
- A human and an agent both modify the same file before a single commit.
- A merge commit that combines a human-authored branch and an AI-authored branch
  (git-ai attributes each side; the merge itself may be a mix).

### When does it NOT happen?

- The agent commits all lines as AI (the agent's own commit — no human edits in
  the same commit). Column shows 100% AI, 0% Human.
- The human commits directly without the agent (pure human commit). Column shows
  100% Human, 0% AI.
- A bot commits (e.g. `github-actions[bot]` regenerating the report). Column
  shows `bot` in the Agent(s) column.

### Weighted co-contribution

Even when a commit is not co-authored, the weighted co-contribution pie credits
the human who directed the session with a share of the AI lines (weight `W` =
`REPORT_HUMAN_DIRECTION_WEIGHT`, default 0.5). This reflects that the human's
guidance was part of the work, even if they did not write code in that commit.

When a commit carries an `Idea-By: agent` trailer (indicating the agent
originated the idea and the human later requested it), the `Agent (idea)` slice
in the weighted pie and the `A` marker in the Idea column reflect this origin.

---

## Remotes

### Moving or Renaming a Repo

Attribution notes live in `refs/notes/ai` on the remote. When you move or
rename a repository:

1. Push notes to the new remote: `git push origin refs/notes/ai`
2. Update `scripts/sync-consumers.sh` if you use the template copy-in model.
3. Re-run the workflow or regenerate locally to verify the report still works.

### Non-GitHub Remotes

The CI workflow assumes GitHub Actions. For GitLab, Bitbucket, or self-hosted
CI:

- The workflow file must `git fetch origin refs/notes/ai` and `git push` the
  note refs. The structure is identical; only the CI syntax differs.
- Set `GIT_AI_VERSION` to match your local version.

### Fresh Clones / Teammates

New clones do not fetch attribution notes by default. Teammates must run:

```bash
git fetch origin refs/notes/ai:refs/notes/ai
```

Or use `git-ai fetch-notes` which does the same thing.

---

## Keeping the Template in Sync

When you update your report script in ai-authorship, push a new release tag
(e.g. `v1.2.0`) and run:

```bash
bash scripts/sync-consumers.sh "sync: update from ai-authorship"
```

This copies the updated `scripts/authorship-report.sh` and the copy-in workflow
template into each consumer repo (game-of-life, needpc-main, etc.), commits,
and pushes. CI then regenerates the report with the new script.

For pinned-version consumers (using `workflow/authorship-report-pinned.yml`),
update `AUTHORSHIP_SCRIPT_VERSION` in the pinned workflow to the new tag.

---

## CI/Bot Commits

The workflow commits regenerated reports as `github-actions[bot]`. These
commits are:

- **Excluded** from the composition pie by default (`REPORT_SHOW_BOT_CHART=0`).
- **Shown** in the per-commit table with `bot` in the Agent(s) column.
- **Counted** in the summary: "Bot: N lines (X%)".

To include bot commits in the pie, set `REPORT_SHOW_BOT_CHART: "1"` in the
workflow env.

Bot commits do not re-trigger the workflow (GITHUB_TOKEN pushes do not create
new runs), so the system converges after one regeneration.

---

## Agent Chart Toggle

The report draws three breakdown pies: "AI lines by agent" (tool × model
combo), "AI lines by tool", and "AI lines by model". When each tool only uses
one model, the agent chart is redundant — it shows the same data as the tool
and model charts.

To hide the agent chart, set `REPORT_SHOW_AGENT_CHART: "0"` in the workflow
env. The agent data is always written to `AI-AUTHORSHIP.json` regardless of
the toggle, so programmatic access is unaffected.

---

## Collapsible Charts

The report shows one composition chart expanded at the top, with all other
charts collapsed under it. Click any collapsed section to expand and view
that chart.

Set `REPORT_DEFAULT_CHART` in the workflow env to control which chart is
shown at the top:

| Value | Top chart |
|---|---|
| `weighted` (default) | Co-contribution (weighted, direction credit) |
| `strict` | AI vs Human vs Untracked (no direction credit) |
| `bot` | Weighted with bot commits included |
| `strict_bot` | AI vs Human vs Bot vs Untracked (non-weighted) |

The breakdown pies (agent, tool, model, human) are also collapsed and can
be toggled via `REPORT_SHOW_AGENT_CHART` and `REPORT_SHOW_BREAKDOWN`.

---

## Web Edits (github.com)

Edits made through the github.com web UI are not intercepted by git-ai hooks.
They show as `untracked` in the report — the lines are there, but git-ai
cannot retroactively attribute them.

To attribute web edits, make the edit locally through an IDE with git-ai hooks
enabled instead.

---

## Pushing from Any IDE/Terminal

The attribution notes are written by git-ai hooks at commit time, regardless of
which IDE or terminal you use. As long as git-ai hooks are installed and the
tool (e.g. OpenCode, Cline) has `git-ai` on its PATH, commits from any
interface are attributed correctly.

The only exception: IDEs that bypass git hooks entirely (e.g. some built-in
terminal emulators with hooks disabled) will not record notes.
