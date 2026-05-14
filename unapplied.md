# Unapplied Insights Backlog

Aggregated from wiki/projects/ notes — insights marked "could adopt/borrow/integrate" but not yet applied.
When doing study apply rounds, scan this file first instead of grepping 80+ project files.

**Format:** `- [ ] <insight> — source: <project note> — added: <date>`

---

## Infrastructure / Architecture

- [ ] **Poco-claw 4-layer identity split** (identity/preset/state/runtime) — our SOUL.md conflates these — source: poco-claw.md — added: 2026-05-11
- [x] **Poco-claw single-writer rule** — subagents can concurrently write to workspace without coordination — source: poco-claw.md — applied: 2026-05-13 — added Concurrent Work Guard section to team-lead/SKILL.md: mandatory worktree isolation, preflight path-overlap check, re-read gate after subagent return. Merged insights from Hermes 3-layer defense (concurrent-agent-file-coordination card) and paragents preflight intent (worktree-convergence card).
- [ ] **Lakebase pattern** (local SQLite cache + remote durable store with async sync) — if we move beyond flat files — source: krusch-context-mcp.md — added: 2026-05-11
- [x] **Temporal decay** for wiki/memory retrieval — applied: mtime-based recency sort in search.sh keyword results. Not exponential decay but achieves same goal: recent notes rank higher. — source: krusch-context-mcp.md — applied: 2026-05-12. **Enhanced 2026-05-13**: upgraded to true exponential decay (δ=0.17/week, Darr et al.) + maturity weights from frontmatter status/depth fields (active=1.3×, deep-dive=1.15× bonus, dropped=0.4×). Source: agentops.md decay-ranked retrieval.
- [x] **Livecache bench** — systematically benchmark cache performance — source: whale-deepseek-agent.md — applied: 2026-05-14 — created `tools/search-bench.sh` (10-query precision benchmark), found and fixed 4 critical search issues: memex missing projects/ dir, strict ALL-word intersection, ranking ignoring term relevance, missing slug-match boost. Precision: 50%→70% queries, 47%→76% items.
- [x] **Domain-specific context compression** — preserve task IDs, PR numbers, file paths during compression — source: runbook-hermes.md — applied: 2026-05-12 — enhanced `tools/compress-output.sh` with `extract_domain_ids()`: extracts refs (#PR/#issue), file paths, git SHAs from compressed-away lines and preserves them in the compression summary. Type-aware: test output only extracts from FAIL lines (PASS files are noise), SHAs skipped for test type.

## Study / Evaluation

- [x] **Confidence scale** (🟢/🟡/🔴) for wiki notes and audit outputs — source: reversa.md — applied: 2026-05-13 — integrated into search.sh: keyword results now show `[depth | status | ✓verified_date]` badges from frontmatter, enabling instant quality assessment of search results. Depth field maps to Reversa's confidence tiers (deep-dive=🟢, scout=🟡, no-metadata=🔴). Next: consider adding markers to audit/report generation.
- [x] **TACO seed rules + evolution for exec output compression** — regex compression with confidence + feedback loop — source: taco-context-compression.md — applied: 2026-05-12 — created `tools/compress-output.sh` with 6 type-specific rule sets (npm/pip/git/test/build/generic), auto-detection, 70-84% compression on test output

## Applied ✅

- [x] **Hybrid retrieval** (cosine + keyword) for wiki search — created search.sh — source: krusch-context-mcp.md — applied: 2026-05-11
