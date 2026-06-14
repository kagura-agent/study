#!/usr/bin/env bash
# tracking-update.sh — Automate targets.md row updates during followup rounds
#
# Replaces manual editing of dates, notes, depth, and star counts in targets.md.
# Addresses gradient: missing-automation (06-11)
# Inspired by: loop-engineering "reduce manual toil in repetitive loops" principle
#
# Usage:
#   tracking-update.sh <project-name> [options]
#   tracking-update.sh beads --stars 25000 --notes "v1.1.0 released"
#   tracking-update.sh mnem --depth deep-dive --notes "WASM support added"
#   tracking-update.sh claude-mem --date  # just touch the date
#   tracking-update.sh --list             # show all tracked projects
#   tracking-update.sh --stale [days]     # show projects not updated in N days (default 14)
#
# Options:
#   --date           Update "Last Updated" to today (default: always updates date)
#   --depth LEVEL    Change depth: scout | following | deep-dive
#   --stars N        Update star count in notes
#   --notes TEXT     Append to notes (or replace if --replace-notes)
#   --replace-notes  Replace notes entirely instead of appending
#   --drop           Mark as dropped
#   --list           List all tracked projects with dates
#   --stale [N]      Show projects not updated in N days (default 14)
#   --dry-run        Show what would change without modifying

set -euo pipefail

TARGETS_FILE="${HOME}/.openclaw/workspace/study/targets.md"
TODAY=$(date +%Y-%m-%d)

# Depth emoji mapping
depth_emoji() {
  case "$1" in
    scout)     echo "🔭 scout" ;;
    following)  echo "👁️ following" ;;
    deep-dive) echo "🔬 deep-dive" ;;
    *) echo "$1" ;;
  esac
}

# Parse args
PROJECT=""
DEPTH=""
STARS=""
NOTES=""
REPLACE_NOTES=false
DROP=false
LIST=false
STALE=false
STALE_DAYS=14
DRY_RUN=false
UPDATE_DATE=true

while [[ $# -gt 0 ]]; do
  case "$1" in
    --depth) DEPTH="$2"; shift 2 ;;
    --stars) STARS="$2"; shift 2 ;;
    --notes) NOTES="$2"; shift 2 ;;
    --replace-notes) REPLACE_NOTES=true; shift ;;
    --drop) DROP=true; shift ;;
    --date) shift ;;  # date always updates, this is a no-op for clarity
    --list) LIST=true; shift ;;
    --stale) STALE=true; STALE_DAYS="${2:-14}"; [[ "${2:-}" =~ ^[0-9]+$ ]] && shift; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    -*) echo "❌ Unknown option: $1"; exit 1 ;;
    *) PROJECT="$1"; shift ;;
  esac
done

# --- List mode ---
if $LIST; then
  echo "📋 Tracked Projects in targets.md"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  grep -P "^\| \[" "$TARGETS_FILE" | while IFS='|' read -r _ name depth date notes _rest; do
    name=$(echo "$name" | sed 's/.*\[\(.*\)\].*/\1/' | xargs)
    depth=$(echo "$depth" | xargs)
    date=$(echo "$date" | xargs)
    notes=$(echo "$notes" | head -c 60 | xargs)
    printf "  %-25s %-16s %s  %s\n" "$name" "$depth" "$date" "$notes"
  done
  echo ""
  total=$(grep -cP "^\| \[" "$TARGETS_FILE" 2>/dev/null || echo 0)
  echo "Total: $total projects"
  exit 0
fi

# --- Stale mode ---
if $STALE; then
  echo "⏰ Projects not updated in ${STALE_DAYS}+ days (as of $TODAY)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  cutoff_epoch=$(date -d "$TODAY - ${STALE_DAYS} days" +%s 2>/dev/null || date -d "${STALE_DAYS} days ago" +%s)
  found=0
  grep -P "^\| \[" "$TARGETS_FILE" | while IFS='|' read -r _ name depth date notes _rest; do
    name_clean=$(echo "$name" | sed 's/.*\[\(.*\)\].*/\1/' | xargs)
    date_clean=$(echo "$date" | xargs)
    date_epoch=$(date -d "$date_clean" +%s 2>/dev/null || echo 0)
    if [[ $date_epoch -le $cutoff_epoch && $date_epoch -gt 0 ]]; then
      days_ago=$(( ($(date +%s) - date_epoch) / 86400 ))
      depth_clean=$(echo "$depth" | xargs)
      printf "  %-25s %-16s %s (%dd ago)\n" "$name_clean" "$depth_clean" "$date_clean" "$days_ago"
      found=1
    fi
  done
  [[ $found -eq 0 ]] && echo "  ✅ All projects updated within ${STALE_DAYS} days"
  exit 0
