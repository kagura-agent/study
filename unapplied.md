# Unapplied Insights Backlog

Aggregated from wiki/projects/ notes — insights marked "could adopt/borrow/integrate" but not yet applied.
When doing study apply rounds, scan this file first instead of grepping 80+ project files.

**Format:** `- [ ] <insight> — source: <project note> — added: <date>`

---

- [x] **GenericAgent goal_mode budget pattern** — time budget + turn cap + wrap-up on exhaustion for subagent spawning — source: genericagent.md — applied: 2026-05-14 — added Subagent Budget Constraints section to team-lead/SKILL.md: runTimeoutSeconds guidance (120-900s by task type), wrap-up instruction template, timeout handling protocol.

## Retrieval / Search

- [x] **Recall-frequency boost for search ranking** — notes frequently returned by past searches get a small log-scaled ranking bonus (log2(1+count)*0.75, capped +1.5). Index files excluded to prevent breadth-based inflation. Benchmark 100%/100% maintained. — source: Orb v0.6.0 telemetry-backed skill lifecycle — applied: 2026-05-20

- [x] **CJK-to-English bridge for memex BM25** — memex BM25 can't tokenize CJK, so Chinese queries returned nothing. Added cjk_bridge() with 35-term domain mapping table that auto-translates Chinese → English when memex returns empty. Benchmark 100% maintained. — source: brain-rust bilingual search gap — applied: 2026-05-18
- [x] **Orb recall frequency logging** — track which wiki notes are actually returned by search, enabling data-driven staleness decisions. Log format: timestamp|intent|query|slugs. Companion recall-report.sh for hot/cold analysis. — source: orb.md (v0.6.0 telemetry-backed skill lifecycle) — applied: 2026-05-18 — added to wiki/search.sh + wiki/scripts/recall-report.sh
- [x] **Elephant Agent intent-aware recall reranking** — classify query intent (recent/historical/current/neutral) and adjust temporal decay rate accordingly. Recent queries get stronger decay (δ=0.35), historical queries preserve old notes (δ=0.05), current queries heavily favor fresh (δ=0.50). — source: elephant-agent.md — applied: 2026-05-18 — added `classify_intent()` and `get_decay_rate()` to wiki/search.sh, intent displayed in output, benchmark still 100%.

## Infrastructure / Architecture

