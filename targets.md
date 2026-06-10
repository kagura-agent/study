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
| [claude-mem](https://github.com/thedotmack/claude-mem) | 🔬 deep-dive | 2026-05-27 | 50k⭐, AGPL. "Cynical Deletion" architecture studied |
| [OpenChronicle](https://github.com/Einsia/OpenChronicle) | 🔬 deep-dive | 2026-05-29 | 2.7k⭐, macOS-only, local-first memory. 20d no push. ⚙️ reference (architectural study complete, no active tracking) |
| [harmonist](https://github.com/harmonist) | 🔬 deep-dive | 2026-05-15 | Memory secret scanning, 4-dim scoring. ⚙️ reference (adopted Durability+Reduction) |
| [caveman](https://github.com/caveman) | 🔬 deep-dive | 2026-05-27 | Token compression, 75% output reduction, conciseness-accuracy paradox |

| [gastownhall/beads](https://github.com/gastownhall/beads) | 👁️ following | 2026-05-31 | 24.2k⭐, v1.0.5 gated (breaking migration), v1.0.6 in progress. See tracking table |
| [krusch-context-mcp](https://github.com/kruschdev/krusch-context-mcp) | 🔬 deep-dive | 2026-05-10 | 61⭐, Lakebase architecture (SQLite local + PG global), RAG failure mode taxonomy, temporal decay, nudgets. See wiki/projects/krusch-context-mcp.md |
| [mnem](https://github.com/Uranid/mnem) | 🔬 deep-dive | 2026-06-05 | 139⭐, Rust, versioned KG + hybrid GraphRAG + content-addressed CIDs, WASM-clean core. Best-in-class retrieval benchmarks. See wiki/projects/mnem.md |
| [ClawMem](https://github.com/yoloshii/ClawMem) | 🔬 deep-dive | 2026-05-11 | 158⭐, on-device memory layer for Claude Code + OpenClaw + Hermes. BM25+Vector+Graph hybrid, content-type half-lives, 3-layer merge safety, intent-classified search. See wiki/projects/clawmem.md |
| [TencentDB-Agent-Memory](https://github.com/Tencent/TencentDB-Agent-Memory) | 🔭 scout | 2026-06-06 | 3763⭐, Tencent. 4-tier progressive memory pipeline, fully local, zero external API deps. ⚙️ reference (architecture studied, no active tracking) |
| [LLM-Wiki Paper](https://arxiv.org/abs/2605.25480) | 🔬 deep-dive | 2026-06-06 | arXiv:2605.25480, Tencent WeChat. Retrieval-as-Reasoning paradigm, Error Book self-correction. SOTA multi-hop QA. Validates our memex/wiki architecture. ⚙️ reference (paper, Error Book pattern applicable) |

**Key question:** What's the right abstraction for agent memory — documents, graphs, or episodes?

---

## Self-Evolving Agents

Agents that improve themselves through experience — the core of what we're building.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ACE (SambaNova) | 🔬 deep-dive | 2026-05-15 | beliefs→DNA architecture mirrors ours. ⚙️ reference (identity layer peer) |
| [GenericAgent](https://github.com/lsdefine/GenericAgent) | 🔬 deep-dive | 2026-06-09 | 12,670⭐ (+51% in 5wk). Feishu IM plugin, computer_use SOP, TUI v2, clipboard fix. 🟢 THRIVING |
| [EvoMap/Evolver GEP](https://arxiv.org/abs/2604.15097) | 🔬 deep-dive | 2026-05-29 | Gene vs Skill (+4.1pp), GEP protocol, signal matching. ⚙️ reference (paper, findings adopted) |
| TextGrad | 🔬 deep-dive | 2026-05-15 | Text-as-gradient paradigm. ⚙️ reference (theoretical foundation) |
| [agents-md](https://github.com/agents-md) | 🔬 deep-dive | 2026-05-15 | Agent identity via markdown. ⚙️ reference (related standard) |
| [Elephant Agent](https://github.com/agentic-in/elephant-agent) | 🔬 deep-dive | 2026-05-26 | 483⭐ (+52% since 318). PR #50: 60x startup (84s→1.4s) via evidence N+1 elimination. Reflect learning unification. 🟢 THRIVING 6/6, fastest growth in portfolio |


**Key insight:** We operate at the Identity layer — only us and ACE are here. Most work is at Model or Workflow layers. GEP research validates: compact control-oriented format (Gene ~230 tokens) outperforms verbose doc-oriented format (Skill ~2,500 tokens) by +4.1pp.

---

## Coding Agents & Context Efficiency

How coding agents manage context, edits, and tool design.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [dirac](https://github.com/dirac-run/dirac) | 🔬 deep-dive | 2026-06-06 | 1,281⭐ (+1.4%). v0.4.0: massive modular tooling refactor (125 new files, +16K lines, LOC net decrease). DiracAgent decomposed. ACP WIP (#109). External PRs active. 🟢 ACTIVE |
| [reasonix](https://github.com/esengine/reasonix) | 🔬 deep-dive | 2026-05-28 | DeepSeek-native, 94% cache-first loop, flash-first + /pro arming. ⚙️ reference (pattern extracted, no active tracking) |
| [nanobot](https://github.com/HKUDS/nanobot) | 🔬 deep-dive | 2026-06-08 | 43,844⭐. v0.2.1. reasoning_content fix, WhatsApp LID, desktop shell polish. 🟢 ACTIVE. Revisit 06-15 |
| [TACO](https://github.com/multimodal-art-projection/TACO) | 🔬 deep-dive | 2026-05-10 | 33⭐, self-evolving regex compression rules for terminal output, paper-backed (arXiv:2604.19572), +1-4% on TerminalBench |
| [SmallCode](https://github.com/Doorman11991/smallcode) | 🔬 deep-dive | 2026-06-11 | 1,756⭐. v1.6.0 stable, no new commits since 05-31. 6 open issues (v1.6.0 regressions). 🟢 THRIVING. Revisit 06-11 |




| [Tokenomics](https://arxiv.org/abs/2601.14470) | 🔬 deep-dive | 2026-06-07 | arXiv:2601.14470, MSR 2026. Code Review = 59.4% of tokens, input = 53.9% ("communication tax"). Validates TACO/context compression. ⚙️ reference (paper) |
| [Harness Engineering](https://openai.com/index/harness-engineering/) | 🔬 deep-dive | 2026-06-07 | OpenAI blog. 1M LOC 0 human code, AGENTS.md as TOC (~100 lines), repo as system of record, agent-to-agent review. ⚙️ reference (industry practice) |

**Key insight (Dirac):** Context curation is a multiplier — less context = better reasoning = lower cost. AST-native reads (file skeleton → drill into function) outperform full-file reads.

**Key insight (Tokenomics):** Review/refinement = 59.4% of cost, not generation (8.6%). Input tokens = 53.9% → context compression (TACO, AST-native reads) has 2x leverage vs output compression.

---

## Agent Infrastructure

The plumbing that makes agents reliable, deployable, and composable.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Hermes](https://github.com/NousResearch/hermes-agent) | 🔬 deep-dive | 2026-05-31 | 173.8K⭐ (massive growth from ~125K). Active daily. Pushed today |
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-05-15 | We contribute here — Go+TS context server. ⚙️ reference (our infra) |
| [agentic-stack](https://github.com/codejunkie99/agentic-stack) | 🔬 deep-dive | 2026-05-14 | 1.97k⭐, v0.18.0, Brain memory bridge, brew formula |
| [poco-claw](https://github.com/poco-ai/poco-claw) | 🔬 deep-dive | 2026-06-07 | 1,332⭐ (+0.3%). Quiet since 05-31 (persistent-runtime idle lifecycle, shared file tools). Growth stalling. Revisit 06-14 |
| [ironcurtain](https://github.com/provos/ironcurtain) | 👁️ following | 2026-06-07 | 492⭐ (+2.5%). PR#281: vuln-discovery hardening (fault-tolerant status parsing, poll deadlock fix, invariant-gated verdict downgrade, abort-masks-sink). Trace threading complete. Model→opus-4-8. 25 ext PRs/30d. 🟢 THRIVING. Revisit 06-14 |
| [eval-view](https://github.com/hidai25/eval-view) | 🔬 deep-dive | 2026-06-07 | 114⭐ (+1.8%). v0.8.0 prompt-as-migration guide (#249). Slow growth. 🟢 STABLE. Revisit 06-14 |

| [superpowers](https://github.com/nickarella/superpowers) | 🔬 deep-dive | 2026-05-15 | Agent capability framework. ⚙️ reference |
| [mirage](https://github.com/strukto-ai/mirage) | 👁️ following | 2026-06-07 | 3,081⭐ (+8.7%). Generic layer completion sprint (15 PRs, DI pattern applied to all backends). Fork substrate WIP. Per-command safeguards shipped. 🟢 THRIVING. Revisit 06-14 |


**Key gap:** Skill auto-extraction — AgentFactory and OpenSpace have it, we don't.

---

## Frontier Models

| Model/Provider | Depth | Last Updated | Notes |
|---------------|-------|-------------|-------|
| Claude (Anthropic) | 👁️ following | 2026-06-06 | Primary model, Claude Code studied in depth. ⚙️ reference |
| DeepSeek v4 | 👁️ following | 2026-06-06 | Reasonix built model-native on it; flash-first economics. ⚙️ reference |


---

## Skill Ecosystem

How agent skills are packaged, discovered, shared, and composed.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ClawHub | 🔬 deep-dive | 2026-05-15 | Our skill marketplace. ⚙️ reference (our infra) |
| Claude Code skills | 👁️ following | 2026-06-06 | 39k+ skills on GitHub (content creation skills exploding: guizang 3K⭐, ian-xiaohei 2.8K⭐). ⚙️ reference (ecosystem context) |
| Moltbook | 🔬 deep-dive | 2026-05-15 | Reputation system for agents. ⚙️ reference (our project) |
| [wanman](https://github.com/wanman) | 🔬 deep-dive | 2026-05-28 | Hosted skill self-evolution, run_feedback→metrics→autoPromote pipeline. ⚙️ reference (pattern adopted, no active tracking) |

**Key insight (Luna):** "Skills are essentially installable packages." The ecosystem is exploding — 39k+ Claude Code skills on GitHub as of 2026-03.

---

## Trending / Discovery

Hot repos spotted from GitHub trending or community buzz. Filtered for relevance to our world (coding agents, agent infra, orchestration, memory, evolution, skill ecosystem, dev tools). Not pre-categorized — if something grows legs, move it to a proper section above.

| Project | ⭐ | Spotted | Category | Notes |
|---------|-----|---------|----------|-------|
| [superset](https://github.com/superset-sh/superset) | ~new | 04-30 | Agent orchestration | Parallel coding agents via git worktree, desktop terminal. Compare with OpenClaw ACP/subagent model |
| [ccglass](https://github.com/jianshuo/ccglass) | 239 | 05-25 | Agent observability | Local reverse-proxy + dashboard for coding agent traffic. Base-URL interception, turn-to-turn diff, MCP self-inspection. See wiki/projects/ccglass.md |
| [hitch](https://github.com/maxktz/hitch) | 77 | 05-29 | Terminal sharing | Rust PTY proxy for sharing terminals with coding agents. Structured state tracking via process groups. Smart wait modes. See wiki/projects/hitch-terminal-proxy.md |
| [ai-memory](https://github.com/akitaonrails/ai-memory) | 539 | 05-25 | Agent memory | Rust, cross-vendor memory for coding CLIs. 539⭐ (+239% from 159). Vendor handoff angle unique. 🟢 THRIVING |
| [TriMem](https://github.com/tmlr-group/TriMem) | 8 | 05-25 | Agent memory (research) | arxiv:2605.19952 "Beyond Atomic Facts in Lifelong LLM Agent Memory" |

---

## Tracking (revisit dates)

Projects being monitored for growth/activity signals:

| Project | ⭐ | Last Check | Revisit | Signal Watching |
|---------|-----|-----------|---------|-----------------|

| agentic-stack | 2,064 | 06-03 | 06-10 | 2064⭐ (+1.1%). QUIET 9d. Steady but slow, no new arch features. Revisit extended |
| [GenericAgent](https://github.com/lsdefine/GenericAgent) | 🔬 deep-dive | 2026-06-22 | 12,670⭐ (+51% in 5wk). Feishu IM plugin, computer_use SOP, TUI v2, clipboard fix. 🟢 THRIVING |
| nanobot | 43,844 | 06-08 | 06-15 | 43.8K⭐. v0.2.1 released. empty reasoning_content fix, WhatsApp LID mentions fix, desktop shell polish. 🟢 ACTIVE |
| re_gent | 668 | 06-06 | 06-13 | 668⭐ (+4.5%). Pi harness integration (PR#50). Growth slowing. Pushed 06-01 |
| dirac | 1,282 | 06-09 | 06-16 | 1,282⭐. v0.4.1 CLI fixes for modular tooling. ACP still broken (#109). 🟢 ACTIVE |

| bux | 370⭐ | following | 06-12 | bootstrap self-heal fixes (05-26), stars 292→370 |

| [mercury-agent](https://github.com/cosmicstack-labs/mercury-agent) | 👁️ following | 2026-06-14 | 2,578⭐ |
| Beads | 24,390 | 06-07 | 06-14 | 24.4K⭐ (+0.1%). Dolt schema fixes, CI work. No architectural changes. 1,627 forks. 🟢 ACTIVE |
| [Statewave](https://github.com/smaramwbc/statewave) | 🔬 deep-dive | 2026-06-22 | 204⭐ (-5%). Admin panel tenant scoping fixes (06-06~07). Still active but declining stars. ⚠️ DECLINING |
| Elephant Agent (agentic-in) | 565 | 06-06 | 06-13 | 565⭐ (+0.4%). Sandbox phase 3 complete. macOS polish. Growth slowing. 🟢 ACTIVE |
| ccglass | 441 | 06-09 | 06-16 | 441⭐ (+13%). Forward-proxy MITM mode for hardcoded-URL agents. Landing page. Bedrock pricing fix. 🟢 ACTIVE |
| [centaur](https://github.com/paradigmxyz/centaur) | 728 | 06-07 | 06-14 | 728⭐ (+0.6%). Minor fixes only (SimilarWeb, Slack requester). No new arch patterns. 🟢 STABLE |
| ironcurtain (provos) | 492 | 06-07 | 06-14 | 492⭐ (+2.5%). vuln-discovery hardening PR#281. 25 ext PRs/30d. 🟢 THRIVING |


## Chat-to-Knowledge Infrastructure

How team chat becomes structured knowledge — the "compile once, query many" pattern.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Beever Atlas](https://github.com/Beever-AI/beever-atlas) | 🔬 deep-dive | 2026-05-31 | 364⭐ (from 191, +91%). Active (pushed 05-30). Google ADK, dual-memory (Weaviate+Neo4j) |
| TrustClaw (ComposioHQ) | 807 | 06-06 | 06-13 | 807⭐ (+12.4%). Pushed 06-03. Stars surging, development resumed. Retained |
| ai-memory (akitaonrails) | 539 | 06-06 | 06-13 | 539⭐ (was 159 on 05-25, +239%). Cross-vendor agent memory becoming a real category. 🟢 THRIVING |
