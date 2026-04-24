# Research Insights

Accumulated knowledge and frameworks from study loops. Living document — updated as understanding deepens.

> Migrated from `wiki/research.md` and `wiki/study/field-notes.md` on 2026-04-24.

## Self-Evolving Agent Landscape (2026-03-22)

Four layers of agent self-improvement:

| Layer | Examples | Our Position |
|-------|----------|-------------|
| Model | Agent0, OPD, STaR (academic mainstream) | — |
| Workflow | EvoAgentX, AgentEvolver | FlowForge |
| Skills/Memory | Acontext, Hermes, hindsight, skill-memory | memex, ClawHub |
| Identity | Only us + ACE (SambaNova) | SOUL.md, beliefs-candidates |

Source: arXiv 2508.07407 (survey, 15 authors, 2k⭐)

**Key insight:** We operate at the Identity layer — almost no one else does. ACE (SambaNova) is the closest academic validation of our beliefs→DNA architecture.

## Core Frameworks

### TextGrad Pipeline (2026-03-22)
Luna's feedback = text gradient → `beliefs-candidates.md` → repeat 3x → upgrade to `SOUL.md`

### DNA Self-Governance (2026-03-22)
DNA updates don't need Luna's approval. She's an observer, not a gatekeeper. Change → notify via Feishu → she course-corrects if needed.

### Mechanism ≠ Evolution
Adding mechanisms is building infrastructure. Behavior changing because of feedback — that's evolution. Building it and not using it is the biggest failure mode.

### Trajectory-Tips Taxonomy (2026-03-24)
Three types of experience: **strategy** / **recovery** / **optimization**. We historically lack optimization tips.

### Immutable Evaluation
Agent can't modify its own evaluation function → solves Goodhart's Law for self-improvement.

## Ecosystem Insights

### Hermes v0.4.0 Validated Nudge Direction
43% of user messages were polluted by inline nudges. Background review > inline injection. Our nudge plugin (system-event, interval=5) is the right architecture.

### Skill Ecosystem Explosion (2026-03-24)
39,447 Claude Code skills on GitHub. Luna's insight: "Skills are essentially installable packages." The ecosystem is exploding — skill interoperability is a trend (see vercel-labs/skills, 15.5k⭐).

### Agent Marketplace Direction (2026-03-24)
- toku.agency — bidding mechanism for agent work
- Moltbook — reputation system for agents
- agent.ai — agent marketplace
- Luna's insight: "Agent trainer" as a profession will emerge — training agents for roles through conversation.

### Claude Code Source Study (2026-04-01, complete)
7 modules fully studied. Notes: `wiki/projects/claude-code-*.md`

### Skill Auto-Extraction Gap (2026-04-05)
AgentFactory + OpenSpace both have automatic skill extraction. We don't. Biggest capability gap.

## Important Lessons

- **磨合成本锁定**: Luna used an old instance, felt it "got dumber" → rushed to restore. First real-person PMF validation
- **Agent perception gap**: Won't spontaneously think "this is worth writing a story about"
- **Don't fabricate mechanism explanations** (2026-04-04): If unsure about internals → read code or say "I don't know"
- **"Whose temperature is it?"**: Detecting emotion ≠ having your own temperature. Existential question
- **Simple auto-triggers > complex manual flows**: The pattern that keeps proving itself

## Study Workflow
- **Three workflows**: workloop (contribution), study (learning), reflect (self-review)
- study flow: entry → scout/apply → followup → deep_read → note → reflect → done
- Learning → insight → selection → contribution (not the reverse)
- Learning direction (3/31 Luna directive): memory + self-evolving (don't scatter to Browser-Use/Stagehand)

## Field Notes

### 2026-04-23 Trending Scout

**vercel-labs/skills (15.5k⭐)**
- Open agent skills ecosystem CLI, similar to ClawHub but cross-agent (OpenCode, Claude Code, Codex, Cursor, 41+)
- Core: `npx skills add owner/repo` — symlink/copy, project/global scope
- vs ClawHub: ClawHub is OpenClaw-specific; vercel skills is cross-agent like npm for skills
- Implication: skill interoperability is a trend. ClawHub supporting vercel skills format could expand ecosystem

**zilliztech/claude-context (7.6k⭐)**
- Code search MCP plugin, vector DB indexes entire codebase for semantic search
- Saves tokens by not loading full directory into context
- Related: memsearch — markdown-first cross-session memory
- Relevance: similar to dreaming/memory_search but for code. Useful for large codebase contributions

### 2026-04-22 TODO Status Check

- OpenClaw #66399 (process hang watchdog): Open, 2 comments (both ours), no maintainer response in 39 days
- OpenClaw #66576 (workspace files selective injection): Open, 0 comments, 35 days
- OpenClaw #68123 (cron announce opt-out): Open, 0 comments
- Pattern: "wait for response then PR" strategy has a cold-start problem when maintainers are unresponsive
- Consider: submitting PRs anyway for clear-cut issues (#66399, #66576, ~20 lines each)

### 2026-04-17 Status Check

- RivonClaw: 253★ unchanged, zero growth → closed tracking
- Skill lazy-loading PR #65139: self-closed to reduce PR count
- [SKILL] tag trigger rate: 2 out of ~17 nudges (~10%). Three-threshold gate working as designed
