# AI Attribution Workflows for Different Situations

## Model routing (OpenRouter, proxies, local models)

Attribution is **provider-agnostic** — `git-ai` tracks the agent session, not the
upstream model. OpenRouter, OpenAI-compatible proxies, or local models (e.g.
Ollama) all work without changes. Only the model label in the report changes to the
provider's model id (e.g. `opencode · openrouter/anthropic/claude-sonnet-4`). For
custom providers defined in `opencode.json`, use a short readable model `id`.

## Multiple agents or sessions in one repo

Keep only the active agent session open. A live OpenCode session can claim edits
made by other tools, so close it before committing work attributed through the
Antigravity bridge.

## Switching models across sessions (e.g. OpenRouter)

When jumping between models — all under OpenCode — open a **new session per model**.
Attribution labels come from the session record, so each model's work gets a clean,
distinct label (e.g. `opencode · big-pickle` vs `opencode · openrouter/...`).
Switching models inside one session muddles attribution, since git-ai can only
resolve a single model label for that session's edits.

It doesn't matter which model performs the final push. Attribution is attached to
each commit when it's made, not when it's pushed, so `AI-AUTHORSHIP.md` lists every
model that wrote lines across all commits — regardless of who ran `git push`. Before
that final push, make sure every session's pending checkpoints are swept:

```bash
git-ai await --timeout 30
git pull --rebase origin main
git push origin refs/notes/ai
git push origin main
```

## Mixed human + AI commits

Attribute human edits with `git-ai checkpoint human` so a single commit can show
both `human` and AI lines. `bridge/verify-attribution.cmd` validates an
end-to-end attributed edit.

Verified live on the
[game-of-life](https://github.com/CaliMark/game-of-life) repo: commit `b7e37f0`
shows `100% human` in `AI-AUTHORSHIP.md` (a manual README edit recorded via
`git-ai checkpoint human` before committing). Confirm attribution the same way:

```powershell
git-ai checkpoint human   # after making your manual edit, before committing
git-ai status             # pending Human checkpoint, no agent id
git-ai log --raw -1       # after commit: note shows a "humans" entry, no "tool"
```

Use **additions**, not pure deletions, when testing — git-ai cannot attribute a
commit whose only change removes lines.

## Moving or renaming a repo

Attribution data is keyed by session and commit IDs, not repo paths, so relocating
a repo is safe. Keep the folder name when using the Antigravity bridge, since its
transcripts are keyed by folder name.

## Fresh clones and teammates

History only shows attribution once notes exist locally. On a new clone run
`git-ai fetch-notes` (or `git fetch origin refs/notes/ai:refs/notes/ai`), otherwise
older commits display as `untracked`.

## CI and bot commits

Commits made by the workflow (e.g. `github-actions[bot]` regenerating the report)
have no attribution and correctly show as `untracked`. Merge commits skip stats.

## Web edits (github.com)

Commits created in the github.com web UI (author your account, committer
`GitHub <noreply@github.com>`) never touch local git-ai hooks, so they get no
note and show as `untracked` — not `human`. `human` only appears from an explicit
checkpoint: `git-ai checkpoint human` before committing your own edits, or the
git-ai VS Code extension's save-based KnownHuman attestation. Prefer local edits
if you want manual changes attributed as `human`.

## Pushing from any IDE / terminal

The report regenerates on every push to `main`, regardless of where you push from.
Remember to push the notes ref too:

```bash
git-ai await --timeout 30
git pull --rebase origin main
git push origin refs/notes/ai
git push origin main
```

## Non-GitHub remotes (GitLab, self-hosted)

The GitHub Actions workflow is GitHub-specific. For other remotes, run
`scripts/authorship-report.sh` in your own CI pipeline (or locally) and commit the
generated `AI-AUTHORSHIP.md`.
