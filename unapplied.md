# Unapplied Insights Backlog

Aggregated from wiki/projects/ notes — insights marked "could adopt/borrow/integrate" but not yet applied.
When doing study apply rounds, scan this file first instead of grepping 80+ project files.

**Format:** `- [ ] <insight> — source: <project note> — added: <date>`

---

## Infrastructure / Architecture

- [ ] **Poco-claw 4-layer identity split** (identity/preset/state/runtime) — our SOUL.md conflates these — source: poco-claw.md — added: 2026-05-11
- [ ] **Poco-claw single-writer rule** — subagents can concurrently write to workspace without coordination — source: poco-claw.md — added: 2026-05-11
- [ ] **Lakebase pattern** (local SQLite cache + remote durable store with async sync) — if we move beyond flat files — source: krusch-context-mcp.md — added: 2026-05-11
- [x] **Temporal decay** for wiki/memory retrieval — applied: mtime-based recency sort in search.sh keyword results. Not exponential decay but achieves same goal: recent notes rank higher. — source: krusch-context-mcp.md — applied: 2026-05-12
- [ ] **Livecache bench** — systematically benchmark cache performance — source: whale-deepseek-agent.md — added: 2026-05-11
- [x] **Domain-specific context compression** — preserve task IDs, PR numbers, file paths during compression — source: runbook-hermes.md — applied: 2026-05-12 — enhanced `tools/compress-output.sh` with `extract_domain_ids()`: extracts refs (#PR/#issue), file paths, git SHAs from compressed-away lines and preserves them in the compression summary. Type-aware: test output only extracts from FAIL lines (PASS files are noise), SHAs skipped for test type.

## Study / Evaluation

- [ ] **Confidence scale** (🟢/🟡/🔴) for wiki notes and audit outputs — source: reversa.md — added: 2026-05-11
- [x] **TACO seed rules + evolution for exec output compression** — regex compression with confidence + feedback loop — source: taco-context-compression.md — applied: 2026-05-12 — created `tools/compress-output.sh` with 6 type-specific rule sets (npm/pip/git/test/build/generic), auto-detection, 70-84% compression on test output

## Applied ✅

- [x] **Hybrid retrieval** (cosine + keyword) for wiki search — created search.sh — source: krusch-context-mcp.md — applied: 2026-05-11
