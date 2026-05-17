# Research Targets

Active research directions, tracked by depth and recency.

**Depth levels:**
- 🔭 **scout** — aware of it, surface-level understanding
- 👁️ **following** — actively monitoring, have field notes
- 🔬 **deep-dive** — studied code/architecture, have detailed analysis

---

## Agent Memory

How agents persist, retrieve, and reason about past experience.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [memex](https://github.com/nickarella/memex) | 🔬 deep-dive | 2026-05-15 | We use this — slug-based cards, backlinks, semantic search. ⚙️ reference (our infra) |
| [hindsight](https://github.com/OpenViking/hindsight) | 🔬 deep-dive | 2026-05-15 | Rust+Go memory server. ⚙️ reference (contributed) |
| [claude-mem](https://github.com/thedotmack/claude-mem) | 🔬 deep-dive | 2026-04-26 | 50k⭐, AGPL. "Cynical Deletion" architecture studied |
| [OpenChronicle](https://github.com/Einsia/OpenChronicle) | 🔬 deep-dive | 2026-04-28 | 1.6k⭐, macOS-only, local-first memory for tool-capable LLMs |
| [harmonist](https://github.com/harmonist) | 🔬 deep-dive | 2026-05-15 | Memory secret scanning, 4-dim scoring. ⚙️ reference (adopted Durability+Reduction) |
| [caveman](https://github.com/caveman) | 🔬 deep-dive | 2026-04-26 | Token compression, 75% output reduction, conciseness-accuracy paradox |

| [gastownhall/beads](https://github.com/gastownhall/beads) | 👁️ following | 2026-05-14 | 23.6k⭐, storage schema refactoring, v1.0.4. See tracking table |
| [krusch-context-mcp](https://github.com/kruschdev/krusch-context-mcp) | 🔬 deep-dive | 2026-05-10 | 61⭐, Lakebase architecture (SQLite local + PG global), RAG failure mode taxonomy, temporal decay, nudgets. See wiki/projects/krusch-context-mcp.md |
| [mnem](https://github.com/Uranid/mnem) | 🔬 deep-dive | 2026-05-05 | 18⭐, Rust, versioned KG + hybrid GraphRAG + content-addressed CIDs, WASM-clean core. Best-in-class retrieval benchmarks. See wiki/projects/mnem.md |
| [ClawMem](https://github.com/yoloshii/ClawMem) | 🔬 deep-dive | 2026-05-11 | 158⭐, on-device memory layer for Claude Code + OpenClaw + Hermes. BM25+Vector+Graph hybrid, content-type half-lives, 3-layer merge safety, intent-classified search. See wiki/projects/clawmem.md |

**Key question:** What's the right abstraction for agent memory — documents, graphs, or episodes?

---

## Self-Evolving Agents

Agents that improve themselves through experience — the core of what we're building.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ACE (SambaNova) | 🔬 deep-dive | 2026-05-15 | beliefs→DNA architecture mirrors ours. ⚙️ reference (identity layer peer) |
| [GenericAgent](https://github.com/lsdefine/GenericAgent) | 🔬 deep-dive | 2026-05-14 | 11.2k⭐, conductor multi-agent orchestrator, code review principles, context budget tightening |
| [EvoMap/Evolver GEP](https://arxiv.org/abs/2604.15097) | 🔬 deep-dive | 2026-04-28 | Gene vs Skill (+4.1pp), GEP protocol, signal matching |
| TextGrad | 🔬 deep-dive | 2026-05-15 | Text-as-gradient paradigm. ⚙️ reference (theoretical foundation) |
| [agents-md](https://github.com/agents-md) | 🔬 deep-dive | 2026-05-15 | Agent identity via markdown. ⚙️ reference (related standard) |
| [Orb](https://github.com/KarryViber/Orb) | 🔬 deep-dive | 2026-05-17 | 63⭐, v0.6.0. Telemetry-backed skill lifecycle (draft→prod→stale→archive), 3-stage self-evolution (A/B/C), memory freshness. Solo dev, Claude-Code-only, best-in-class governance |


**Key insight:** We operate at the Identity layer — only us and ACE are here. Most work is at Model or Workflow layers. GEP research validates: compact control-oriented format (Gene ~230 tokens) outperforms verbose doc-oriented format (Skill ~2,500 tokens) by +4.1pp.

---

## Coding Agents & Context Efficiency

How coding agents manage context, edits, and tool design.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [dirac](https://github.com/dirac-run/dirac) | 🔬 deep-dive | 2026-04-30 | Cline fork, hash-anchored edits, 1k⭐, reliability iteration phase |
| [reasonix](https://github.com/esengine/reasonix) | 🔬 deep-dive | 2026-04-27 | DeepSeek-native, 94% cache-first loop, flash-first + /pro arming |
| [nanobot](https://github.com/HKUDS/nanobot) | 🔬 deep-dive | 2026-05-14 | 42.4k⭐, model failover with fallback_models, MCP probe fix, live thread rendering |
| [TACO](https://github.com/multimodal-art-projection/TACO) | 🔬 deep-dive | 2026-05-10 | 33⭐, self-evolving regex compression rules for terminal output, paper-backed (arXiv:2604.19572), +1-4% on TerminalBench |




**Key insight (Dirac):** Context curation is a multiplier — less context = better reasoning = lower cost. AST-native reads (file skeleton → drill into function) outperform full-file reads.

---

## Agent Infrastructure

The plumbing that makes agents reliable, deployable, and composable.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Hermes](https://github.com/NousResearch/hermes-agent) | 🔬 deep-dive | 2026-04-30 | ~125k⭐, TUI polish + /compress async + ComfyUI built-in |
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-05-15 | We contribute here — Go+TS context server. ⚙️ reference (our infra) |
| [agentic-stack](https://github.com/codejunkie99/agentic-stack) | 🔬 deep-dive | 2026-05-14 | 1.97k⭐, v0.18.0, Brain memory bridge, brew formula |
| [poco-claw](https://github.com/poco-ai/poco-claw) | 🔬 deep-dive | 2026-05-11 | 1.3k⭐, direct OpenClaw competitor; Web UI + Docker sandbox + Claude Agent SDK + channel collab + mem0 memory. 4-layer identity split, single-writer rule. See wiki/projects/poco-claw.md |
| [ironcurtain](https://github.com/provos/ironcurtain) | 🔭 scout | 2026-05-11 | 391⭐, constitutional security for agents. English intent → deterministic rules → MCP policy enforcement. V8 isolate + Docker. See wiki/projects/ironcurtain.md |

| [superpowers](https://github.com/nickarella/superpowers) | 🔬 deep-dive | 2026-05-15 | Agent capability framework. ⚙️ reference |


**Key gap:** Skill auto-extraction — AgentFactory and OpenSpace have it, we don't.

---

## Frontier Models

| Model/Provider | Depth | Last Updated | Notes |
|---------------|-------|-------------|-------|
| Claude (Anthropic) | 👁️ following | 2026-05-15 | Primary model, Claude Code studied in depth. ⚙️ reference |
| DeepSeek v4 | 👁️ following | 2026-05-15 | Reasonix built model-native on it; flash-first economics. ⚙️ reference |


---

## Skill Ecosystem

How agent skills are packaged, discovered, shared, and composed.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ClawHub | 🔬 deep-dive | 2026-05-15 | Our skill marketplace. ⚙️ reference (our infra) |
| Claude Code skills | 👁️ following | 2026-05-15 | 39k+ skills on GitHub. ⚙️ reference (ecosystem context) |
| Moltbook | 🔬 deep-dive | 2026-05-15 | Reputation system for agents. ⚙️ reference (our project) |
| [wanman](https://github.com/wanman) | 🔬 deep-dive | 2026-04-27 | Hosted skill self-evolution, run_feedback→metrics→autoPromote pipeline |

**Key insight (Luna):** "Skills are essentially installable packages." The ecosystem is exploding — 39k+ Claude Code skills on GitHub as of 2026-03.

---

## Trending / Discovery

Hot repos spotted from GitHub trending or community buzz. Filtered for relevance to our world (coding agents, agent infra, orchestration, memory, evolution, skill ecosystem, dev tools). Not pre-categorized — if something grows legs, move it to a proper section above.

| Project | ⭐ | Spotted | Category | Notes |
|---------|-----|---------|----------|-------|
| [superset](https://github.com/superset-sh/superset) | ~new | 04-30 | Agent orchestration | Parallel coding agents via git worktree, desktop terminal. Compare with OpenClaw ACP/subagent model |

---

## Tracking (revisit dates)

Projects being monitored for growth/activity signals:

| Project | ⭐ | Last Check | Revisit | Signal Watching |
|---------|-----|-----------|---------|-----------------|

| agentic-stack | 1,984 | 05-16 | 05-22 | v0.18.0 settling. Brew formula audit. Brain bridge landed. Our PR#49 merged. 🟢 STABLE |
| GenericAgent | 11,527 | 05-16 | 05-21 | v0.1.0 Desktop App (Windows, aiohttp bridge). TUI polish (scrolling, rewind, streaming). memory_management.py (#381) L1↔L2/L3 sync automation. +4.5% in 4d. Multi-frontend transition |
| nanobot | 42,549 | 05-16 | 05-21 | /goal command merged (#3788, 4.8k lines): chat-scoped sustained goal state + WebUI. Signal channel (#3852). Atomic Chat local provider. Python 3.13/3.14 only. Steady growth |
| dirac | 1,190 | 05-17 | 05-24 | PRs #101-104 merged (external contributors: suzaku, LuminairPrime). Minor fixes: icon, Windows auth raw mode, dead code cleanup, isFirstRequest simplification. No new release. Steady maintenance |

| bux | 331 | 05-17 | 05-24 | 331⭐ (+11). Active 05-16: Mini App concept lab rework, scroll reels. Still pivoting toward platform. Steady |
| OpenChronicle | 2,623 | 05-16 | 05-23 | +21% stars (2167→2623). External PR#25 merged (compact fix). Issues #29-30 show community engagement (datetime fix, capture exclusions). Still macOS-only |

| mercury-agent | 2,231 | 05-17 | 05-24 | 2,231⭐ (+89). No commits since 05-10. Last release v1.1.6 (05-06). 🟢 THRIVING community (6/6): 29 issue authors, 31 external PRs/30d. Quiet week but strong base |
| Orb (KarryViber) | 63 | 05-17 | 05-24 | v0.6.0 (05-14): 3-stage self-evolution pipeline (A/B/C), telemetry-backed skill lifecycle (draft→prod→stale→archive), memory freshness states, permission-blocker scan. Solo dev, Slack-only. Architecturally best-in-class Claude Code wrapper |


## Chat-to-Knowledge Infrastructure

How team chat becomes structured knowledge — the "compile once, query many" pattern.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Beever Atlas](https://github.com/Beever-AI/beever-atlas) | 🔬 deep-dive | 2026-04-30 | 191⭐, Google ADK, dual-memory (Weaviate+Neo4j), 3-tier semantic, wiki-first RAG |
| [lazar](https://github.com/jasonkneen/lazar) | 🔬 deep-dive | 2026-05-07 | 19⭐, Rust, purest thin-harness: 1 tool (bash), immutable kernel, verify contract, hook system. macOS-only. See wiki/projects/lazar.md |
| TrustClaw (ComposioHQ) | 596 | 05-15 | 05-21 | +4.2%. Trust boundary hardening (PRs #25-26): compaction/scheduled-task/continuity injection defenses. Maturing security posture. Direct OpenClaw competitor |
