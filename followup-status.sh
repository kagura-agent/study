#!/bin/bash
# followup-status.sh — Unified followup pre-check aggregator
# Replaces running tracking-due.sh + tracking-activity.sh + tracking-health.sh
# separately (25%+ overhead reduction per followup round)
#
# Usage: bash followup-status.sh [YYYY-MM-DD]
# Source: study-followup-precheck-aggregation gradient (2026-06-18)

set -uo pipefail

TARGET_DATE="${1:-$(date +%Y-%m-%d)}"
TODO_FILE="$HOME/.openclaw/workspace/TODO.md"
TARGETS_FILE="$HOME/.openclaw/workspace/study/targets.md"

if [[ ! -f "$TODO_FILE" ]]; then
  echo "ERROR: TODO.md not found" >&2
  exit 1
fi

echo "═══════════════════════════════════════════"
echo "📋 Followup Pre-Check — $TARGET_DATE"
echo "═══════════════════════════════════════════"
echo ""

# --- Phase 1: Extract due items from TODO.md ---
# Use grep + sed to extract structured data (avoid complex bash regex)
DUE_NAMES=()
DUE_REPOS=()
DUE_STARS=()
DUE_DATES=()
DUE_COUNT=0

while IFS= read -r line; do
  # Extract revisit date
  revisit=$(echo "$line" | grep -oP 'Revisit \K[0-9]{2}-[0-9]{2}' | head -1)
  [[ -z "$revisit" ]] && continue
  revisit="2026-$revisit"
  
  # Check if due
  [[ "$revisit" > "$TARGET_DATE" ]] && continue
  
  # Extract name (between "Track: " and " -" or " (")
  name=$(echo "$line" | sed -n 's/.*Track: \+\([^(]*\) (.*/\1/p' | sed 's/[[:space:]]*$//')
  [[ -z "$name" ]] && name=$(echo "$line" | sed -n 's/.*Track: \+\(.*\) - .*/\1/p' | sed 's/[[:space:]]*$//')
  [[ -z "$name" ]] && continue
  
  # Extract repo (owner/repo in parens)
  repo=$(echo "$line" | grep -oP '\(([a-zA-Z0-9_.-]+/[a-zA-Z0-9_.-]+)\)' | head -1 | tr -d '()')
  
  # If no owner/repo found, try org-only pattern and append name
  if [[ -z "$repo" ]]; then
    org=$(echo "$line" | grep -oP '\(([a-zA-Z0-9_-]+)\)' | head -1 | tr -d '()')
    if [[ -n "$org" ]]; then
      # Try org/name-with-dashes (convert spaces to dashes in name)
      slug=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
      repo="$org/$slug"
    fi
  fi
  
  # Extract stars
  stars=$(echo "$line" | grep -oP '[0-9,]+(?=⭐)' | head -1)
  
  DUE_NAMES+=("$name")
  DUE_REPOS+=("${repo:-}")
  DUE_STARS+=("${stars:-}")
  DUE_DATES+=("$revisit")
  ((DUE_COUNT++))
done < <(grep '^\- \[ \] Track:' "$TODO_FILE")

# --- Phase 2: Check activity for due repos (batch GitHub API) ---
declare -A REPO_STATUS
declare -A REPO_DETAIL

for repo in "${DUE_REPOS[@]}"; do
  [[ -z "$repo" ]] && continue
  [[ -n "${REPO_STATUS[$repo]:-}" ]] && continue  # already checked
  
  pushed_at=$(curl -sfL -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$repo" 2>/dev/null | \
    grep -o '"pushed_at"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | grep -oP '"\K[0-9]{4}-[0-9]{2}-[0-9]{2}')
  
  if [[ -z "$pushed_at" ]]; then
    REPO_STATUS["$repo"]="ERROR"
    REPO_DETAIL["$repo"]="API error"
    continue
  fi
  
  pushed_epoch=$(date -d "$pushed_at" +%s 2>/dev/null || echo 0)
  today_epoch=$(date -d "$TARGET_DATE" +%s 2>/dev/null || date +%s)
  days_ago=$(( (today_epoch - pushed_epoch) / 86400 ))
  
  if [[ $days_ago -le 2 ]]; then
    REPO_STATUS["$repo"]="ACTIVE"
  else
    REPO_STATUS["$repo"]="QUIET"
  fi
  REPO_DETAIL["$repo"]="pushed $pushed_at (${days_ago}d ago)"
done

# --- Phase 3: Portfolio health ---
TOTAL_OPEN=$(grep -c '^\- \[ \] Track:' "$TODO_FILE" 2>/dev/null || echo 0)
TOTAL_DONE=$(grep -c '^\- \[x\] Track:' "$TODO_FILE" 2>/dev/null || echo 0)

echo "📊 Portfolio: $TOTAL_OPEN active tracked | $TOTAL_DONE completed/dropped"
echo ""

# --- Phase 4: Unified output ---
if [[ $DUE_COUNT -eq 0 ]]; then
  echo "✅ No items due today or overdue."
  echo ""
  echo "📌 Next revisit dates:"
  grep '^\- \[ \] Track:' "$TODO_FILE" | grep -oP 'Revisit \K[0-9]{2}-[0-9]{2}' | sort -u | head -5 | while read -r d; do
    count=$(grep -c "Revisit $d" "$TODO_FILE" || echo 0)
    echo "   $d: $count item(s)"
  done
  echo ""
  echo "💡 Recommendation: No followup targets today. Choose scout or apply instead."
  exit 0
fi

echo "⏰ DUE ITEMS ($DUE_COUNT):"
echo "───────────────────────────────────────────"

ACTIVE_COUNT=0
QUIET_COUNT=0
UNKNOWN_COUNT=0

for i in $(seq 0 $((DUE_COUNT - 1))); do
  name="${DUE_NAMES[$i]}"
  repo="${DUE_REPOS[$i]}"
  stars="${DUE_STARS[$i]}"
  revisit="${DUE_DATES[$i]}"
  
  icon="❓"
  detail="no repo URL"
  
  if [[ -n "$repo" ]]; then
    status="${REPO_STATUS[$repo]:-UNKNOWN}"
    detail="${REPO_DETAIL[$repo]:-unknown}"
    case "$status" in
      ACTIVE) icon="🟢"; ((ACTIVE_COUNT++)) || true ;;
      QUIET)  icon="⚪"; ((QUIET_COUNT++)) || true ;;
      *)      icon="❌"; ((UNKNOWN_COUNT++)) || true ;;
    esac
  else
    ((UNKNOWN_COUNT++)) || true
  fi
  
  star_display=""
  [[ -n "$stars" ]] && star_display=" (${stars}⭐)"
  
  echo "  $icon $name$star_display — due $revisit"
  echo "     $detail"
done

echo ""
echo "───────────────────────────────────────────"
echo "📊 Activity: 🟢 $ACTIVE_COUNT active | ⚪ $QUIET_COUNT quiet | ❓ $UNKNOWN_COUNT unknown"
echo ""

# --- Recommendation ---
if [[ $ACTIVE_COUNT -gt 0 ]]; then
  echo "💡 Recommendation: Followup on $ACTIVE_COUNT ACTIVE item(s). Skip QUIET repos."
elif [[ $QUIET_COUNT -eq $DUE_COUNT ]]; then
  echo "💡 Recommendation: All $DUE_COUNT due items are QUIET. Quick skim or bump revisit dates."
else
  echo "💡 Recommendation: $DUE_COUNT item(s) due. Check manually where activity unknown."
fi