fi

# --- Update mode ---
if [[ -z "$PROJECT" ]]; then
  echo "❌ Project name required"
  echo "Usage: tracking-update.sh <project-name> [--depth LEVEL] [--stars N] [--notes TEXT]"
  echo "       tracking-update.sh --list"
  echo "       tracking-update.sh --stale [days]"
  exit 1
fi

# Find the project row (case-insensitive match on project name within markdown link)
# First try exact match at start of link text, then anywhere in link text
line_num=$(grep -niP "^\| \[${PROJECT}\b" "$TARGETS_FILE" 2>/dev/null | head -1 | cut -d: -f1 || true)

if [[ -z "$line_num" ]]; then
  # Try match anywhere in the link text (handles org/repo format like gastownhall/beads)
  line_num=$(grep -niP "^\| \[.*${PROJECT}[^]]*\]" "$TARGETS_FILE" 2>/dev/null | head -1 | cut -d: -f1 || true)
fi

if [[ -z "$line_num" ]]; then
  # Try match in the URL part
  line_num=$(grep -niP "^\|.*${PROJECT}" "$TARGETS_FILE" 2>/dev/null | head -1 | cut -d: -f1 || true)
fi

if [[ -z "$line_num" ]]; then
  echo "❌ Project '${PROJECT}' not found in targets.md"
  echo "   Available projects:"
  grep -oP "^\| \[\K[^\]]+" "$TARGETS_FILE" | while read -r p; do echo "     $p"; done
  exit 1
fi

# Extract current row
current_line=$(sed -n "${line_num}p" "$TARGETS_FILE")
echo "📍 Found: $current_line"

# Parse current fields
IFS='|' read -r _ col_name col_depth col_date col_notes _ <<< "$current_line"
old_depth=$(echo "$col_depth" | xargs)
old_date=$(echo "$col_date" | xargs)
old_notes=$(echo "$col_notes" | xargs)

# Build new values
new_date="$TODAY"
new_depth="$old_depth"
new_notes="$old_notes"

if [[ -n "$DEPTH" ]]; then
  new_depth=$(depth_emoji "$DEPTH")
fi

if $DROP; then
  new_notes="**Dropped** ${TODAY}. ${old_notes}"
fi

if [[ -n "$STARS" ]]; then
  # Format stars: 25000 → 25k, 1500 → 1.5k, 500 → 500
  if [[ $STARS -ge 1000 ]]; then
    formatted=$(awk "BEGIN{printf \"%.1f\", $STARS/1000}" | sed 's/\.0$//')
    formatted="${formatted}k"
  else
    formatted="$STARS"
  fi
  # Update star count in notes: replace patterns like "24.5k⭐" or "500⭐" or "3,763⭐"
  if echo "$new_notes" | grep -qP '[0-9][0-9.,]*[kK]?⭐'; then
    new_notes=$(echo "$new_notes" | sed -E "s/[0-9][0-9.,]*[kK]?⭐/${formatted}⭐/")
  else
    # No existing star count, prepend
    new_notes="${formatted}⭐. ${new_notes}"
  fi
fi

if [[ -n "$NOTES" ]]; then
  if $REPLACE_NOTES; then
    new_notes="$NOTES"
  else
    new_notes="${new_notes}. ${NOTES}"
  fi
fi

# Build new row (preserve the name/link column exactly)
new_line="| $(echo "$col_name" | xargs) | ${new_depth} | ${new_date} | ${new_notes} |"

# Show diff
echo ""
echo "📝 Changes:"
[[ "$old_depth" != "$new_depth" ]] && echo "   Depth: $old_depth → $new_depth"
[[ "$old_date" != "$new_date" ]] && echo "   Date:  $old_date → $new_date"
[[ "$old_notes" != "$new_notes" ]] && echo "   Notes: updated"

if $DRY_RUN; then
  echo ""
  echo "🔍 Dry run — would write:"
  echo "   $new_line"
  exit 0
fi

# Apply change
sed -i "${line_num}s|.*|${new_line}|" "$TARGETS_FILE"

echo ""
echo "✅ Updated ${PROJECT} in targets.md"
echo "   $new_line"
