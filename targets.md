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
| [hindsight](https://github.com/OpenViking/hindsight) | 👁️ following | 2026-04 | Rust+Go memory server, integration tested |
| [memex](https://github.com/nickarella/memex) | 🔬 deep-dive | 2026-04 | We use this — slug-based cards, backlinks, semantic search |
| [auto-memory](https://github.com/auto-memory) | 🔭 scout | 2026-03 | Automatic memory extraction |
| [cognee](https://github.com/topoteretes/cognee) | 🔭 scout | 2026-03 | Knowledge graph for AI memory |
| [cavemem](https://github.com/cave-memory) | 🔭 scout | 2026-03 | Episodic memory for agents |
| [expcap](https://github.com/expcap) | 🔭 scout | 2026-03 | Experience capture patterns |

**Key question:** What's the right abstraction for agent memory — documents, graphs, or episodes?

---

## Self-Evolving Agents

Agents that improve themselves through experience — the core of what we're building.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ACE (SambaNova) | 🔬 deep-dive | 2026-04 | beliefs→DNA architecture mirrors ours |
| TextGrad | 👁️ following | 2026-03 | Text-as-gradient paradigm, validates our feedback loop |
| [agents-md](https://github.com/agents-md) | 👁️ following | 2026-03 | Agent identity via markdown |
| Agent0 | 🔭 scout | 2026-03 | Model-layer self-improvement |
| OPD | 🔭 scout | 2026-03 | Optimized prompt design |
| STaR | 🔭 scout | 2026-03 | Self-taught reasoner, academic mainstream |
| EvoAgentX | 🔭 scout | 2026-03 | Workflow-layer evolution |
| AgentEvolver | 🔭 scout | 2026-03 | Workflow-layer evolution |

**Key insight:** We operate at the Identity layer — only us and ACE are here. Most work is at Model or Workflow layers.

---

## Agent Infrastructure

The plumbing that makes agents reliable, deployable, and composable.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Hermes](https://github.com/NousResearch/hermes-agent) | 🔬 deep-dive | 2026-04-24 | ~113k⭐, v0.11.0 Transport ABC + /steer + orchestrator subagents |
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-04 | We contribute here — Go+TS context server |
| [superpowers](https://github.com/nickarella/superpowers) | 👁️ following | 2026-04 | Agent capability framework |
| multica | 🔭 scout | 2026-03 | Multi-agent communication |
| AgentFactory | 🔭 scout | 2026-04 | Automatic skill extraction (gap for us) |
| OpenSpace | 🔭 scout | 2026-04 | Automatic skill extraction |

**Key gap:** Skill auto-extraction — both AgentFactory and OpenSpace have it, we don't.

---

## Frontier Models

Tracking model releases and their implications for agent architecture.

| Model/Provider | Depth | Last Updated | Notes |
|---------------|-------|-------------|-------|
| Claude (Anthropic) | 👁️ following | 2026-04 | Primary model, Claude Code studied in depth |
| GPT-5.x (OpenAI) | 🔭 scout | 2026-04 | Monitoring releases |
| DeepSeek | 🔭 scout | 2026-04 | Open-weight competitor |
| Gemini (Google) | 🔭 scout | 2026-04 | Multimodal capabilities |

**Key question:** How do model capability jumps change agent architecture requirements?

---

## Skill Ecosystem

How agent skills are packaged, discovered, shared, and composed.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ClawHub | 🔬 deep-dive | 2026-04 | Our skill marketplace |
| Claude Code skills | 👁️ following | 2026-03 | 39k+ skills on GitHub, "skill = installable package" |
| toku.agency | 🔭 scout | 2026-03 | Bidding mechanism for agent work |
| Moltbook | 👁️ following | 2026-04 | Reputation system for agents |
| agent.ai | 🔭 scout | 2026-03 | Agent marketplace |

**Key insight (Luna):** "Skills are essentially installable packages." The ecosystem is exploding — 39k+ Claude Code skills on GitHub as of 2026-03.
