# AI Authorship Report

This file shows which AI coding agent (or human) wrote the code in each commit,
using the [git-ai](https://usegitai.com) attribution notes attached to every
commit. It is regenerated automatically by a GitHub Actions workflow on every
push to `main`.

## Summary

- Commits analyzed: **6** (last 50)
- Total lines added: **1164**
- **AI-generated:** 977 lines (83.9%)
- **Human:** 0 lines (0.0%)
- **Untracked:** 187 lines (16.1%)
- **Agents:** opencode · big-pickle (977 lines)

> **Legend:** `opencode · big-pickle` = agent and the LLM model that generated
> the lines (model is recorded when git-ai can resolve it from the agent's
> session data). `untracked` = lines written before git-ai attribution was set
> up (cannot be retroactively attributed). `human` = written directly by
> a human. Note: these are line-count percentages, not commit counts.

## Per-commit breakdown

| Commit | Date | Message | Lines | AI | Human | Agent(s) |
| --- | --- | --- | --- | --- | --- | --- |
| 54748ce | 2026-08-10 | chore: neutral troubleshooting wording in verify script | 3 | 100% | 0% | opencode · big-pickle |
| b322469 | 2026-08-11 | docs: regenerate AI authorship report | 54 | 0% | 0% | untracked |
| ba77809 | 2026-08-10 | docs: note this repo is a live example of the report | 9 | 100% | 0% | opencode · big-pickle |
| 729689b | 2026-08-11 | docs: regenerate AI authorship report | 133 | 0% | 0% | untracked |
| 1f3ebcc | 2026-08-10 | chore: add live workflow copy under .github/workflows | 70 | 100% | 0% | opencode · big-pickle |
| 665612b | 2026-08-10 | initial commit: AI authorship attribution package for git-ai | 895 | 100% | 0% | opencode · big-pickle |

## Raw git-ai log (last 25 commits)

<details>
<summary>Show raw attribution detail</summary>

```text
commit 54748ce0de2bb0737d4cfc06f6f3d189d1202b05 (HEAD -> main, origin/main)
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T21:36:28-07:00

    chore: neutral troubleshooting wording in verify script

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      bridge/verify-attribution.ps1
        s_30f00a1884ee3d::t_6682b8bcbe5125 156-157
        s_30f00a1884ee3d::t_d1b1bbc0da813a 170
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "54748ce0de2bb0737d4cfc06f6f3d189d1202b05",
        "prompts": {},
        "sessions": {
          "s_30f00a1884ee3d": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_0251ccc8bffeRD38fJ4fosd3c2",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit b3224699366d9001f58061d63cd601e87abdc2d3
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T03:26:35Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit ba77809963cee6a1497d4c89678308df0bab6c6f
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T20:26:03-07:00

    docs: note this repo is a live example of the report

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_30f00a1884ee3d::t_f9bfcd8ae10a7d 21-24
        s_30f00a1884ee3d::t_8559be56b59c9f 93-96
        s_30f00a1884ee3d::t_39040536fa1fd8 137
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "ba77809963cee6a1497d4c89678308df0bab6c6f",
        "prompts": {},
        "sessions": {
          "s_30f00a1884ee3d": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_0251ccc8bffeRD38fJ4fosd3c2",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 729689bb7eec3b3a157fbb8694256465c9a3e606
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T03:21:10Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 1f3ebcc403784c777b670c2db9027b0e59513a24
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T20:20:36-07:00

    chore: add live workflow copy under .github/workflows

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      .github/workflows/authorship-report.yml
        s_30f00a1884ee3d::t_f846e4bf6d9d31 1-70
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "1f3ebcc403784c777b670c2db9027b0e59513a24",
        "prompts": {},
        "sessions": {
          "s_30f00a1884ee3d": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_0251ccc8bffeRD38fJ4fosd3c2",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 665612bd0085c54d62ce4c242d21349f50848cf9
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T20:16:38-07:00

    initial commit: AI authorship attribution package for git-ai

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      .gitattributes
        s_30f00a1884ee3d::t_caf9f2688707cc 1-6
      .gitignore
        s_30f00a1884ee3d::t_6b696f25a74775 1-10
      LICENSE
        s_30f00a1884ee3d::t_4d72afe2f4f12c 1-21
      README.md
        s_30f00a1884ee3d::t_a8ad071e9331c0 1-133
      bridge/agy-hook.cmd
        s_30f00a1884ee3d::t_46804a5e4adee6 1-3
      bridge/agy-hook.ps1
        s_30f00a1884ee3d::t_5d40b9282efae3 1-187
      bridge/config.json
        s_30f00a1884ee3d::t_8d04b9a3a8793f 1-8
      bridge/install.cmd
        s_30f00a1884ee3d::t_c58fc94c81346c 1-3
      bridge/install.ps1
        s_30f00a1884ee3d::t_f2298adc14c1c1 1-64
      bridge/uninstall.cmd
        s_30f00a1884ee3d::t_570ad7765140ac 1-3
      bridge/uninstall.ps1
        s_30f00a1884ee3d::t_c3823d8e63efad 1-26
      bridge/verify-attribution.cmd
        s_30f00a1884ee3d::t_2d46a62022e890 1-12
      bridge/verify-attribution.ps1
        s_30f00a1884ee3d::t_dcef86d9266967 1-173
      scripts/authorship-report.sh
        s_30f00a1884ee3d::t_cdd834347c00da 1-176
      workflow/authorship-report.yml
        s_30f00a1884ee3d::t_ba1a9c5e2f82ee 1-70
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "665612bd0085c54d62ce4c242d21349f50848cf9",
        "prompts": {},
        "sessions": {
          "s_30f00a1884ee3d": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_0251ccc8bffeRD38fJ4fosd3c2",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }


```
</details>

---

_Generated by [git-ai](https://usegitai.com). See `git ai blame <file>` for
line-level attribution of any file._
