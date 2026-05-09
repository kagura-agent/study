#!/bin/bash
# tracking-community.sh — Community health signals for tracked projects
# 
# Checks: issue activity, contributor diversity, discussion presence,
# PR merge rate, and recent community engagement.
#
# Usage: bash tracking-community.sh <owner/repo> [owner/repo2 ...]
# Example: bash tracking-community.sh strukto-ai/mirage eight-acres-lab/skillplus
#
# Requires: gh CLI authenticated

set -uo pipefail

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <owner/repo> [owner/repo2 ...]"
  echo "Example: $0 strukto-ai/mirage eight-acres-lab/skillplus"
  exit 1
fi

TWO_WEEKS_AGO=$(date -d '14 days ago' +%Y-%m-%dT00:00:00Z 2>/dev/null || date -v-14d +%Y-%m-%dT00:00:00Z)
ONE_MONTH_AGO=$(date -d '30 days ago' +%Y-%m-%dT00:00:00Z 2>/dev/null || date -v-30d +%Y-%m-%dT00:00:00Z)

for REPO in "$@"; do
  echo "═══════════════════════════════════════════"
  echo "🏥 Community Health: $REPO"
  echo "═══════════════════════════════════════════"

  # --- Basic repo info ---
  REPO_INFO=$(gh api "repos/$REPO" --jq '{stars: .stargazers_count, forks: .forks_count, open_issues: .open_issues_count, has_discussions: .has_discussions, created: .created_at, pushed: .pushed_at}' 2>/dev/null)
  if [[ -z "$REPO_INFO" ]]; then
    echo "  ❌ Could not fetch repo info (not found or rate limited)"
    echo ""
    continue
  fi

  STARS=$(echo "$REPO_INFO" | jq -r '.stars')
  FORKS=$(echo "$REPO_INFO" | jq -r '.forks')
  OPEN_ISSUES=$(echo "$REPO_INFO" | jq -r '.open_issues')
  HAS_DISCUSSIONS=$(echo "$REPO_INFO" | jq -r '.has_discussions')
  PUSHED=$(echo "$REPO_INFO" | jq -r '.pushed')

  echo ""
  echo "📊 Overview:"
  echo "  ⭐ Stars: $STARS | 🍴 Forks: $FORKS | 📝 Open issues: $OPEN_ISSUES"
  echo "  📅 Last push: $PUSHED"
  echo "  💬 Discussions: $HAS_DISCUSSIONS"

  # --- Issue activity (last 14 days) ---
  echo ""
  echo "🐛 Issue Activity (last 14 days):"
  RECENT_ISSUES=$(gh api "repos/$REPO/issues?state=all&since=$TWO_WEEKS_AGO&per_page=100" --jq 'length' 2>/dev/null || echo "?")
  RECENT_ISSUES_OPEN=$(gh api "repos/$REPO/issues?state=open&since=$TWO_WEEKS_AGO&per_page=100" --jq '[.[] | select(.pull_request == null)] | length' 2>/dev/null || echo "?")
  RECENT_ISSUES_CLOSED=$(gh api "repos/$REPO/issues?state=closed&since=$TWO_WEEKS_AGO&per_page=100" --jq '[.[] | select(.pull_request == null)] | length' 2>/dev/null || echo "?")
  echo "  Recent issues (non-PR): $RECENT_ISSUES_OPEN open, $RECENT_ISSUES_CLOSED closed"

  # --- Issue authors (unique reporters, last 30 days) --- 
  echo ""
  echo "👥 Contributor Diversity (last 30 days):"
  ISSUE_AUTHORS=$(gh api "repos/$REPO/issues?state=all&since=$ONE_MONTH_AGO&per_page=100" --jq '[.[].user.login] | unique | length' 2>/dev/null || echo "?")
  echo "  Unique issue authors: $ISSUE_AUTHORS"

  # --- PR activity (external contributors) ---
  # Get actual maintainer (org → top contributor, user → owner)
  REPO_OWNER_TYPE=$(gh api "repos/$REPO" --jq '.owner.type' 2>/dev/null || echo "User")
  if [[ "$REPO_OWNER_TYPE" == "Organization" ]]; then
    MAINTAINER=$(gh api "repos/$REPO/contributors?per_page=1" --jq '.[0].login' 2>/dev/null || echo "")
  else
    MAINTAINER=$(gh api "repos/$REPO" --jq '.owner.login' 2>/dev/null || echo "")
  fi
  # gh api --jq doesn't support --arg, so pipe through jq
  EXTERNAL_PRS=$(gh api "repos/$REPO/pulls?state=all&per_page=100&sort=updated&direction=desc" 2>/dev/null | \
    jq --arg since "$ONE_MONTH_AGO" --arg maintainer "$MAINTAINER" \
    '[.[] | select(.updated_at > $since and .user.login != $maintainer)] | length' 2>/dev/null || echo "?")
  echo "  External PRs (last 30d): $EXTERNAL_PRS"

  # --- PR merge rate (last 30 merged PRs) ---
  echo ""
  echo "🔀 PR Merge Health:"
  MERGED_COUNT=$(gh api "repos/$REPO/pulls?state=closed&per_page=30&sort=updated&direction=desc" --jq '[.[] | select(.merged_at != null)] | length' 2>/dev/null || echo "?")
  CLOSED_UNMERGED=$(gh api "repos/$REPO/pulls?state=closed&per_page=30&sort=updated&direction=desc" --jq '[.[] | select(.merged_at == null)] | length' 2>/dev/null || echo "?")
  echo "  Last 30 closed PRs: $MERGED_COUNT merged, $CLOSED_UNMERGED rejected"

  # Unique PR authors (merged, last 30)
  PR_AUTHORS=$(gh api "repos/$REPO/pulls?state=closed&per_page=30&sort=updated&direction=desc" --jq '[.[] | select(.merged_at != null) | .user.login] | unique | length' 2>/dev/null || echo "?")
  echo "  Unique merged PR authors: $PR_AUTHORS"

  # --- Discussions (if enabled) ---
  if [[ "$HAS_DISCUSSIONS" == "true" ]]; then
    echo ""
    echo "💬 Discussions:"
    DISC_COUNT=$(gh api graphql -f query="
      query {
        repository(owner: \"$(echo $REPO | cut -d/ -f1)\", name: \"$(echo $REPO | cut -d/ -f2)\") {
          discussions(last: 10) {
            totalCount
            nodes { createdAt comments { totalCount } }
          }
        }
      }
    " --jq '.data.repository.discussions.totalCount' 2>/dev/null || echo "?")
    echo "  Total discussions: $DISC_COUNT"
    
    RECENT_DISC=$(gh api graphql -f query="
      query {
        repository(owner: \"$(echo $REPO | cut -d/ -f1)\", name: \"$(echo $REPO | cut -d/ -f2)\") {
          discussions(last: 10) {
            nodes { createdAt }
          }
        }
      }
    " 2>/dev/null | jq --arg since "$TWO_WEEKS_AGO" '[.data.repository.discussions.nodes[] | select(.createdAt > $since)] | length' 2>/dev/null || echo "?")
    echo "  Recent (14d): $RECENT_DISC"
  fi

  # --- Health verdict ---
  echo ""
  echo "🏷️  Health Verdict:"
  HEALTH="unknown"
  
  # Scoring
  SCORE=0
  [[ "$RECENT_ISSUES_OPEN" != "?" && "$RECENT_ISSUES_OPEN" -gt 0 ]] 2>/dev/null && SCORE=$((SCORE + 1))
  [[ "$ISSUE_AUTHORS" != "?" && "$ISSUE_AUTHORS" -gt 3 ]] 2>/dev/null && SCORE=$((SCORE + 1))
  [[ "$EXTERNAL_PRS" != "?" && "$EXTERNAL_PRS" -gt 0 ]] 2>/dev/null && SCORE=$((SCORE + 2))
  [[ "$PR_AUTHORS" != "?" && "$PR_AUTHORS" -gt 1 ]] 2>/dev/null && SCORE=$((SCORE + 1))
  [[ "$FORKS" != "?" && "$FORKS" -gt 10 ]] 2>/dev/null && SCORE=$((SCORE + 1))

  if [[ "$SCORE" -ge 5 ]]; then
    HEALTH="🟢 THRIVING — active community, external contributors"
  elif [[ "$SCORE" -ge 3 ]]; then
    HEALTH="🟡 GROWING — some community engagement"
  elif [[ "$SCORE" -ge 1 ]]; then
    HEALTH="🟠 NASCENT — mostly solo/small team"
  else
    HEALTH="🔴 SOLO — no external engagement signals"
  fi
  echo "  $HEALTH (score: $SCORE/6)"
  echo ""
done
