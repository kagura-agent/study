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

- [x] **GenericAgent "diminishing returns signal"** — consecutive same-mode detection for study-saturation.sh — source: genericagent.md Goal Hive Master SOP §5 — applied: 2026-05-31 — added consecutive detection (2x yellow, 3x red) + recommendation engine deprioritization to study-saturation.sh

- [x] **Aegis Repair+Retirement dual-track for DNA evolution** — every new DNA rule must answer "what old rule does this retire?" Prevents unbounded accumulation. Added retirement check to: (1) beliefs-candidates.md promotion checklist, (2) graduation-pipeline.sh output, (3) AGENTS.md DNA Self-Governance section. — source: aegis.md (v1.2-1.3 Repair+Retirement pattern) — applied: 2026-06-03

- [x] **ai-memory M8 retention decay for retire-candidates.sh** — replace discrete bucket scoring with exponential decay: retention = e^(-λ*age) × recall_boost × recency_boost. Candidates 458→367 (-20%), max score 85→65, continuous differentiation. — source: ai-memory.md (M8 decay) — applied: 2026-06-03

- [x] **Aegis workflow-quality-matrix "fast-path cheapness" check** — behavioral test suite for DNA rules: rule count/density, fast-path cheapness (5 representative simple tasks), rule overlap detection, growth rate tracking, retirement health. Script: `tools/dna-overhead-check.sh`. Integrated into review.yaml dna_review step 0. — source: aegis.md (workflow-quality-matrix.json) — applied: 2026-06-03

- [x] **Alibaba OCR language-specific review rules** — inject language-specific checklists (TypeScript, Go, Python, Rust) into reviewer prompts based on PR diff file types. Created `rules/` directory with 4 rule files, `rule-inject.sh` script, updated `workflow.yaml` `load_prompt` node. — source: alibaba-open-code-review.md — applied: 2026-06-05

- [x] **GenericAgent Ĵ≠J* goal drift check for reflection** — added "目标漂移检查" step to both reflect.yaml (think node, step 5) and workloop.yaml (reflect node, between success/failure analysis). Forces explicit goal alignment verification: "Am I solving the actual problem or confidently solving the wrong one?" — source: genericagent.md (control theory framework, x.4⑤ check) — applied: 2026-06-05

- [x] **Alibaba OCR plan phase for code-review** — risk-categorized file triage before spawning reviewers. For PRs >5 files, auto-classify into High/Medium/Low risk and pass focus guidance to reviewers. Prevents wasting effort on lock files while rushing auth middleware. — source: alibaba-open-code-review.md — applied: 2026-06-05 — created `code-review/plan-review.sh`, added `plan_review` node to `code-review/workflow.yaml` between load_prompt and spawn_reviewers. Verified against cove #192 (12 files → 9 high, 2 medium, 1 low) and #191 (2 files → skip).

- [x] **LLM-Wiki Error Book structural enforcement for scout-precheck** — created tools/scout-precheck.sh + integrated into study.yaml (scout step 8, deep_read step 6). Addresses 27x recidivism of scout-target-wiki-precheck. — source: llm-wiki-paper.md — applied: 2026-06-07

- [x] **mnem token-budget transparency for wiki search** — added retrieval pipeline counters (docs scanned, keyword hits, MIN_MATCH qualified, dropped, semantic candidates) to wiki/search.sh summary output. Every search now shows the full funnel: `Pipeline: N docs → M hits → K qualified (D dropped) | S semantic`. Enables diagnosing search quality issues (too-broad matching vs aggressive filtering vs missing semantic coverage). — source: mnem.md (token_budget transparency, candidates_seen/dropped) — applied: 2026-06-07

- [x] **Quarq Argus dynamic retrieval thresholds** — MIN_MATCH adjusts based on query intent: historical=40% (broad recall), current=80% (strict precision), default=60%. Maps to Quarq's deep vs standard mode. Benchmark 100% maintained. — source: quarq-argus-agent.md — applied: 2026-06-10

- [x] **Co-activation boost for wiki search** — docs frequently surfaced together in past searches get ranked higher (log2-scaled boost, capped +2.0). Built from .recall-log co-occurrence data (778 sessions, 1236 pairs). Two-pass ranking in search.sh + periodic rebuild via build-coactivation-index.py. Benchmark 100%/100%. — source: clawmem.md — applied: 2026-06-11

