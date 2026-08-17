# AI-Authorship Value Proposition

Internal doc — not published. Reference for pitches, discussions, or future docs.

---

## Core Magic (Automatic)

- git-ai hooks attribute every commit without manual tracking
- CI regenerates reports on every push — zero maintenance
- Tracks tool × model × human driver per session
- Schema v4 captures per-commit breakdowns (tool, model, idea source)

## Customization Layer (Env Vars)

Teams decide how the report behaves per-repo:

| Env Var | Controls |
|---|---|
| `REPORT_HUMAN_DIRECTION_WEIGHT` | How much credit humans get for AI they directed (default 0.5) |
| `REPORT_IDEA_WEIGHT` | How much credit agents get for ideas they suggested (default 0.3) |
| `REPORT_SHOW_BOT_CHART` | Whether CI noise appears in the pie (default 0) |
| `REPORT_SHOW_BREAKDOWN` | Whether tool and model pies appear (default 1) |
| `REPORT_SHOW_AGENT_CHART` | Whether the tool×model combo pie appears (default 1) |
| `REPORT_SHOW_DIRECTION` | Weighted vs strict AI/Human/Untracked pie (default 1) |

Each repo can tune these independently — no global config needed.

## What a Larger Team Actually Gets

1. **Visibility** — "Who wrote this?" answered automatically
2. **Accountability** — Clear attribution for code review
3. **Policy control** — Each repo can tune weights to match team norms
4. **No process overhead** — No standups, no spreadsheets, no manual tracking
5. **Historical record** — Reports accumulate, showing trends over time

## Key Insight

The env vars are the "tweak on the fly" layer. But the real magic is that
attribution happens automatically — the team just reads the report.

---

## Competitive Landscape (Summary)

Full notes in `competition.md` (gitignored). Key takeaways:

### The Category

Coding agents write more of every repo, but `git blame` only records who
committed. A wave of tools now record which agent (and model/prompt) wrote
which line — most by attaching metadata to git commits.

### Direct Competitors

| Tool | Storage | Key Differentiator | Public Demo? |
|---|---|---|---|
| git-ai | `refs/notes/ai` (Git Notes) | OSS foundation, Agent Trace spec | No |
| Origin | `refs/notes/origin` + session transcripts | Backfill heuristics, $29/user/mo | No |
| Autter | `refs/notes/ai` (Git Notes) | Survives every git rewrite op | No |
| agentdiff | `refs/agentdiff/*` (per-branch traces) | ed25519-signed provenance | No |
| oobo | Orphan branch `oobo/anchors/v2` | 15 tools as read-only observers | No |
| GitIntel | `refs/ai/authorship/{sha}` (YAML) | Zero-setup via Co-Authored-By trailers | No |
| Entire | Branch `entire/checkpoints/v1` | $300M valuation, enterprise vision | No |

### Our Differentiator

**We are the only tool with click-to-verify live demos.**

- `CaliMark/ai-authorship` — 50 commits, 2,874 AI lines, opencode
- `CaliMark/game-of-life` — 50 commits, 5+ attribution sources, verified human commits
- `CaliMark/Mahjong_Testing` — schema v4 demo (co-authored, agent-idea, tool/model breakdowns)

No signup, no login, no screenshots — open the repo and check the report.

Message: "Stop reading screenshots — open the repos."

### Positioning

1. **First-time public GitHub user** — free, MIT, no account, works offline
2. **Hobbyist / prosumer** — copy the live example, report runs in minutes
3. **Team** — Git-native + GitHub Actions = zero-SaaS visibility
4. **Enterprise (roadmap)** — Open standard (Agent Trace), EU AI Act Art. 50 compliance

### Lessons from Competitor Failures

- VS Code `git.addAICoAuthor` — auto-added Co-authored-by trailer; falsely credited
  human code; reverted after backlash. Lesson: attribution must be correct, opt-in,
  and never override reviewed commit messages.
- Claude Code / Copilot CLI — auto-add Co-authored-by by default; users can't disable.
  Git-ai is opt-in by nature (hooks must be installed).

---

## Research Insights (Summary)

Full notes in `RESEARCH-NOTES.md` (gitignored). Key takeaways:

### Standards & Governance

- **Agent Trace spec** (`agent-trace.dev`, v0.1.0 RFC) — emerging open standard;
  git-ai, Cline, OpenCode implement it. Staying on `refs/notes/ai` keeps us compatible.
- **OpenTelemetry GenAI** — `gen_ai.agent.id/name/version`, `gen_ai.user_id`,
  `gen_ai.session_id`. Aligns with our plugin design.
- **EU AI Act Art. 50** — enforcement Aug 2026; likely demand driver for
  machine-readable provenance.

### Detection vs Attribution

- Active provenance (watermarking: CodeMark, CODE ACROSTIC) vs passive attribution
  (what we do). Notes the "access paradox" (white-box methods vs black-box APIs).
- Our approach: exact hook-based reporting, not heuristic guesswork. This is
  a defensible differentiator vs Origin/GitIntel backfill detection.

### IP Liability (Gap)

- Tabnine Provenance checks generated code against public GitHub, flags license
  type (GPL/BSD/MIT). We don't cover IP-liability — potential future angle.

---

## Future Ideas

- Dashboard for cross-repo stats (all repos in one view)
- Time-series tracking (save snapshots, compare over time)
- Slack/Discord notifications on new reports
- Integration with code review tools (show attribution in PR diffs)
- Team-level defaults (org-wide env var overrides)
- IP liability angle (license detection on AI-generated code)
- GitHub Pages site for SEO + Search Console verification
