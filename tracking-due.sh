#!/bin/bash
# tracking-due.sh — Show tracking items due for revisit (today or overdue)
# Usage: bash tracking-due.sh [YYYY-MM-DD]
#   Default: today's date
#   Outputs: items with Revisit date <= given date
#   Sources: TODO.md (Track items) + study/targets.md (tracking table)

set -euo pipefail

TARGET_DATE="${1:-$(date +%Y-%m-%d)}"
TARGET_MMDD=$(echo "$TARGET_DATE" | sed 's/^[0-9]*-//')  # MM-DD

TODO_FILE="$HOME/.openclaw/workspace/TODO.md"
TARGETS_FILE="$HOME/.openclaw/workspace/study/targets.md"

DUE_COUNT=0
ALL_DATES=""

echo "📅 Tracking items due by $TARGET_DATE ($TARGET_MMDD):"
echo "---"

# Source 1: TODO.md — open Track items with Revisit dates
if [[ -f "$TODO_FILE" ]]; then
  grep "^\- \[ \] Track:" "$TODO_FILE" | while IFS= read -r line; do
    revisit=$(echo "$line" | grep -oP "Revisit \K\d{2}-\d{2}" || true)
    if [[ -z "$revisit" ]]; then
      continue
    fi
    if [[ "$revisit" < "$TARGET_MMDD" || "$revisit" == "$TARGET_MMDD" ]]; then
      project=$(echo "$line" | sed 's/^- \[ \] Track: //' | sed 's/ - .*//' | sed 's/ (.*//')
      stars=$(echo "$line" | grep -oP "\d+⭐" || echo "?⭐")
      echo "  ⏰ [$revisit] $project ($stars) [TODO]"
    fi
  done
fi

# Source 2: targets.md — "Tracking (revisit dates)" section only
# Extract lines between the tracking header and the next ## section
if [[ -f "$TARGETS_FILE" ]]; then
  in_tracking=false
  while IFS= read -r line; do
    # Detect section boundaries
    if echo "$line" | grep -qiP '^## Tracking'; then
      in_tracking=true
      continue
    elif echo "$line" | grep -qP '^## ' && [[ "$in_tracking" == true ]]; then
      break
    fi
    [[ "$in_tracking" == false ]] && continue
    # Skip non-table or header/separator rows
    echo "$line" | grep -q '^|' || continue
    echo "$line" | grep -q '^|---' && continue
    echo "$line" | grep -qi '^| Project' && continue
    # Need at least 5 pipes (5 columns)
    pipe_count=$(echo "$line" | tr -cd '|' | wc -c)
    [[ $pipe_count -lt 5 ]] && continue
    # Revisit is column 5 (| Project | ⭐ | Last Check | Revisit | Signal |)
    revisit=$(echo "$line" | awk -F'|' '{print $5}' | grep -oP '\d{2}-\d{2}' || true)
    if [[ -z "$revisit" ]]; then
      continue
    fi
    if [[ "$revisit" < "$TARGET_MMDD" || "$revisit" == "$TARGET_MMDD" ]]; then
      project=$(echo "$line" | awk -F'|' '{print $2}' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | sed 's/\[\([^]]*\)\](.*)/\1/')
      stars=$(echo "$line" | awk -F'|' '{print $3}' | sed 's/[[:space:]]//g' | sed 's/,//g')
      echo "  ⏰ [$revisit] $project (${stars}⭐) [targets]"
    fi
  done < "$TARGETS_FILE"
fi

echo ""
echo "📊 Summary by date:"
{
  # Dates from TODO.md
  if [[ -f "$TODO_FILE" ]]; then
    grep "^\- \[ \] Track:" "$TODO_FILE" | grep -oP "Revisit \K\d{2}-\d{2}" || true
  fi
  # Dates from targets.md tracking section
  if [[ -f "$TARGETS_FILE" ]]; then
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
      echo "$line" | awk -F'|' '{print $5}' | grep -oP '\d{2}-\d{2}' || true
    done < "$TARGETS_FILE"
  fi
} | sort | while IFS= read -r d; do
  if [[ "$d" < "$TARGET_MMDD" || "$d" == "$TARGET_MMDD" ]]; then
    echo "$d"
  fi
done | sort | uniq -c | sort -k2
