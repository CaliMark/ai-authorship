# Local Models through LM Studio (Self-Hosted, No Cloud) — Verified

Verified live on a Ryzen 3 2200G (4 threads, Vega 8 iGPU, 32 GB RAM): a local
`qwen2.5-7b-instruct` made a real file edit through OpenCode and git-ai
attributed it as `opencode · qwen2.5-7b-instruct` — report generated locally,
no GitHub, no cloud accounts. **Public proof:** the
[`game-of-life`](https://github.com/CaliMark/game-of-life) live example now
includes this exact setup — commit `7b79bd1` was written offline by
`qwen2.5-7b-instruct` through LM Studio and shows as `opencode ·
qwen2.5-7b-instruct` (100% AI) in its
[`AI-AUTHORSHIP.md`](https://github.com/CaliMark/game-of-life/blob/main/AI-AUTHORSHIP.md).

## Setup

- **App:** [LM Studio](https://lmstudio.ai) — Windows or Linux (AppImage); pick the **Vulkan** backend so AMD/Intel iGPUs and NVIDIA GPUs can offload.
- **Hardware floor:** any AVX2 CPU, **16 GB RAM** (8 GB runs sub-4B models), **~10 GB free disk**. GPU optional — 4 GB+ VRAM speeds it up, but CPU-only still works.
- **Model that works:** `qwen2.5-7b-instruct` **Q4_K_M** (~4.7 GB) — trained for tool use, emits proper `tool_calls`.
- **Model that does NOT work:** `qwen2.5-coder-7b-instruct` — the Coder family was **not trained on tool tokens**; it emits tool calls as `<tools>`/```json``` text in `content` with an empty `tool_calls` array, which the agent can't execute. Verified failing here; use `qwen2.5-instruct` (non-Coder) or `qwen3:8b` (~5–6 GB, best small tool-caller) instead.

## Gotchas

- At ~3–6 tok/s on a 4-thread CPU each step is slow — a small, sharp prompt ("use the write tool right now") works; an open-ended prompt can get a narration instead of a tool call.
- Keep GPU offload low on iGPUs — they share the CPU's memory bus, so heavy offload doesn't help.

## Config

Add an `lmstudio` provider in `~/.config/opencode/opencode.jsonc`:

```jsonc
{
  "provider": {
    "lmstudio": {
      "apiKey": "lm-studio",
      "models": {
        "qwen2.5-7b-instruct": {
          "id": "qwen2.5-7b-instruct"
        }
      }
    }
  }
}
```

Then run:

```bash
opencode run -m lmstudio/qwen2.5-7b-instruct
```

Attribution is provider-agnostic by design: it tracks the agent session, not the model endpoint.

## Self-Hosted Stack

Self-hosted fits right in: **models** via LM Studio/Ollama, **git** via
Gitea/Forgejo/GitLab, **reports** via your own cron or CI — zero cloud
accounts anywhere.
