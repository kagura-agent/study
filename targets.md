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
| [TencentDB-Agent-Memory](https://github.com/Tencent/TencentDB-Agent-Memory) | 🔭 scout | 2026-05-22 | 3763⭐, Tencent. 4-tier progressive memory pipeline, fully local, zero external API deps. 20% merge rate, external PRs accepted. 32 open issues. |

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
| [Elephant Agent](https://github.com/agentic-in/elephant-agent) | 🔬 deep-dive | 2026-05-27 | 418⭐ (+33/day!), skill optimization pipeline (PR#43), macOS self-contained runtime + multimodal MCP, browser headless shell. 🟢 THRIVING, fastest growth in portfolio |


**Key insight:** We operate at the Identity layer — only us and ACE are here. Most work is at Model or Workflow layers. GEP research validates: compact control-oriented format (Gene ~230 tokens) outperforms verbose doc-oriented format (Skill ~2,500 tokens) by +4.1pp.

---

## Coding Agents & Context Efficiency

How coding agents manage context, edits, and tool design.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [dirac](https://github.com/dirac-run/dirac) | 🔬 deep-dive | 2026-04-30 | Cline fork, hash-anchored edits, 1k⭐, reliability iteration phase |
| [reasonix](https://github.com/esengine/reasonix) | 🔬 deep-dive | 2026-04-27 | DeepSeek-native, 94% cache-first loop, flash-first + /pro arming |
| [nanobot](https://github.com/HKUDS/nanobot) | 🔬 deep-dive | 2026-05-21 | 42.9k⭐, v0.2.0 released (105 PRs): /goal persistent context, image gen, WebUI in wheel, 5 new providers, fallback_models, core refactor. Revisit 05-28 |
| [TACO](https://github.com/multimodal-art-projection/TACO) | 🔬 deep-dive | 2026-05-10 | 33⭐, self-evolving regex compression rules for terminal output, paper-backed (arXiv:2604.19572), +1-4% on TerminalBench |
| [SmallCode](https://github.com/Doorman11991/smallcode) | 🔬 deep-dive | 2026-05-21 | 848⭐ (was 840). v0.7.0 86-bug security audit, v0.7.1 MarrowScript reorg. Community formed: 4 merged PR authors, 11 issue authors/30d. 🟢 THRIVING (5/6). Revisit 05-28 |




**Key insight (Dirac):** Context curation is a multiplier — less context = better reasoning = lower cost. AST-native reads (file skeleton → drill into function) outperform full-file reads.

---

## Agent Infrastructure

The plumbing that makes agents reliable, deployable, and composable.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Hermes](https://github.com/NousResearch/hermes-agent) | 🔬 deep-dive | 2026-04-30 | ~125k⭐, TUI polish + /compress async + ComfyUI built-in |
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-05-15 | We contribute here — Go+TS context server. ⚙️ reference (our infra) |
| [agentic-stack](https://github.com/codejunkie99/agentic-stack) | 🔬 deep-dive | 2026-05-14 | 1.97k⭐, v0.18.0, Brain memory bridge, brew formula |
| [poco-claw](https://github.com/poco-ai/poco-claw) | 🔬 deep-dive | 2026-05-28 | 1.3k⭐, direct OpenClaw competitor; Web UI + Docker sandbox + Claude Agent SDK + channel collab + mem0 memory. 4-layer identity split, single-writer rule. See wiki/projects/poco-claw.md. Revisit 05-28 |
| [ironcurtain](https://github.com/provos/ironcurtain) | 🔭 scout | 2026-05-11 | 391⭐, constitutional security for agents. English intent → deterministic rules → MCP policy enforcement. V8 isolate + Docker. See wiki/projects/ironcurtain.md |
| [eval-view](https://github.com/hidai25/eval-view) | 🔬 deep-dive | 2026-05-21 | 105⭐ (stable). v0.8.0 released (freshness, fleet, chaos, goal-drift modules). CLI auth loopback. Steady development. 🟢 THRIVING (5/6). Revisit 05-28 |

| [superpowers](https://github.com/nickarella/superpowers) | 🔬 deep-dive | 2026-05-15 | Agent capability framework. ⚙️ reference |
| [mirage](https://github.com/strukto-ai/mirage) | 🔭 scout | 2026-05-22 | 2538⭐, unified virtual filesystem for AI agents. TypeScript. 95% merge rate, external PRs accepted. 22 open issues. Agent infrastructure plumbing. |


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
| [ccglass](https://github.com/jianshuo/ccglass) | 239 | 05-25 | Agent observability | Local reverse-proxy + dashboard for coding agent traffic. Base-URL interception, turn-to-turn diff, MCP self-inspection. See wiki/projects/ccglass.md |
| [ai-memory](https://github.com/akitaonrails/ai-memory) | 159 | 05-25 | Agent memory | Rust, cross-vendor memory for coding CLIs. Vendor handoff angle unique |
| [TriMem](https://github.com/tmlr-group/TriMem) | 8 | 05-25 | Agent memory (research) | arxiv:2605.19952 "Beyond Atomic Facts in Lifelong LLM Agent Memory" |

---

## Tracking (revisit dates)

Projects being monitored for growth/activity signals:

| Project | ⭐ | Last Check | Revisit | Signal Watching |
|---------|-----|-----------|---------|-----------------|

| agentic-stack | 2,023 | 05-22 | 05-28 | 2023⭐. v0.18.0, quiet since 05-10 (12d). Brain bridge + semantic lesson retraction + Copilot support merged. 🟡 STABLE but cooling |
| GenericAgent | 12,041 | 05-25 | 05-28 | 12,041⭐ (+0.4%). Steady. 🟢 THRIVING |
| nanobot | 43,055 | 05-24 | 05-28 | v0.2.0 post-release: exec timeout uncap (#3595), transcription apiBase normalization (#3637). Docs polish. 🟢 THRIVING |
| dirac | 1,240 | 05-23 | 05-30 | 1,240⭐ (+4.2%). PRs #105-106 merged: ACP chunk-based review system (pleibers), generated-content fix (suzaku). External contributors still active. Steady growth |

| bux | 340 | 05-23 | 05-30 | 340⭐ (+2.7%). Pushed 05-21. Mini App platform pivot continues. Steady but slow |
| OpenChronicle | 2,749 | 05-23 | 05-30 | 2,749⭐ (+4.8%). No push since 05-09 (14d). Stars still growing but dev pace slowing. Still macOS-only. Watch for activity resumption |

| mercury-agent | 2,418 | 05-24 | 05-30 | Standalone binaries (PR#61, bun --compile). Shell injection fix (PR#48) merged. One-line installers. 🟢 THRIVING |
| Orb (KarryViber) | 65 | 05-23 | 05-30 | 65⭐ (+3.2%). QUIET — no push since 05-14. Solo dev. Growth stalled. Consider drop next cycle if no activity |
| Elephant Agent (agentic-in) | 459 | 05-25 | 05-28 | 459⭐ (+41 in 2d). Still thriving. 🟢 THRIVING |
| ccglass | 239 | 05-25 | 06-01 | 239⭐ in 3 days (~80/day). Coding agent observability proxy. Watch growth trajectory |


## Chat-to-Knowledge Infrastructure

How team chat becomes structured knowledge — the "compile once, query many" pattern.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Beever Atlas](https://github.com/Beever-AI/beever-atlas) | 🔬 deep-dive | 2026-04-30 | 191⭐, Google ADK, dual-memory (Weaviate+Neo4j), 3-tier semantic, wiki-first RAG |
| [lazar](https://github.com/jasonkneen/lazar) | 🔬 deep-dive | 2026-05-07 | 19⭐, Rust, purest thin-harness: 1 tool (bash), immutable kernel, verify contract, hook system. macOS-only. See wiki/projects/lazar.md |
| TrustClaw (ComposioHQ) | 702 | 05-23 | 05-30 | 702⭐ (+3.2%). No commits since 05-15 (8 days). Growth slowing further. Quiet phase |
