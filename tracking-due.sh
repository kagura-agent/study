#!/bin/bash
# tracking-due.sh — Show tracking items due for revisit (today or overdue)
# Usage: bash tracking-due.sh [YYYY-MM-DD]
#   Default: today's date
#   Outputs: items with Revisit date <= given date

set -euo pipefail

TARGET_DATE="${1:-$(date +%Y-%m-%d)}"
TARGET_MMDD=$(echo "$TARGET_DATE" | sed 's/^[0-9]*-//')  # MM-DD

TODO_FILE="$HOME/.openclaw/workspace/TODO.md"

if [[ ! -f "$TODO_FILE" ]]; then
  echo "ERROR: TODO.md not found at $TODO_FILE" >&2
  exit 1
fi

echo "📅 Tracking items due by $TARGET_DATE ($TARGET_MMDD):"
echo "---"

# Extract open Track items with Revisit dates, filter for due/overdue
grep "^\- \[ \] Track:" "$TODO_FILE" | while IFS= read -r line; do
  # Extract revisit date (MM-DD format)
  revisit=$(echo "$line" | grep -oP "Revisit \K\d{2}-\d{2}" || true)
  if [[ -z "$revisit" ]]; then
    continue
  fi
  
  # Compare dates (string comparison works for MM-DD within same year)
  if [[ "$revisit" < "$TARGET_MMDD" || "$revisit" == "$TARGET_MMDD" ]]; then
    # Extract project name and star count
    project=$(echo "$line" | sed 's/^- \[ \] Track: //' | sed 's/ - .*//' | sed 's/ (.*//')
    stars=$(echo "$line" | grep -oP "\d+⭐" || echo "?⭐")
    echo "  ⏰ [$revisit] $project ($stars)"
  fi
done

echo ""
echo "📊 Summary by date:"
grep "^\- \[ \] Track:" "$TODO_FILE" | grep -oP "Revisit \K\d{2}-\d{2}" | sort | while IFS= read -r d; do
  if [[ "$d" < "$TARGET_MMDD" || "$d" == "$TARGET_MMDD" ]]; then
    echo "$d"
  fi
done | sort | uniq -c | sort -k2
