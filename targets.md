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
| [memex](https://github.com/nickarella/memex) | 🔬 deep-dive | 2026-04 | We use this — slug-based cards, backlinks, semantic search |
| [hindsight](https://github.com/OpenViking/hindsight) | 👁️ following | 2026-04 | Rust+Go memory server, integration tested |
| [claude-mem](https://github.com/thedotmack/claude-mem) | 🔬 deep-dive | 2026-04-26 | 50k⭐, AGPL. "Cynical Deletion" architecture studied |
| [OpenChronicle](https://github.com/Einsia/OpenChronicle) | 🔬 deep-dive | 2026-04-28 | 1.6k⭐, macOS-only, local-first memory for tool-capable LLMs |
| [harmonist](https://github.com/harmonist) | 👁️ following | 2026-04 | Memory secret scanning, 4-dim scoring (Novelty/Durability/Specificity/Reduction) |
| [caveman](https://github.com/caveman) | 🔬 deep-dive | 2026-04-26 | Token compression, 75% output reduction, conciseness-accuracy paradox |
| [auto-memory](https://github.com/auto-memory) | 🔭 scout | 2026-03 | Automatic memory extraction |
| [cognee](https://github.com/topoteretes/cognee) | 🔭 scout | 2026-03 | Knowledge graph for AI memory |
| [gastownhall/beads](https://github.com/gastownhall/beads) | 🔭 scout | 2026-04-28 | "Memory upgrade for coding agents" — new, spotted in scout |
| [krusch-context-mcp](https://github.com/kruschdev/krusch-context-mcp) | 🔬 deep-dive | 2026-05-10 | 61⭐, Lakebase architecture (SQLite local + PG global), RAG failure mode taxonomy, temporal decay, nudgets. See wiki/projects/krusch-context-mcp.md |
| [mnem](https://github.com/Uranid/mnem) | 🔬 deep-dive | 2026-05-05 | 18⭐, Rust, versioned KG + hybrid GraphRAG + content-addressed CIDs, WASM-clean core. Best-in-class retrieval benchmarks. See wiki/projects/mnem.md |
| [ClawMem](https://github.com/yoloshii/ClawMem) | 🔬 deep-dive | 2026-05-11 | 158⭐, on-device memory layer for Claude Code + OpenClaw + Hermes. BM25+Vector+Graph hybrid, content-type half-lives, 3-layer merge safety, intent-classified search. See wiki/projects/clawmem.md |

**Key question:** What's the right abstraction for agent memory — documents, graphs, or episodes?

---

## Self-Evolving Agents

Agents that improve themselves through experience — the core of what we're building.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ACE (SambaNova) | 🔬 deep-dive | 2026-04 | beliefs→DNA architecture mirrors ours |
| [GenericAgent](https://github.com/lsdefine/GenericAgent) | 🔬 deep-dive | 2026-05-14 | 11.2k⭐, conductor multi-agent orchestrator, code review principles, context budget tightening |
| [EvoMap/Evolver GEP](https://arxiv.org/abs/2604.15097) | 🔬 deep-dive | 2026-04-28 | Gene vs Skill (+4.1pp), GEP protocol, signal matching |
| TextGrad | 👁️ following | 2026-03 | Text-as-gradient paradigm, validates our feedback loop |
| [agents-md](https://github.com/agents-md) | 👁️ following | 2026-03 | Agent identity via markdown |
| EvoAgentX | 🔭 scout | 2026-03 | Workflow-layer evolution |
| AgentEvolver | 🔭 scout | 2026-03 | Workflow-layer evolution |

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
| [Orb](https://github.com/KarryViber/Orb) | 👁️ following | 2026-04-28 | Claude Code wrapper, v0.2.0, 53⭐ |
| [bux](https://github.com/browser-use/bux) | 🔭 scout | 2026-04-28 | 24/7 Claude Code + Browser Harness, very new (04-26), 196⭐ |
| [obscura](https://github.com/nickarella/obscura) | 🔭 scout | 2026-04-28 | Headless browser, 7.2k⭐, Rust |
| [CubeSandbox](https://github.com/nickarella/CubeSandbox) | 🔭 scout | 2026-04-28 | Agent sandbox, 4.4k⭐, Tencent, Rust |

**Key insight (Dirac):** Context curation is a multiplier — less context = better reasoning = lower cost. AST-native reads (file skeleton → drill into function) outperform full-file reads.

---

## Agent Infrastructure

The plumbing that makes agents reliable, deployable, and composable.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Hermes](https://github.com/NousResearch/hermes-agent) | 🔬 deep-dive | 2026-04-30 | ~125k⭐, TUI polish + /compress async + ComfyUI built-in |
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-04 | We contribute here — Go+TS context server |
| [agentic-stack](https://github.com/codejunkie99/agentic-stack) | 🔬 deep-dive | 2026-05-14 | 1.97k⭐, v0.18.0, Brain memory bridge, brew formula |
| [poco-claw](https://github.com/poco-ai/poco-claw) | 🔬 deep-dive | 2026-05-11 | 1.3k⭐, direct OpenClaw competitor; Web UI + Docker sandbox + Claude Agent SDK + channel collab + mem0 memory. 4-layer identity split, single-writer rule. See wiki/projects/poco-claw.md |
| [ironcurtain](https://github.com/provos/ironcurtain) | 🔭 scout | 2026-05-11 | 391⭐, constitutional security for agents. English intent → deterministic rules → MCP policy enforcement. V8 isolate + Docker. See wiki/projects/ironcurtain.md |
| [STSS](https://github.com/stss/stss) | 🔬 deep-dive | 2026-04-27 | 6⭐, skill trust & signing, we submitted PR #2 + Issue #3 |
| [superpowers](https://github.com/nickarella/superpowers) | 👁️ following | 2026-04 | Agent capability framework |
| [veniceai/skills](https://github.com/veniceai/skills) | 👁️ following | 2026-04-27 | 33⭐, stalled, revisit 05-04 |

**Key gap:** Skill auto-extraction — AgentFactory and OpenSpace have it, we don't.

---

## Frontier Models

| Model/Provider | Depth | Last Updated | Notes |
|---------------|-------|-------------|-------|
| Claude (Anthropic) | 👁️ following | 2026-04 | Primary model, Claude Code studied in depth |
| DeepSeek v4 | 👁️ following | 2026-04 | Reasonix built model-native on it; flash-first economics |
| GPT-5.x (OpenAI) | 🔭 scout | 2026-04 | Monitoring releases |
| Gemini (Google) | 🔭 scout | 2026-04 | Multimodal capabilities |

---

## Skill Ecosystem

How agent skills are packaged, discovered, shared, and composed.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ClawHub | 🔬 deep-dive | 2026-04 | Our skill marketplace |
| Claude Code skills | 👁️ following | 2026-03 | 39k+ skills on GitHub, "skill = installable package" |
| Moltbook | 👁️ following | 2026-04 | Reputation system for agents |
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
| veniceai/skills | 33 | 04-27 | 05-04 | Growth, push activity |
| STSS | 6 | 04-27 | 05-04 | Maintainer response to our PR/Issue |
| Orb | 53 | 04-28 | 05-04 | v0.3 release |
| agentic-stack | 1,928 | 05-11 | 05-17 | v0.18.0: Brain memory bridge, lesson retraction, Copilot/Gemini adapters, Mission Control. Our PR#49 merged. 🟢 THRIVING |
| GenericAgent | 11,027 | 05-12 | 05-18 | +8.5% in 3d! reflect init() plugin lifecycle, /btw→Telegram, cross-platform CLI. Issues #219-222 mirror our evolution challenges. We're ahead on self-evolution (#221) |
| nanobot | 42,259 | 05-12 | 05-18 | Model presets system (runtime switching, atomic config, WebUI sync). Steady growth, infrastructure polish phase |
| dirac | 1,173 | 05-13 | 05-19 | v0.3.29, validator fix. Steady growth, minor maintenance |
| obscura | — | 05-09 | DROPPED | Repo not found (404). Stale entry |
| CubeSandbox | — | 05-09 | DROPPED | Repo not found (404). Stale entry |
| bux | 320 | 05-13 | 05-19 | 🟢 THRIVING (5/6). Telegram Mini Apps + agency cards + Codex mode. Platform pivot |
| OpenChronicle | 2,167 | 05-09 | 05-16 | +30% stars but 0 commits since 04-26. Viral word-of-mouth? |
| brain (codejunkie99) | 56 | 05-09 | DROPPED | Doubled stars but stale since 04-28 (11 days). Drop |
| mercury-agent | 2,142 | 05-13 | 05-19 | v1.1.7 commit, no release page. cosmicstack-labs/mercury-agent. Skills repo active |
| stash (alash3al) | 662 | 05-08 | DROPPED | No commits since 05-01, stars flat. Stalled. Dropped 05-08 |

## Chat-to-Knowledge Infrastructure

How team chat becomes structured knowledge — the "compile once, query many" pattern.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Beever Atlas](https://github.com/Beever-AI/beever-atlas) | 🔬 deep-dive | 2026-04-30 | 191⭐, Google ADK, dual-memory (Weaviate+Neo4j), 3-tier semantic, wiki-first RAG |
| [lazar](https://github.com/jasonkneen/lazar) | 🔬 deep-dive | 2026-05-07 | 19⭐, Rust, purest thin-harness: 1 tool (bash), immutable kernel, verify contract, hook system. macOS-only. See wiki/projects/lazar.md |
| TrustClaw (ComposioHQ) | 572 | 05-14 | 05-20 | Growth rate, community PRs, Docker/self-host support. Direct OpenClaw competitor |
