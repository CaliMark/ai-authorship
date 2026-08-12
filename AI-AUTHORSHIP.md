# AI Authorship Report

This file shows which AI coding agent (or human) wrote the code in each commit,
using the [git-ai](https://usegitai.com) attribution notes attached to every
commit. It is regenerated automatically by a GitHub Actions workflow on every
push to `main`.

## Summary

- Commits analyzed: **17** (last 50)
- Total lines added: **1656**
- **AI-generated:** 1213 lines (73.2%)
- **Human:** 0 lines (0.0%)
- **Untracked:** 443 lines (26.8%)
- **Agents:** gemini (138 lines), gemini · gemini-3.6-flash-medium (3 lines), opencode · big-pickle (1072 lines)

> **Legend:** `opencode · big-pickle` = agent and the LLM model that generated
> the lines (model is recorded when git-ai can resolve it from the agent's
> session data). `untracked` = lines written before git-ai attribution was set
> up (cannot be retroactively attributed). `human` = written directly by
> a human. Note: these are line-count percentages, not commit counts.

## Per-commit breakdown

| Commit | Date | Message | Lines | AI | Human | Agent(s) |
| --- | --- | --- | --- | --- | --- | --- |
| 8d6dd5d | 2026-08-11 | docs: document git pull --rebase before pushing to avoid fetch-first rejections | 20 | 100% | 0% | opencode · big-pickle |
| a85e0e4 | 2026-08-11 | docs: regenerate AI authorship report | 33 | 0% | 0% | untracked |
| 89f38c3 | 2026-08-10 | fix(bridge): write turn record with model for PostToolUse-only sessions | 16 | 100% | 0% | opencode · big-pickle |
| faad984 | 2026-08-11 | docs: regenerate AI authorship report | 66 | 0% | 0% | untracked |
| 14d52df | 2026-08-10 | Merge branch 'main' of https://github.com/CaliMark/ai-authorship # Please enter a commit message to explain why this merge is necessary, # especially if it merges an updated upstream into a topic branch. # # Lines starting with '#' will be ignored, and an empty message aborts # the commit. | 0 | 0% | 0% | none |
| 90be8ae | 2026-08-10 | chore : small change to the readme.md | 3 | 100% | 0% | gemini · gemini-3.6-flash-medium |
| 904437a | 2026-08-11 | docs: regenerate AI authorship report | 52 | 0% | 0% | untracked |
| e35dcb2 | 2026-08-10 | chore: gemini attribution on live example | 138 | 100% | 0% | gemini |
| 012e360 | 2026-08-11 | docs: regenerate AI authorship report | 52 | 0% | 0% | untracked |
| 408112d | 2026-08-10 | docs: add Antigravity attribution runbook | 59 | 100% | 0% | opencode · big-pickle |
| e571d62 | 2026-08-11 | docs: regenerate AI authorship report | 53 | 0% | 0% | untracked |
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
commit 8d6dd5d8e34286ece58b067df75281cbeb0876d1 (HEAD -> main, origin/main)
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-11T21:51:56-07:00

    docs: document git pull --rebase before pushing to avoid fetch-first rejections

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      workflow/authorship-report.yml
        s_988aa8c761b089::t_ec9e39c978e36f 3-4,6-9
      README.md
        s_988aa8c761b089::t_3cd4457f9b94ea 133
        s_988aa8c761b089::t_8656ca92db0b5d 136-141
        s_988aa8c761b089::t_169dc38dd04857 169
      .github/workflows/authorship-report.yml
        s_988aa8c761b089::t_ef163d06c51e7f 3-4,6-9
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "8d6dd5d8e34286ece58b067df75281cbeb0876d1",
        "prompts": {},
        "sessions": {
          "s_988aa8c761b089": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_00bd75ff9ffesJ1tSH9l7XQdiY",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit a85e0e47c5c09bd971b5f595d47fba35d5d678c8
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T05:41:00Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 89f38c3e3ea90b2bc01ea6bf1fb1d63f5547e387
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T22:39:32-07:00

    fix(bridge): write turn record with model for PostToolUse-only sessions

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      bridge/agy-hook.ps1
        s_30f00a1884ee3d::t_c0f3010400b262 131-136
        s_30f00a1884ee3d::t_17a8bf422d0047 69-78
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "89f38c3e3ea90b2bc01ea6bf1fb1d63f5547e387",
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

commit faad9845f54531993afb99bae101dcd88cdb7be5
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T05:36:16Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 14d52dfc1a8ea11788c2f2e4ffde161482e0e7d2
Merge: 90be8ae 904437a
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T22:35:31-07:00

    Merge branch 'main' of https://github.com/CaliMark/ai-authorship # Please enter a commit message to explain why this merge is necessary, # especially if it merges an updated upstream into a topic branch. # # Lines starting with '#' will be ignored, and an empty message aborts # the commit.

    Git AI stats:
      stats skipped for merge commit

    Authorship note:
      AI-AUTHORSHIP.md
        s_30f00a1884ee3d::t_a7011485687f5d 10-12,14-15,27-28,44-88
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "14d52dfc1a8ea11788c2f2e4ffde161482e0e7d2",
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

commit 90be8aeb09c1303d589fffdd3f2853a0855262d7
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T22:31:43-07:00

    chore : small change to the readme.md

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_a658dce9a473dd::t_053dccf089aa61 70-72
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "90be8aeb09c1303d589fffdd3f2853a0855262d7",
        "prompts": {},
        "sessions": {
          "s_a658dce9a473dd": {
            "agent_id": {
              "tool": "gemini",
              "id": "85c9c557-f816-49fc-8210-15f20ece868a",
              "model": "gemini-3.6-flash-medium"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 904437aa5b69fcc1799885c280a8aaa356492f33
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T05:13:05Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit e35dcb2e6bbfbd32f2b01752af4bb68398affa0b
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T22:09:02-07:00

    chore: gemini attribution on live example

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_a658dce9a473dd::t_3fe8cd80470b61 1,3,5-8,10,12-14,16,18-19,21,23-47,50-56,58-64,66,68,72-73,75,77-79,83-87,89,91,96,98-99,101,103-109,113-115,117,119,121-124,126-128,130-134,136-137,139,141,143-148,150-177,180-182,184
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "e35dcb2e6bbfbd32f2b01752af4bb68398affa0b",
        "prompts": {},
        "sessions": {
          "s_a658dce9a473dd": {
            "agent_id": {
              "tool": "gemini",
              "id": "85c9c557-f816-49fc-8210-15f20ece868a",
              "model": "unknown"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 012e36036742babbf0a3ee9ef817205111aafda4
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T05:01:54Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 408112d62cd9f9254fb2594d4c6c17d895af2d77
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-10T22:01:07-07:00

    docs: add Antigravity attribution runbook

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      docs/antigravity-commit.md
        s_30f00a1884ee3d::t_3e6275e3df159f 1-59
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "408112d62cd9f9254fb2594d4c6c17d895af2d77",
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

commit e571d6213784ec1cadf62f7271d9e3f7b75c8a8b
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-11T04:37:17Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 54748ce0de2bb0737d4cfc06f6f3d189d1202b05
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
