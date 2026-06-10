#!/bin/bash
# tracking-activity.sh — Pre-filter for followup: check which tracked repos have actual GitHub activity
# since their last check date. Applies diff-scoped principle to study followup.
#
# Usage: bash tracking-activity.sh [--all]
#   Default: only shows repos due for revisit (today or overdue)
#   --all: checks all tracked repos regardless of revisit date
#
# Output: repos sorted by activity recency, flagged as ACTIVE/QUIET/ERROR
# Principle: Don't waste followup time on repos with zero activity since last check.

set -euo pipefail

TARGETS_FILE="$HOME/.openclaw/workspace/study/targets.md"
TODAY=$(date +%Y-%m-%d)
TODAY_MMDD=$(date +%m-%d)
SHOW_ALL=false

[[ "${1:-}" == "--all" ]] && SHOW_ALL=true

if [[ ! -f "$TARGETS_FILE" ]]; then
  echo "❌ targets.md not found" >&2
  exit 1
fi

# Build owner/repo mapping from targets.md links
# Format: project_name -> owner/repo
declare -A REPO_MAP
while IFS= read -r line; do
  name=$(echo "$line" | grep -oP '^\[([^\]]+)\]' | tr -d '[]' || true)
  repo=$(echo "$line" | grep -oP 'github\.com/\K[^)]+' || true)
  [[ -n "$name" && -n "$repo" ]] && REPO_MAP["$name"]="$repo"
done < <(grep -oP '\[[^\]]+\]\(https://github\.com/[^)]+\)' "$TARGETS_FILE")

# Parse tracking table
echo "🔍 Activity Check — $(date '+%Y-%m-%d %H:%M')"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

active_count=0
quiet_count=0
error_count=0
total=0

in_tracking=false
while IFS= read -r line; do
  if echo "$line" | grep -qiP '^## Tracking'; then
    in_tracking=true; continue
  elif echo "$line" | grep -qP '^## ' && [[ "$in_tracking" == true ]]; then
    break
  fi
  [[ "$in_tracking" == false ]] && continue
  echo "$line" | grep -q '^|' || continue
  echo "$line" | grep -q '^|---' && continue
  echo "$line" | grep -qi '^| Project' && continue

  pipe_count=$(echo "$line" | tr -cd '|' | wc -c)
  [[ $pipe_count -lt 5 ]] && continue

  # Extract fields
  project=$(echo "$line" | awk -F'|' '{print $2}' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
  last_check=$(echo "$line" | awk -F'|' '{print $4}' | sed 's/[[:space:]]//g')
  revisit=$(echo "$line" | awk -F'|' '{print $5}' | grep -oP '\d{2}-\d{2}' || true)

  # Filter by revisit date unless --all
  if [[ "$SHOW_ALL" == false && -n "$revisit" ]]; then
    if [[ "$revisit" > "$TODAY_MMDD" ]]; then
      continue
    fi
  fi

  # Find owner/repo from the map
  # Try exact name first, then try the name part before parentheses
  # Strip markdown link syntax: [Name](url) → Name
  clean_name=$(echo "$project" | sed 's/^\[\([^]]*\)\].*/\1/' | sed 's/ (.*//')
  owner_repo=""
  for key in "${!REPO_MAP[@]}"; do
    if [[ "$key" == "$clean_name" || "$key" == "$project" ]]; then
      owner_repo="${REPO_MAP[$key]}"
      break
    fi
  done

  # If not found by name, try case-insensitive
  if [[ -z "$owner_repo" ]]; then
    for key in "${!REPO_MAP[@]}"; do
      if [[ "${key,,}" == "${clean_name,,}" ]]; then
        owner_repo="${REPO_MAP[$key]}"
        break
      fi
    done
  fi

  # Fallback: look in wiki/projects/ for repo URL
  if [[ -z "$owner_repo" ]]; then
    wiki_file="$HOME/.openclaw/workspace/wiki/projects/${clean_name,,}.md"
    if [[ -f "$wiki_file" ]]; then
      # Try github.com URL first, then backtick `owner/repo` format
      owner_repo=$(grep -oP 'github\.com/\K[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' "$wiki_file" | head -1 || true)
      if [[ -z "$owner_repo" ]]; then
        owner_repo=$(grep -oP '\*\*Repo:\*\*\s*`\K[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' "$wiki_file" | head -1 || true)
      fi
      if [[ -z "$owner_repo" ]]; then
        # Try first line with owner/repo pattern after > or |
        owner_repo=$(head -5 "$wiki_file" | grep -oP '(?:^>\s*|\|\s*)[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | grep -oP '[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | head -1 || true)
      fi
    fi
    # Also try with hyphens preserved
    if [[ -z "$owner_repo" ]]; then
      wiki_file="$HOME/.openclaw/workspace/wiki/projects/$(echo "${clean_name}" | tr '[:upper:]' '[:lower:]').md"
      if [[ -f "$wiki_file" ]]; then
        owner_repo=$(grep -oP 'github\.com/\K[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' "$wiki_file" | head -1 || true)
        if [[ -z "$owner_repo" ]]; then
          owner_repo=$(grep -oP '\*\*Repo:\*\*\s*`\K[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' "$wiki_file" | head -1 || true)
        fi
        if [[ -z "$owner_repo" ]]; then
          owner_repo=$(head -5 "$wiki_file" | grep -oP '(?:^>\s*|\|\s*)[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | grep -oP '[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' | head -1 || true)
        fi
      fi
    fi
  fi

  if [[ -z "$owner_repo" ]]; then
    echo "  ⚠️  $clean_name — no repo URL found in targets.md or wiki/projects/"
    ((error_count++)) || true
    ((total++)) || true
    continue
  fi

  # Check pushed_at via GitHub API
  pushed_at=$(gh api "repos/$owner_repo" --jq '.pushed_at' 2>/dev/null || echo "ERROR")
  
  if [[ "$pushed_at" == "ERROR" || -z "$pushed_at" ]]; then
    echo "  ❌ $clean_name ($owner_repo) — API error"
    ((error_count++)) || true
    ((total++)) || true
    continue
  fi

  pushed_date=$(echo "$pushed_at" | cut -c1-10)
  pushed_mmdd=$(echo "$pushed_at" | cut -c6-10)

  # Compare pushed_at against last_check (MM-DD format)
  last_check_full="2026-${last_check}"
  
  if [[ "$pushed_date" > "$last_check_full" || "$pushed_date" == "$last_check_full" ]]; then
    days_since=$(( ($(date -d "$TODAY" +%s) - $(date -d "$pushed_date" +%s)) / 86400 ))
    echo "  🟢 ACTIVE  $clean_name ($owner_repo)"
    echo "             pushed: $pushed_date (${days_since}d ago) | last check: $last_check | revisit: ${revisit:-?}"
    ((active_count++)) || true
  else
    days_since=$(( ($(date -d "$TODAY" +%s) - $(date -d "$pushed_date" +%s)) / 86400 ))
    echo "  ⚪ QUIET   $clean_name ($owner_repo)"
    echo "             pushed: $pushed_date (${days_since}d ago) | last check: $last_check | revisit: ${revisit:-?}"
    ((quiet_count++)) || true
  fi
  ((total++)) || true

  # Rate limit: small delay between API calls
  sleep 0.3
done < "$TARGETS_FILE"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Summary: $total checked | 🟢 $active_count active | ⚪ $quiet_count quiet | ❌ $error_count errors"
if [[ $quiet_count -gt 0 ]]; then
  echo "💡 Skip QUIET repos during followup — no activity since last check"
fi
