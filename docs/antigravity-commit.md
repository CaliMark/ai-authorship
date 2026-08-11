# Adding Antigravity (Gemini) as an Agent on the Live Example — Option A

Goal: make one file edit in Antigravity and have the commit attributed to
`gemini · gemini-3.6-flash-medium` on the live AI-AUTHORSHIP.md report.

## Before you start (critical)

- **Fully close opencode / this window and all VSCode windows.** A running
  `opencode.exe` process steals attribution to `opencode` instead of `gemini`.
- Confirm nothing is running:
  - Press `Win+R`, run `powershell`, type: `Get-Process opencode`
  - It must return nothing (or an error saying no such process).
- The repo to open in Antigravity: `C:\Users\calim\ai-authorship`

## Step 1 — Make the edit (in Antigravity)

Open the repo folder in Antigravity, then tell the agent:

> Make a small edit to README.md — e.g. add one line to the Quick start section
> noting that the Antigravity bridge is tested on this repo. Do not commit yet.

The bridge hook records a `gemini` checkpoint automatically. Do not run any
git commands yet.

## Step 2 — Commit and push (in Antigravity, same session)

Tell the agent:

> Commit the change with message: `chore: gemini attribution on live example`
> Then run exactly these commands, in order:
> 1. `git-ai await --timeout 30`
> 2. `git push origin refs/notes/ai`
> 3. `git push origin main`

Notes:
- The bridge is set to `ask` for shell commands, so Antigravity will pause for
  your approval on each git command. Approve them.
- Order matters: `await` writes the note locally, then **notes are pushed
  before `main`** so GitHub has them before the workflow runs.

## Step 3 — Verify (after closing Antigravity)

1. Close Antigravity.
2. Re-open `C:\Users\calim\ai-authorship` in VSCode with opencode.
3. Tell opencode: "Verify the gemini attribution run."
4. It will check:
   - `gh run list --repo CaliMark/ai-authorship --limit 1` → expect `completed / success`
   - `git pull --rebase` → AI-AUTHORSHIP.md should now show **two** agents:
     `gemini · gemini-3.6-flash-medium` (new commit) plus
     `opencode · big-pickle` (earlier commits).

## Gotchas

- Only one agent may be running at commit time. The pending checkpoints decide
  attribution.
- Every future commit you want in the report must push `refs/notes/ai` along
  with `main`.
- If it shows `opencode` or "MIXED" instead of `gemini`, an opencode process
  was still alive — close it, make another small edit, and redo Step 2.
