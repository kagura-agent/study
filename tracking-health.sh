#!/bin/bash
# tracking-health.sh — Tracking portfolio health dashboard
# Applies "observability must close the loop" + tracking hygiene patterns
# 
# Surfaces: overdue items, stale clusters, auto-drop candidates,
# growth distribution, and actionable recommendations.
#
# Usage: bash tracking-health.sh [YYYY-MM-DD]

set -uo pipefail

TARGET_DATE="${1:-$(date +%Y-%m-%d)}"
TODO_FILE="$HOME/.openclaw/workspace/TODO.md"

if [[ ! -f "$TODO_FILE" ]]; then
  echo "ERROR: TODO.md not found" >&2
  exit 1
fi

# Extract all open tracking items
ITEMS=$(grep "^\- \[ \] Track:" "$TODO_FILE" || true)
TOTAL=$(echo "$ITEMS" | grep -c "Track:" || echo 0)

echo "═══════════════════════════════════════════"
echo "📊 Tracking Health Dashboard ($TARGET_DATE)"
echo "═══════════════════════════════════════════"
echo ""
echo "Total open items: $TOTAL"

# --- Overdue items ---
echo ""
echo "🔴 OVERDUE (past revisit date):"
OVERDUE=0
echo "$ITEMS" | while IFS= read -r line; do
  revisit=$(echo "$line" | grep -oP "Revisit \K\d{2}-\d{2}" || true)
  [[ -z "$revisit" ]] && continue
  target_mmdd=$(echo "$TARGET_DATE" | sed 's/^[0-9]*-//')
  if [[ "$revisit" < "$target_mmdd" ]]; then
    project=$(echo "$line" | sed 's/^- \[ \] Track: //' | cut -d'-' -f1 | sed 's/[[:space:]]*$//')
    stars=$(echo "$line" | grep -oP "\d+[⭐★]" | head -1 || echo "?")
    echo "  ⏰ [$revisit] $project ($stars)"
  fi
done
echo ""

# --- Due today ---
echo "🟡 DUE TODAY:"
echo "$ITEMS" | while IFS= read -r line; do
  revisit=$(echo "$line" | grep -oP "Revisit \K\d{2}-\d{2}" || true)
  [[ -z "$revisit" ]] && continue
  target_mmdd=$(echo "$TARGET_DATE" | sed 's/^[0-9]*-//')
  if [[ "$revisit" == "$target_mmdd" ]]; then
    project=$(echo "$line" | sed 's/^- \[ \] Track: //' | cut -d'-' -f1 | sed 's/[[:space:]]*$//')
    stars=$(echo "$line" | grep -oP "\d+[⭐★]" | head -1 || echo "?")
    echo "  📌 [$revisit] $project ($stars)"
  fi
done
echo ""

# --- Auto-drop candidates ---
echo "🗑️  AUTO-DROP CANDIDATES (signals of low value):"
echo "$ITEMS" | while IFS= read -r line; do
  reason=""
  # Signal 1: "stalled", "no commits", "no push", "flat"
  if echo "$line" | grep -qiP "stalled|no commits|no push since|flat|growth without dev|flash|solo"; then
    reason="stale signal"
  fi
  # Signal 2: very low stars (<20) with no deep read
  stars_num=$(echo "$line" | grep -oP "[\d,]+⭐" | head -1 | tr -d ',⭐' || echo "999")
  stars_num=$((10#$stars_num))  # force base-10
  if [[ "$stars_num" -lt 20 ]] && ! echo "$line" | grep -qi "deep read"; then
    reason="low traction, no deep read"
  fi
  # Signal 3: "consider drop"
  if echo "$line" | grep -qi "consider drop\|drop if"; then
    reason="explicit drop signal"
  fi
  
  if [[ -n "$reason" ]]; then
    project=$(echo "$line" | sed 's/^- \[ \] Track: //' | cut -d'-' -f1 | sed 's/[[:space:]]*$//')
    echo "  ❌ $project — $reason"
  fi
done
echo ""

# --- Revisit date distribution ---
echo "📅 Revisit Date Distribution:"
echo "$ITEMS" | grep -oP "Revisit \K\d{2}-\d{2}" | sort | uniq -c | sort -k2 | while read count date; do
  bar=$(printf '%*s' "$count" '' | tr ' ' '#')
  printf "  %s: %s (%d)\n" "$date" "$bar" "$count"
done
echo ""

# --- Star tier distribution ---
echo "⭐ Star Tier Distribution:"
tier_micro=0; tier_small=0; tier_mid=0; tier_large=0; tier_mega=0
echo "$ITEMS" | while IFS= read -r line; do
  s=$(echo "$line" | grep -oP "(\d[\d,]*)[⭐★]" | grep -oP "[\d,]+" | head -1 | tr -d ',' || echo "0")
  s=$((10#$s))  # force base-10
  if [[ "$s" -lt 50 ]]; then echo "micro"
  elif [[ "$s" -lt 500 ]]; then echo "small"
  elif [[ "$s" -lt 2000 ]]; then echo "mid"
  elif [[ "$s" -lt 10000 ]]; then echo "large"
  else echo "mega"
  fi
done | sort | uniq -c | sort -rn | while read count tier; do
  case $tier in
    micro) label="<50⭐" ;;
    small) label="50-499⭐" ;;
    mid) label="500-1999⭐" ;;
    large) label="2000-9999⭐" ;;
    mega) label="10000+⭐" ;;
    *) label="?" ;;
  esac
  printf "  %-12s %d items\n" "$label" "$count"
done
echo ""

# --- Recommendations ---
echo "💡 Recommendations:"
target_mmdd=$(echo "$TARGET_DATE" | sed 's/^[0-9]*-//')
overdue_count=$(echo "$ITEMS" | grep -oP "Revisit \K\d{2}-\d{2}" | while read r; do
  [[ "$r" < "$target_mmdd" ]] && echo "1"
done | wc -l)

drop_count=$(echo "$ITEMS" | grep -ciP "stalled|no commits|no push since|flat|growth without dev|flash|consider drop|drop if" || echo "0")

if [[ "$TOTAL" -gt 40 ]]; then
  echo "  ⚠️  Portfolio too large ($TOTAL items). Target: ≤30. Drop $((TOTAL - 30)) low-value items."
fi
if [[ "$overdue_count" -gt 0 ]]; then
  echo "  ⚠️  $overdue_count overdue items. Process or bump dates."
fi
if [[ "$drop_count" -gt 0 ]]; then
  echo "  🗑️  $drop_count items show drop signals. Review and clean."
fi
echo ""
echo "═══════════════════════════════════════════"