- [x] **Poco-claw 4-layer identity split** (identity/preset/state/runtime) — our SOUL.md conflates these — source: poco-claw.md — added: 2026-05-11 → **retracted 2026-05-14** (rationale: Analyzed and determined it would be cosmetic — AGENTS.md is loaded as project context regardless of file splits, so no token savings or behavioral change)
- [x] **Agentic-stack semantic lesson retraction** — append-only status transitions (accepted → retracted + rationale) for beliefs-candidates.md. Don't delete superseded entries, mark them retracted with rationale. Audit trail without destructive edits. — source: agentic-stack.md — applied: 2026-05-17 — added Status Lifecycle section to beliefs-candidates.md: 3-state model (candidate/graduated/retracted), migrated existing entries, prevents re-learning rejected lessons
- [x] **Poco-claw single-writer rule** — subagents can concurrently write to workspace without coordination — source: poco-claw.md — applied: 2026-05-13 — added Concurrent Work Guard section to team-lead/SKILL.md: mandatory worktree isolation, preflight path-overlap check, re-read gate after subagent return. Merged insights from Hermes 3-layer defense (concurrent-agent-file-coordination card) and paragents preflight intent (worktree-convergence card).
- [x] **Lakebase pattern** (local SQLite cache + remote durable store with async sync) — if we move beyond flat files — source: krusch-context-mcp.md — added: 2026-05-11 → **deferred indefinitely** (flat files work fine for current scale)
- [x] **Elephant Agent auto-retire** — staleness scoring combining age + recall frequency + status + orphan links, with log maturity adjustment. Surfaces wiki notes that are old, never searched, orphaned, and have dropped/stale status. — source: elephant-agent.md — applied: 2026-05-19 — created `wiki/scripts/retire-candidates.sh`, integrated into review.yaml memory_hygiene step (weekly Monday scan)
- [x] **Brain-rust NFKC + zero-width strip** for secret scanning — normalize text before regex matching to catch Unicode evasion (zero-width splits, fullwidth chars) — source: brain-rust.md — applied: 2026-05-17 — added to wiki-lint.py check 9: `normalize_for_scan()` (NFKC + zero-width strip), verified 3/4 evasion vectors caught
- [x] **Invincat invalid-fact scanner** — regex-based self-invalidation detection for wiki-lint.py — source: invincat.md — applied: 2026-05-16 — added check 12 to wiki-lint.py: 7 high-precision patterns (self-referential invalidation, header markers, migration notices, replaced-by links, Chinese equivalents). 133→3 hits after tightening (zero false positives). Catches 3 genuine stale stubs.
- [x] **Temporal decay** for wiki/memory retrieval — applied: mtime-based recency sort in search.sh keyword results. Not exponential decay but achieves same goal: recent notes rank higher. — source: krusch-context-mcp.md — applied: 2026-05-12. **Enhanced 2026-05-13**: upgraded to true exponential decay (δ=0.17/week, Darr et al.) + maturity weights from frontmatter status/depth fields (active=1.3×, deep-dive=1.15× bonus, dropped=0.4×). Source: agentops.md decay-ranked retrieval.
- [x] **Livecache bench** — systematically benchmark cache performance — source: whale-deepseek-agent.md — applied: 2026-05-14 — created `tools/search-bench.sh` (10-query precision benchmark), found and fixed 4 critical search issues: memex missing projects/ dir, strict ALL-word intersection, ranking ignoring term relevance, missing slug-match boost. Precision: 50%→70% queries, 47%→76% items. **Enhanced 2026-05-15**: 3 more structural fixes (expanded stopwords, slug priority +100 for 2+ matches, doc-length normalization via (50/lines)^0.3). Precision: 70%→100% queries, 76%→100% items.
- [x] **Domain-specific context compression** — preserve task IDs, PR numbers, file paths during compression — source: runbook-hermes.md — applied: 2026-05-12 — enhanced `tools/compress-output.sh` with `extract_domain_ids()`: extracts refs (#PR/#issue), file paths, git SHAs from compressed-away lines and preserves them in the compression summary. Type-aware: test output only extracts from FAIL lines (PASS files are noise), SHAs skipped for test type.

## Study / Evaluation

- [x] **Confidence scale** (🟢/🟡/🔴) for wiki notes and audit outputs — source: reversa.md — applied: 2026-05-13 — integrated into search.sh: keyword results now show `[depth | status | ✓verified_date]` badges from frontmatter, enabling instant quality assessment of search results. Depth field maps to Reversa's confidence tiers (deep-dive=🟢, scout=🟡, no-metadata=🔴). Next: consider adding markers to audit/report generation.
- [x] **TACO seed rules + evolution for exec output compression** — regex compression with confidence + feedback loop — source: taco-context-compression.md — applied: 2026-05-12 — created `tools/compress-output.sh` with 6 type-specific rule sets (npm/pip/git/test/build/generic), auto-detection, 70-84% compression on test output

## Applied ✅

- [x] **Hybrid retrieval** (cosine + keyword) for wiki search — created search.sh — source: krusch-context-mcp.md — applied: 2026-05-11

## Review / Observability

- [x] **Dreamer diff-scoped review** — "Context Phase only touches what changed" principle applied to review.yaml tool_review step. Added review-diff-check.sh pre-check: git-diff identifies changed tool/DNA/workflow files in last 24h, only those get deep inspection. Unchanged tools get one-line pass. Reduces token waste on quiet days. — source: dreamer.md — applied: 2026-05-20

## Meta / Workflow

- [x] **Followup daily cap** — add ≥4/day saturation rule to study.yaml entry node, preventing diminishing-return followup loops — source: 05-14 reflection (24 study sessions, 7+ followups with zero new signals in later rounds) — applied: 2026-05-15 — added followup ≥4 cap + global saturation gate (all modes locked → exit) to study.yaml

## Workflow / Efficiency

- [x] **Diff-scoped followup pre-filter** — check tracked repos' `pushed_at` before investing followup time. QUIET repos (no push since last check) skipped. tracking-activity.sh created, integrated into study.yaml followup step 0a3. — source: dreamer diff-scoped review + mirage-vfs truth.txt harness — applied: 2026-05-20

## Workflow Integration

- [x] **Integrate add-gradient.sh into workloop.yaml** — unified gradient write path in both gradient_gate node and step 2.5 instructions. All gradient writes now go through add-gradient.sh (dedup + JSONL logging + formatted output). — source: Elephant Agent PR #30 single-close-path + today's add-gradient.sh creation — applied: 2026-05-23

- [x] **Reflect workflow gradient integration** — reflect.yaml act node bypassed beliefs-candidates pipeline entirely, sending behavioral lessons directly to SOUL.md/AGENTS.md. Added mandatory add-gradient.sh (--source reflect) + gradient_gate node (same pattern as workloop.yaml). — source: self-evolving-observations.md (Issue #9, "reflect 本身仍不产 gradient") — applied: 2026-05-25

- [x] **SmallCode contract/done_guard pattern** — structural completion gate for subagent spawns: mandatory Done Contract with checkable assertions, hard gate (❌ = fix, not "done with caveats"), structured ✅/❌ report format — source: smallcode.md v1.1.0 — applied: 2026-05-26 — added Definition of Done section to team-lead/SKILL.md + structural-backpressure concept card

### Salient Mining SOP (from GenericAgent, 2026-05-26)
- **What**: Structured process to mine past user conversations for (1) emotional events (by tone, not content) and (2) activity lifecycle (ongoing vs disappeared)
- **How**: Incremental session scanning, persistent state across runs, activity knowledge layer as database not report
- **Relevance**: Could enhance our MEMORY.md curation — currently we don't systematically mine past conversations for emotional signals or track activity lifecycle changes
- **Key design**: "Activities" classified as ongoing or disappeared; same-name items collapse; emotion detection by tone not topic; "write before read" persistent state
- **Status**: ✅ Partially applied 2026-05-30 — created `tools/memory-lifecycle.sh` implementing the "ongoing vs disappeared" lifecycle distinction. Integrated into review.yaml memory_hygiene step (step 4: lifecycle check). Script detects stale promoted entries, flags lifecycle markers (paused/blocked/pending), checks line budget. Full session mining deferred (needs transcript access).

- [x] **add-gradient.sh source labeling for gradient-stats.sh** — source tag now written inline to beliefs-candidates.md when --source is not manual, enabling gradient-stats.sh Luna-sourced detection. gradient-stats.sh updated with dual detection (inline + detail-line + JSONL fallback). — source: self-evolving-observations.md 断裂处 — applied: 2026-05-29

- [x] **add-gradient.sh ↔ gradient-scan.sh consistency check** — warn when new gradient pattern has no KEYWORDS in gradient-scan.sh, preventing pipeline breakage where gradients are captured but scan is blind to them. Added as side-effect 3 in add-gradient.sh. — source: self-evolving-observations.md (05-29 断裂修复 post-mortem) — applied: 2026-05-30
