#!/usr/bin/env bash
#
# Syncs the AI authorship report template (script + workflow) into consumer
# repos that were set up via the "copy the template in" model.
#
# This simulates what a real user does when they pull a new ai-authorship
# release and re-copy the two files into their own repo. It exists to make
# that ritual one command for the maintainer's own demo repos (game-of-life,
# yhrapp), so the copies never drift silently.
#
# Usage:
#   scripts/sync-consumers.sh [commit-message]
#
# Environment:
#   CONSUMER_REPOS   space-separated absolute paths to consumer repos
#                    (defaults to the maintainer's known demo clones)
#
# Notes:
#   - All consumer operations use `git -C "<path>"`; this script never cd's
#     into a consumer repo (opencode PreBashCall hooks make that dangerous
#     before a commit).
#   - Idempotent: repos whose copies are already current are skipped.
#   - CI in each consumer repo regenerates AI-AUTHORSHIP.md + .json on push.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_REPO="$(dirname "$HERE")"

SCRIPT_SRC="$SRC_REPO/scripts/authorship-report.sh"
# Copy-in template (NOT ai-authorship's own live workflow, which may set
# repo-specific env like REPORT_SHOW_BOT_CHART) — consumers simulate real
# copy-in users, so they should get the same template a user installs.
WORKFLOW_SRC="$SRC_REPO/workflow/authorship-report.yml"

DEFAULT_CONSUMERS=(
  "C:/Users/calim/Coding Projects/game-of-life"
  "C:/Users/calim/Coding Projects/needpc-main"
  "C:/Users/calim/Mahjong_Testing"
)

COMMIT_MSG="${1:-sync: update authorship report script + workflow from ai-authorship}"

for f in "$SCRIPT_SRC" "$WORKFLOW_SRC"; do
  [ -f "$f" ] || { echo "missing source file: $f" >&2; exit 1; }
done

CONSUMER_REPOS="${CONSUMER_REPOS:-}"
if [ -z "$CONSUMER_REPOS" ]; then
  CONSUMER_REPOS=("${DEFAULT_CONSUMERS[@]}")
else
  # shellcheck disable=SC2206
  CONSUMER_REPOS=($CONSUMER_REPOS)
fi

sync_one() {
  local repo="$1"
  local script_dst="$repo/scripts/authorship-report.sh"
  local workflow_dst="$repo/.github/workflows/authorship-report.yml"

  echo "==> $repo"
  [ -d "$repo/.git" ] || { echo "    not a git repo — skipping" >&2; return; }
  [ -f "$script_dst" ] || { echo "    missing scripts/authorship-report.sh — skipping" >&2; return; }
  [ -f "$workflow_dst" ] || { echo "    missing .github/workflows/authorship-report.yml — skipping" >&2; return; }

  cp "$SCRIPT_SRC" "$script_dst"
  cp "$WORKFLOW_SRC" "$workflow_dst"

  local changed
  changed="$(git -C "$repo" status --porcelain -- scripts/authorship-report.sh .github/workflows/authorship-report.yml)"
  if [ -z "$changed" ]; then
    echo "    unchanged — skipping"
    return
  fi

  git -C "$repo" add scripts/authorship-report.sh .github/workflows/authorship-report.yml
  git -C "$repo" commit -m "$COMMIT_MSG"
  git -C "$repo" pull --rebase origin main
  git -C "$repo" push origin refs/notes/ai
  git -C "$repo" push origin main
  echo "    synced + pushed"
}

echo "Syncing report template into $((${#CONSUMER_REPOS[@]})) consumer repo(s)..."
for repo in "${CONSUMER_REPOS[@]}"; do
  sync_one "$repo"
done
echo "Done."
