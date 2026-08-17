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

## Future Ideas

- Dashboard for cross-repo stats (all repos in one view)
- Time-series tracking (save snapshots, compare over time)
- Slack/Discord notifications on new reports
- Integration with code review tools (show attribution in PR diffs)
- Team-level defaults (org-wide env var overrides)
