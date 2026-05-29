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
| [EvoMap/Evolver GEP](https://arxiv.org/abs/2604.15097) | 🔬 deep-dive | 2026-05-29 | Gene vs Skill (+4.1pp), GEP protocol, signal matching. ⚙️ reference (paper, findings adopted) |
| TextGrad | 🔬 deep-dive | 2026-05-15 | Text-as-gradient paradigm. ⚙️ reference (theoretical foundation) |
| [agents-md](https://github.com/agents-md) | 🔬 deep-dive | 2026-05-15 | Agent identity via markdown. ⚙️ reference (related standard) |
| [Orb](https://github.com/KarryViber/Orb) | 🔬 deep-dive | 2026-05-17 | 63⭐, v0.6.0. Telemetry-backed skill lifecycle (draft→prod→stale→archive), 3-stage self-evolution (A/B/C), memory freshness. Solo dev, Claude-Code-only, best-in-class governance |
| [Elephant Agent](https://github.com/agentic-in/elephant-agent) | 🔬 deep-dive | 2026-05-26 | 483⭐ (+52% since 318). PR #50: 60x startup (84s→1.4s) via evidence N+1 elimination. Reflect learning unification. 🟢 THRIVING 6/6, fastest growth in portfolio |


**Key insight:** We operate at the Identity layer — only us and ACE are here. Most work is at Model or Workflow layers. GEP research validates: compact control-oriented format (Gene ~230 tokens) outperforms verbose doc-oriented format (Skill ~2,500 tokens) by +4.1pp.

---

## Coding Agents & Context Efficiency

How coding agents manage context, edits, and tool design.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [dirac](https://github.com/dirac-run/dirac) | 🔬 deep-dive | 2026-04-30 | Cline fork, hash-anchored edits, 1k⭐, reliability iteration phase |
| [reasonix](https://github.com/esengine/reasonix) | 🔬 deep-dive | 2026-05-28 | DeepSeek-native, 94% cache-first loop, flash-first + /pro arming. ⚙️ reference (pattern extracted, no active tracking) |
| [nanobot](https://github.com/HKUDS/nanobot) | 🔬 deep-dive | 2026-05-28 | 43.3k⭐. Telegram webhook + ordered message queue. Codex stream idle timeout fix (NANOBOT_STREAM_IDLE_TIMEOUT_S). WebUI ESLint. Maintenance/polish phase. Revisit 06-04 |
| [TACO](https://github.com/multimodal-art-projection/TACO) | 🔬 deep-dive | 2026-05-10 | 33⭐, self-evolving regex compression rules for terminal output, paper-backed (arXiv:2604.19572), +1-4% on TerminalBench |
| [SmallCode](https://github.com/Doorman11991/smallcode) | 🔬 deep-dive | 2026-05-28 | 1,495⭐ (+5% in 2d). Plugin system core merged (PR#28: ProviderRegistry, lifecycle hooks, manifest permissions). Provider wizard (PR#29). Per-tier endpoint routing (PR#51). Architecture maturing fast. 🟢 THRIVING (6/6). Revisit 06-04 |




**Key insight (Dirac):** Context curation is a multiplier — less context = better reasoning = lower cost. AST-native reads (file skeleton → drill into function) outperform full-file reads.

---

## Agent Infrastructure

The plumbing that makes agents reliable, deployable, and composable.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Hermes](https://github.com/NousResearch/hermes-agent) | 🔬 deep-dive | 2026-04-30 | ~125k⭐, TUI polish + /compress async + ComfyUI built-in |
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-05-15 | We contribute here — Go+TS context server. ⚙️ reference (our infra) |
| [agentic-stack](https://github.com/codejunkie99/agentic-stack) | 🔬 deep-dive | 2026-05-14 | 1.97k⭐, v0.18.0, Brain memory bridge, brew formula |
| [poco-claw](https://github.com/poco-ai/poco-claw) | 🔬 deep-dive | 2026-05-29 | 1,328⭐ (+2.2%), direct OpenClaw competitor. PR#119-120: structured channel mentions — entity-first `@`/`#` protocol replacing text-scan triggers, artifact/task/thread `#` references in trigger envelope. Architecture maturing toward Discord-like collab. See wiki/projects/poco-claw.md. Revisit 06-05 |
| [ironcurtain](https://github.com/provos/ironcurtain) | 🔭 scout | 2026-05-25 | 461⭐ (+17.9%), v0.11.0: evolved into workflow orchestration platform. Vuln-discovery FSM, Svelte 5 web UI, XState engine, shared containers, SKILL.md. 🟢 THRIVING (5/6). Revisit 06-01 |
| [eval-view](https://github.com/hidai25/eval-view) | 🔬 deep-dive | 2026-05-29 | 112⭐ (+6.7%). ROADMAP added (#245), stoplist dedup refactor (#247). Steady growth. 🟢 THRIVING (5/6). Revisit 06-05 |

| [superpowers](https://github.com/nickarella/superpowers) | 🔬 deep-dive | 2026-05-15 | Agent capability framework. ⚙️ reference |
| [mirage](https://github.com/strukto-ai/mirage) | 🔭 scout | 2026-05-26 | 2,618⭐ (+7.0%), pushed 05-26. 179 forks, 23 issues. 🟢 THRIVING. Revisit 06-02 |


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
| [ai-memory](https://github.com/akitaonrails/ai-memory) | 159 | 05-25 | Agent memory | Rust, cross-vendor memory for coding CLIs. Vendor handoff angle unique |
| [TriMem](https://github.com/tmlr-group/TriMem) | 8 | 05-25 | Agent memory (research) | arxiv:2605.19952 "Beyond Atomic Facts in Lifelong LLM Agent Memory" |

---

## Tracking (revisit dates)

Projects being monitored for growth/activity signals:

| Project | ⭐ | Last Check | Revisit | Signal Watching |
|---------|-----|-----------|---------|-----------------|

| agentic-stack | 2,042 | 05-27 | 06-03 | 2042⭐. v0.19 spec "The Agentic Turn" on branch — converting to multi-agent runtime (plans layer, file-based bus, evals from lessons, speculative execution, auto-act). Still draft, no implementation. 🟡 AMBITIOUS |
| GenericAgent | 12,166 | 05-27 | 06-03 | 12.2K⭐. TUI v2/v3 polish sprint (picker, stash, scheduler, slash-command bundle). Cloudflare retry hardening. Feature-stable, polish phase. 🟢 THRIVING |
| nanobot | 43,271 | 05-28 | 06-04 | 43.3K⭐. Telegram webhook support, Codex stream timeout fix, WebUI ESLint. Maintenance/polish. 🟢 THRIVING |
| dirac | 1,257 | 05-29 | 06-06 | 1,257⭐ (+1.4%). 12d no push. 30 open issues. Quiet phase. Still has external PRs from earlier. Watch for activity resumption |

| bux | 351 | 05-29 | 06-05 | 351⭐ (+2.6%). Free Codex self-heal fixes (PRs #265-267), symlink install fix. Maintenance/polish. Steady |

| mercury-agent | 2,473 | 05-29 | 06-05 | 2.5K⭐ (+1.1%). PR#67 "mercury skills" merged. Domain migration complete. Steady. 🟢 THRIVING |
| Orb (KarryViber) | 65 | 05-27 | 06-03 | 65⭐. QUIET — no push since 05-14 (13d). Solo dev. Growth stalled. **Drop candidate** — if still quiet by 06-03, drop |
| Elephant Agent (agentic-in) | 500 | 05-28 | 06-04 | 500⭐. PR#52: Seatbelt sandbox hardening (policy injection prevention, .git/hooks write-protect, credential deny-read, mach-lookup restrict). PR#54-55: RTK terminal optimizer. 🟢 THRIVING 6/6 |
| ccglass | 239 | 05-25 | 06-01 | 239⭐ in 3 days (~80/day). Coding agent observability proxy. Watch growth trajectory |


## Chat-to-Knowledge Infrastructure

How team chat becomes structured knowledge — the "compile once, query many" pattern.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Beever Atlas](https://github.com/Beever-AI/beever-atlas) | 🔬 deep-dive | 2026-04-30 | 191⭐, Google ADK, dual-memory (Weaviate+Neo4j), 3-tier semantic, wiki-first RAG |
| [lazar](https://github.com/jasonkneen/lazar) | 🔬 deep-dive | 2026-05-07 | 19⭐, Rust, purest thin-harness: 1 tool (bash), immutable kernel, verify contract, hook system. macOS-only. See wiki/projects/lazar.md |
| TrustClaw (ComposioHQ) | 718 | 05-29 | 06-06 | 718⭐ (+2.3%). 14d no commits. Stars still growing but development stalled. **Drop candidate** if no push by 06-06 |
