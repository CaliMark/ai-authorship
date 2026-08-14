# AI Authorship Report

This file shows which AI coding agent (or human) wrote the code in each commit,
using the [git-ai](https://usegitai.com) attribution notes attached to every
commit. It is regenerated automatically by a GitHub Actions workflow on every
push to `main`.

## Summary

- Commits analyzed: **27** (last 50)
- Total lines added: **2680**
- **AI-generated:** 1868 lines (69.7%)
- **Human:** 0 lines (0.0%)
- **Untracked:** 812 lines (30.3%)
- **Agents:** gemini (138 lines), gemini · gemini-3.6-flash-medium (3 lines), opencode · big-pickle (1727 lines)

> **Legend:** `opencode · big-pickle` = agent and the LLM model that generated
> the lines (model is recorded when git-ai can resolve it from the agent's
> session data). `untracked` = lines with no attribution data — written before
> git-ai was set up, made in the github.com web UI, or created by CI bots
> (cannot be retroactively attributed). `human` = written directly by a human
> and recorded via `git-ai checkpoint human` or the git-ai extension. Note:
> these are line-count percentages, not commit counts.

## Per-commit breakdown

| Commit | Date | Message | Lines | AI | Human | Agent(s) |
| --- | --- | --- | --- | --- | --- | --- |
| 7452c9a | 2026-08-13 | docs: document Devin Desktop attribution via .devin hooks + bridge | 185 | 100% | 0% | opencode · big-pickle |
| 58e6850 | 2026-08-14 | docs: regenerate AI authorship report | 73 | 0% | 0% | untracked |
| 2d5c04c | 2026-08-13 | docs: document Cline CLI + extension attribution and git-ai extension conflict | 248 | 100% | 0% | opencode · big-pickle |
| d5b1944 | 2026-08-13 | docs: regenerate AI authorship report | 60 | 0% | 0% | untracked |
| a49e791 | 2026-08-13 | docs: document native Cursor hooks integration | 46 | 100% | 0% | opencode · big-pickle |
| 5c2e5b9 | 2026-08-13 | docs: regenerate AI authorship report | 137 | 0% | 0% | untracked |
| 39a4c54 | 2026-08-12 | docs: clarify untracked vs human attribution for web edits | 14 | 100% | 0% | opencode · big-pickle |
| 69b633c | 2026-08-12 | docs: document verified VS Code / Copilot Chat attribution | 50 | 100% | 0% | opencode · big-pickle |
| 167a351 | 2026-08-12 | docs: update README with supported agents, workflows, and troubleshooting | 112 | 100% | 0% | opencode · big-pickle |
| f3aaedd | 2026-08-12 | docs: regenerate AI authorship report | 99 | 0% | 0% | untracked |
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
commit 7452c9a1a4b98ba4856e4ada50b75e365ef06977 (HEAD -> main, origin/main)
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-13T22:15:45-07:00

    docs: document Devin Desktop attribution via .devin hooks + bridge

    - Add bridge/devin/HookBridge.ps1 adapter (payload casing, cwd/transcript_path,
      sessions.db model lookup -> claude preset)
    - Document .devin/hooks.v1.json setup, session-load discovery, and the
      claude swe-1-6-slow live result on game-of-life

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_52d0732141ad88::t_ed5ac85f396317 135-137
        s_52d0732141ad88::t_e259715b00e7b4 99-100,102-104
        s_52d0732141ad88::t_6694a00def20f5 280-358
        s_52d0732141ad88::t_e2321254a8ba49 58
        s_52d0732141ad88::t_8f29e7bb1172d4 37-40
        s_52d0732141ad88::t_50be0982767694 546-547
        s_52d0732141ad88::t_8d4bc9027021e3 523-524
        s_52d0732141ad88::t_b2e2e57018563e 18
        s_52d0732141ad88::t_a45399c2c7748c 374
        s_52d0732141ad88::t_345a784e1907e2 79
        s_52d0732141ad88::t_8320a536014697 95
        s_52d0732141ad88::t_6d5ee992ba6936 388
      bridge/devin/HookBridge.ps1
        s_52d0732141ad88::t_b81325351b4ece 1-84
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "7452c9a1a4b98ba4856e4ada50b75e365ef06977",
        "prompts": {},
        "sessions": {
          "s_52d0732141ad88": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_008f7fcbaffeQRUMaWQo3qCxm4",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 58e685083e1982cd1dc9bb0d3a600c6dda06ba75
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-14T03:08:57Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 2d5c04ce11f62ae18add5526b8131773fccfdbf6
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-13T20:08:16-07:00

    docs: document Cline CLI + extension attribution and git-ai extension conflict

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_52d0732141ad88::t_f9fd7796f4c000 56
        s_52d0732141ad88::t_d9ec91e1ed7cf4 210-219
        s_52d0732141ad88::t_8d46509c5a4c7b 205-209,220-244,274-276
        s_52d0732141ad88::t_c75e379b2770b9 306
        s_52d0732141ad88::t_68f208e5352200 35-38
        s_52d0732141ad88::t_ba464b3095ec01 122-124
        s_52d0732141ad88::t_46c4a23f6dc797 113-121
        s_52d0732141ad88::t_4a14ad199fb116 255-267
        s_52d0732141ad88::t_a094103578ab22 440
        s_52d0732141ad88::t_5f732a2ff4d130 458-459
        s_52d0732141ad88::t_d515f0ebc753a7 17
        s_52d0732141ad88::t_64902d3605afda 245-254,268-273
        s_52d0732141ad88::t_4cf0166e310eec 460-461
        s_52d0732141ad88::t_0e4db10923d3ad 91-92
        s_52d0732141ad88::t_66f643a331441b 76
        s_52d0732141ad88::t_d3331d606d5310 292
      bridge/cline/PostToolUse.ps1
        s_52d0732141ad88::t_7be697fadbcf45 1-38
      .gitignore
        s_52d0732141ad88::t_a08e83cc4c57a8 11-13
      bridge/cline/PreToolUse.ps1
        s_52d0732141ad88::t_4097f228bf3cdb 1-107
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "2d5c04ce11f62ae18add5526b8131773fccfdbf6",
        "prompts": {},
        "sessions": {
          "s_52d0732141ad88": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_008f7fcbaffeQRUMaWQo3qCxm4",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit d5b1944e60392fdd8b9bad00c9d624d872d9cfae
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-13T22:03:42Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit a49e7918ea4fe07ea2b67247a3eb9067d43449c2
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-13T15:03:00-07:00

    docs: document native Cursor hooks integration

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_52d0732141ad88::t_c9dc6abdcd14c6 86-87,90-95,103-107
        s_52d0732141ad88::t_e3abe36852dc67 12,16
        s_52d0732141ad88::t_6123968abc130d 218
        s_52d0732141ad88::t_a885d14f8e5d09 53
        s_52d0732141ad88::t_7d457ea11fb5df 114-116
        s_52d0732141ad88::t_8be97e1f33b09f 72
        s_52d0732141ad88::t_3f00a0b503a1b9 204
        s_52d0732141ad88::t_341f2c970b807b 33-36
        s_52d0732141ad88::t_28029ec35096af 169-188
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "a49e7918ea4fe07ea2b67247a3eb9067d43449c2",
        "prompts": {},
        "sessions": {
          "s_52d0732141ad88": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_008f7fcbaffeQRUMaWQo3qCxm4",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 5c2e5b9a198f12d25e0bf82b9ef669c8545f624c
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-13T01:09:32Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 39a4c54765787cdeb0e41c208df181eea761baf8
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-12T18:08:29-07:00

    docs: clarify untracked vs human attribution for web edits

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_52d0732141ad88::t_ff2432fe8b6e35 286-294
      scripts/authorship-report.sh
        s_52d0732141ad88::t_af6183ad15b763 146-150
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "39a4c54765787cdeb0e41c208df181eea761baf8",
        "prompts": {},
        "sessions": {
          "s_52d0732141ad88": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_008f7fcbaffeQRUMaWQo3qCxm4",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 69b633c88a61074a6ea6104fe21ee8fb188fb898
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-12T18:00:57-07:00

    docs: document verified VS Code / Copilot Chat attribution

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_52d0732141ad88::t_be95863d2ba055 12,15,132
        s_52d0732141ad88::t_c0dfb97f042cc6 85-88,91-95
        s_52d0732141ad88::t_538aa1d3dc5fe9 131,133-156,172
        s_52d0732141ad88::t_1eeb4ececebad0 186
        s_52d0732141ad88::t_d8f5a83923799c 102-104
        s_52d0732141ad88::t_02674b8da57275 31-34
        s_52d0732141ad88::t_b70be4cc7f2787 50-52
        s_52d0732141ad88::t_532dd3ee27c040 68
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "69b633c88a61074a6ea6104fe21ee8fb188fb898",
        "prompts": {},
        "sessions": {
          "s_52d0732141ad88": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_008f7fcbaffeQRUMaWQo3qCxm4",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit 167a351670310d2d2cc1dabe795daa6190a5459b
Author: CaliMark <mreed@needpc.net>
Date:   2026-08-12T11:19:11-07:00

    docs: update README with supported agents, workflows, and troubleshooting

    Git AI stats:
      you  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ai
           0%                                  100%

    Authorship note:
      README.md
        s_52d0732141ad88::t_0c2612b4724d8c 83-87
        s_52d0732141ad88::t_3c68b3c53424c6 70-75,77-82,88-90
        s_52d0732141ad88::t_eb29aca50cf814 33-34
        s_52d0732141ad88::t_63919dc4dfe1f9 111-118
        s_52d0732141ad88::t_667bd0ded83433 280-281
        s_52d0732141ad88::t_87ba322fc76b17 208-227
        s_52d0732141ad88::t_7b114777a076fd 192-207,228-270
        s_52d0732141ad88::t_df1aaae61da643 76
      ---
      {
        "schema_version": "authorship/3.0.0",
        "git_ai_version": "1.6.22",
        "base_commit_sha": "167a351670310d2d2cc1dabe795daa6190a5459b",
        "prompts": {},
        "sessions": {
          "s_52d0732141ad88": {
            "agent_id": {
              "tool": "opencode",
              "id": "ses_008f7fcbaffeQRUMaWQo3qCxm4",
              "model": "big-pickle"
            },
            "human_author": "CaliMark <mreed@needpc.net>"
          }
        }
      }

commit f3aaedd490bea7ec3fa20ca91c1bfa6f7a410e0f
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   2026-08-12T04:52:47Z

    docs: regenerate AI authorship report

    Git AI stats:
      you  ········································ ai
           0%           untracked 100%            0%

    Authorship note:
      (none)

commit 8d6dd5d8e34286ece58b067df75281cbeb0876d1
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


```
</details>

---

_Generated by [git-ai](https://usegitai.com). See `git ai blame <file>` for
line-level attribution of any file._
