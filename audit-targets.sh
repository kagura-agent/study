#!/usr/bin/env bash
# audit-targets.sh — Tracking hygiene audit for targets.md
# Applies Statewave per-kind TTL concept: flag stale entries by depth tier
#
# TTL rules (days since last update):
#   🔭 scout    → 14 days (low investment, drop fast)
#   👁️ following → 21 days (moderate, need refresh)
#   🔬 deep-dive → 30 days (high investment, longer shelf life)
#
# Also flags: past-due revisit dates, DROPPED still in table
#
# Usage: bash study/audit-targets.sh [--fix]
#   --fix: auto-add "⚠️ STALE" marker to stale entries (not yet impl)

set -uo pipefail

TARGETS="$HOME/.openclaw/workspace/study/targets.md"
TODAY=$(date +%Y-%m-%d)
TODAY_EPOCH=$(date -d "$TODAY" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$TODAY" +%s 2>/dev/null)

# TTL in days per depth tier
TTL_SCOUT=14
TTL_FOLLOWING=21
TTL_DEEPDIVE=30

stale_count=0
pastdue_count=0
dropped_count=0
total=0

echo "═══════════════════════════════════════════"
echo "  Targets.md Hygiene Audit — $TODAY"
echo "═══════════════════════════════════════════"
echo ""

# Parse tracking table (bottom section with revisit dates)
echo "📅 PAST-DUE REVISIT DATES:"
echo "─────────────────────────────────────────"
while IFS='|' read -r _ project stars lastcheck revisit signal _rest; do
  # Clean whitespace
  project=$(echo "$project" | xargs)
  revisit=$(echo "$revisit" | xargs)
  
  # Skip header/separator rows
  [[ "$project" == "Project" ]] && continue
  [[ "$project" == -* ]] && continue
  [[ -z "$project" ]] && continue
  
  # Check for DROPPED still in table
  if echo "$revisit" | grep -qi "DROPPED"; then
    echo "  🗑️  $project — DROPPED but still in table"
    ((dropped_count++))
    continue
  fi
  
  # Parse revisit date (format: 05-17 or 2026-05-17)
  revisit_date=""
  if echo "$revisit" | grep -qP '^\d{2}-\d{2}$'; then
    revisit_date="2026-$revisit"
  elif echo "$revisit" | grep -qP '^\d{4}-\d{2}-\d{2}$'; then
    revisit_date="$revisit"
  fi
  
  if [[ -n "$revisit_date" ]]; then
    revisit_epoch=$(date -d "$revisit_date" +%s 2>/dev/null || echo "0")
    if [[ "$revisit_epoch" -gt 0 && "$revisit_epoch" -lt "$TODAY_EPOCH" ]]; then
      days_overdue=$(( (TODAY_EPOCH - revisit_epoch) / 86400 ))
      echo "  ⏰ $project — due $revisit_date ($days_overdue days overdue)"
      ((pastdue_count++))
    fi
  fi
done < <(grep "^|" "$TARGETS" | tail -n +2)

if [[ $pastdue_count -eq 0 && $dropped_count -eq 0 ]]; then
  echo "  ✅ No past-due or dropped entries in tracking table"
fi

echo ""
echo "🕰️  STALE BY DEPTH TIER (TTL exceeded):"
echo "─────────────────────────────────────────"

# Parse main sections (project tables with depth and last-updated)
while IFS='|' read -r _ project depth lastupdated notes _rest; do
  project=$(echo "$project" | xargs)
  depth=$(echo "$depth" | xargs)
  lastupdated=$(echo "$lastupdated" | xargs)
  
  # Skip headers/separators
  [[ "$project" == "Project" ]] && continue
  [[ "$project" == "Model/Provider" ]] && continue
  [[ "$project" == -* ]] && continue
  [[ -z "$project" ]] && continue
  
  ((total++))
  
  # Parse date
  update_date=""
  if echo "$lastupdated" | grep -qP '^\d{4}-\d{2}(-\d{2})?$'; then
    # Handle YYYY-MM format by adding -01
    if echo "$lastupdated" | grep -qP '^\d{4}-\d{2}$'; then
      update_date="${lastupdated}-01"
    else
      update_date="$lastupdated"
    fi
  fi
  
  [[ -z "$update_date" ]] && continue
  
  update_epoch=$(date -d "$update_date" +%s 2>/dev/null || echo "0")
  [[ "$update_epoch" -eq 0 ]] && continue
  
  days_old=$(( (TODAY_EPOCH - update_epoch) / 86400 ))
  
  # Determine TTL based on depth
  ttl=0
  tier=""
  case "$depth" in
    *scout*)    ttl=$TTL_SCOUT; tier="scout" ;;
    *following*) ttl=$TTL_FOLLOWING; tier="following" ;;
    *deep-dive*) ttl=$TTL_DEEPDIVE; tier="deep-dive" ;;
    *) continue ;;
  esac
  
  if [[ $days_old -gt $ttl ]]; then
    echo "  ⚠️  $project [$tier] — last updated $lastupdated ($days_old days, TTL=$ttl)"
    ((stale_count++))
  fi
done < <(grep "^|" "$TARGETS")

if [[ $stale_count -eq 0 ]]; then
  echo "  ✅ All entries within TTL"
fi

echo ""
echo "═══════════════════════════════════════════"
echo "  Summary:"
echo "  Total entries: $total"
echo "  Past-due revisit: $pastdue_count"
echo "  Stale (TTL exceeded): $stale_count"
echo "  DROPPED still listed: $dropped_count"
echo "  Action needed: $((pastdue_count + stale_count + dropped_count))"
echo "═══════════════════════════════════════════"

if [[ $((pastdue_count + stale_count + dropped_count)) -gt 0 ]]; then
  echo ""
  echo "💡 Recommended actions:"
  [[ $dropped_count -gt 0 ]] && echo "  • Remove DROPPED entries from tracking table"
  [[ $pastdue_count -gt 0 ]] && echo "  • Do followup on past-due items or update revisit dates"
  [[ $stale_count -gt 0 ]] && echo "  • Verify stale entries: still relevant? Update date or drop"
fi