- [x] **Content-type half-lives for wiki search** — different content types decay at different rates in search ranking: cards 0.3× (slower), scouts/patrols 2× (faster), dated project notes 1.5× (moderate-fast), deep reads 0.7× (slower). Benchmark 100%/100% maintained. — source: ClawMem pattern (ai-memory.md) — applied: 2026-06-10

- [x] **guard-skills 14 AI failure modes as universal code-review checklist** — research-backed catalog of systematic AI code generation failures (error swallowing, hallucinated APIs, premature abstraction, etc.) injected into every code review regardless of language. Created `code-review/rules/ai-failure-modes.md` + modified `rule-inject.sh` to always include it. — source: guard-skills.md — applied: 2026-06-10

- [x] **OpenLoop baseline regression gates** — structural gate that maps changed files to relevant benchmarks and blocks commits if baselines regress. Created `tools/regression-gate.sh` with 7 file→benchmark rules (search.sh→search-bench, AGENTS.md→dna-overhead, compress-output→smoke test, wiki-lint, graduation-pipeline, study-saturation, retire-candidates). Integrated into study.yaml apply node (step 4). Auto-detects from git diff or runs all with --all. — source: openloop-thu.md (baseline regression gates pattern) — applied: 2026-06-13

- [x] **Daily memory bloat compression** — patrol sections (虾信巡检 ×8, GitHub Patrol, Night Workloop, Channel Patrol) that conclude "no action needed" compressed into one-line summaries per category. Tool: `tools/compress-daily-memory.sh`. Integrated into review.yaml memory_hygiene step 0. Tested on 2 days: 2160→1892 lines (-13%), 1916→1707 lines (-11%). — source: self-evolving-observations.md (daily memory 膨胀 2148 行/日, 40% redundant) — applied: 2026-06-14

- [x] **Architect-loop "Disagreement is mandatory" (Phase 0 spec pushback)** — require agents to review spec against actual code and raise conflicts before implementing. Silent compliance = defect. Added Phase 0 section to team-lead/SKILL.md + AGENTS.md Claude Code prompt guidelines. — source: architect-loop.md Rule #3 — applied: 2026-06-14

- [x] **Ponytail YAGNI 6-rung ladder for Claude Code prompts** — 6-step minimalism check (YAGNI → stdlib → native → existing dep → one-liner → minimum code) + `ponytail:` upgrade path comments. Added to AGENTS.md and team-lead/SKILL.md. — source: ponytail-yagni-skill.md — applied: 2026-06-14

- [x] **why-was-fable-banned grade-scaling for Phase 0 spec pushback** — replaced blanket Phase 0 ("every task gets it including simple fixes") with LIGHT/STANDARD/HEAVY tiers in AGENTS.md + team-lead/SKILL.md. Structural auto-escalation: ≥2 files → STANDARD min; auth/migration/schema/secret paths → HEAVY min. LIGHT tasks skip Phase 0 entirely (only require runnable acceptance check); HEAVY adds must_read evidence + ≥2 rejected_alternatives + risks + monotonic forbidden_paths. — source: why-was-fable-banned.md + grade-scaling-enforcement gradient (2026-06-17) — applied: 2026-06-17

- [x] **Competing PR early check script** — structural gate (tools/competing-pr-check.sh) that detects competing/merged/closed PRs + verifies issue state before implementation. Integrated into workloop.yaml find_work + study nodes as mandatory checks. — source: competing-pr-early-check gradient (inspector#32371) — applied: 2026-06-16

- [x] **Compass-skills fact-vs-decision constraint split for Phase 0** — classify each constraint as fact-inferrable (resolve from code) vs user-owned-decision (flag, don't assume). Added to AGENTS.md STANDARD/HEAVY Phase 0 prompts + team-lead/SKILL.md STANDARD/HEAVY templates. — source: compass-skills.md — applied: 2026-06-18

- [x] **Followup pre-check aggregation** — consolidated tracking-due + tracking-activity + tracking-health into single followup-status.sh. 3 tool calls → 1, unified per-item view with inline activity status. Updated study.yaml followup node. — source: study-followup-precheck-aggregation gradient — applied: 2026-06-19
