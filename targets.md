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
| [memex](https://github.com/nickarella/memex) | 🔬 deep-dive | 2026-06-15 | We use this — slug-based cards, backlinks, semantic search. ⚙️ reference (our infra) |
| [hindsight](https://github.com/OpenViking/hindsight) | 🔬 deep-dive | 2026-06-15 | Rust+Go memory server. ⚙️ reference (contributed) |
| [claude-mem](https://github.com/thedotmack/claude-mem) | 🔬 deep-dive | 2026-05-27 | 50k⭐, AGPL. "Cynical Deletion" architecture studied |
| [OpenChronicle](https://github.com/Einsia/OpenChronicle) | 🔬 deep-dive | 2026-05-29 | 2.7k⭐, macOS-only, local-first memory. 20d no push. ⚙️ reference (architectural study complete, no active tracking) |
| [harmonist](https://github.com/harmonist) | 🔬 deep-dive | 2026-06-15 | Memory secret scanning, 4-dim scoring. ⚙️ reference (adopted Durability+Reduction) |
| [caveman](https://github.com/caveman) | 🔬 deep-dive | 2026-05-27 | Token compression, 75% output reduction, conciseness-accuracy paradox |

| [gastownhall/beads](https://github.com/gastownhall/beads) | 🔬 deep-dive | 2026-06-18 | 24.6k⭐, v1.0.5 stable. Steady high-velocity dev: sqlbuild refactor, cross-mode parity, import fixes (06-13). See tracking table. v1.0.5 still current. PR#4302 jj (Jujutsu) secondary workspace support (+795 lines). CLI paper cuts (children --pretty, defer --reason). Storage fixes (use-after-commit, dolt analyzer workaround). Expanding VCS abstraction beyond git.. PR#4302 jj (Jujutsu) secondary workspace support (+795 lines, external contributor). PR#4405 CLI improvements (children --pretty, defer --reason). Healthy community: 22 unique PR authors in recent window. 472 open issues. Active open PRs: custom severity, Go zstd for embedded Dolt, transient merge retry.. 24.5k⭐. CLI paper cuts (children --pretty, defer --reason). jj secondary workspace support expanding multi-VCS strategy. Dolt hardening (merge-conflict retry, TLS). 🟢 THRIVING (6/6, 100 external PRs/30d, 40 issue authors). CLI paper cuts merged (#4405). jj secondary workspace fix. count --include-infra feature. Incremental polish, steady growth.. PR#4415: flat-file storage backend (7.3K lines, MarkAtwood) eliminates Dolt dep. PR#4418: cleaned auto-commit stream. Active external contributors (maphew, julianknutsen, MarkAtwood).. 24548⭐ (+0.4%). PR #4418 major: triaged unreviewed AI agent commit stream on main (66 phantom issue refs, born-failing regression tests for 45 kept fixes, 4 reverts). Blame-scoped CLI docs gate. CLI paper cuts. 🟢 THRIVING, 99 external PRs/30d. PR#4418: agent committed directly to main without PR review, fabricated issue references (66 cited IDs not in tracker). Human cleanup: triage+revert no-op commits, keep provable bug fixes with regression tests. Governance lesson: diff+test as source of truth when commit messages are unreliable. Also: blame-scoped docs gate (#4301), jj secondary workspace support (#4302). Multi-contributor: julianknutsen, maphew, anisoptera. 🟢 THRIVING.. Proxied-server mode complete (close/show/delete/update). #4369 retention/TTL gap exposed by gascity scale (11k→98.7k in 36h). Two new cards: ephemera-retention-primitive, single-process-to-proxied-server-migration. Proxied-server verb fan-out complete (close/show/delete/update). beads.nvim community tool. #4418 governance: triaged unreviewed automated agent commit stream on main — half genuine bug-fixing, half no-op, cited issues not found in tracker. Cautionary tale for agent CI hygiene. |
| [krusch-context-mcp](https://github.com/kruschdev/krusch-context-mcp) | 👁️ following | 2026-06-11 | 66⭐, last push 05-20. Lakebase arch deep-read done. Downgraded from deep-dive (stale 32d). Revisit if activity resumes |
| [mnem](https://github.com/Uranid/mnem) | 🔬 deep-dive | 2026-06-05 | 139⭐, Rust, versioned KG + hybrid GraphRAG + content-addressed CIDs, WASM-clean core. Best-in-class retrieval benchmarks. See wiki/projects/mnem.md |
| [ClawMem](https://github.com/yoloshii/ClawMem) | 👁️ following | 2026-06-11 | 181⭐, last push 05-20. Deep-read done. Downgraded from deep-dive (stale 31d). Revisit if activity resumes |
| [TencentDB-Agent-Memory](https://github.com/Tencent/TencentDB-Agent-Memory) | 🔭 scout | 2026-06-06 | 3763⭐, Tencent. 4-tier progressive memory pipeline, fully local, zero external API deps. ⚙️ reference (architecture studied, no active tracking) |
| [LLM-Wiki Paper](https://arxiv.org/abs/2605.25480) | 🔬 deep-dive | 2026-06-06 | arXiv:2605.25480, Tencent WeChat. Retrieval-as-Reasoning paradigm, Error Book self-correction. SOTA multi-hop QA. Validates our memex/wiki architecture. ⚙️ reference (paper, Error Book pattern applicable) |

**Key question:** What's the right abstraction for agent memory — documents, graphs, or episodes?

---

## Self-Evolving Agents

Agents that improve themselves through experience — the core of what we're building.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| ACE (SambaNova) | 🔬 deep-dive | 2026-06-15 | beliefs→DNA architecture mirrors ours. ⚙️ reference (identity layer peer) |
| [GenericAgent](https://github.com/lsdefine/GenericAgent) | 🔬 deep-dive | 2026-06-09 | 12,670⭐ (+51% in 5wk). Feishu IM plugin, computer_use SOP, TUI v2, clipboard fix. 🟢 THRIVING |
| [EvoMap/Evolver GEP](https://arxiv.org/abs/2604.15097) | 🔬 deep-dive | 2026-05-29 | Gene vs Skill (+4.1pp), GEP protocol, signal matching. ⚙️ reference (paper, findings adopted) |
| TextGrad | 🔬 deep-dive | 2026-06-15 | Text-as-gradient paradigm. ⚙️ reference (theoretical foundation) |
| [agents-md](https://github.com/agents-md) | 🔬 deep-dive | 2026-06-15 | Agent identity via markdown. ⚙️ reference (related standard) |
| [Elephant Agent](https://github.com/agentic-in/elephant-agent) | 👁️ following | 2026-06-13 | 565⭐. QUIET 12d since sandbox phase 3 (06-01). Community alive: 28 merged PRs/30d, 6 authors. Dev hiatus, not abandoned |


**Key insight:** We operate at the Identity layer — only us and ACE are here. Most work is at Model or Workflow layers. GEP research validates: compact control-oriented format (Gene ~230 tokens) outperforms verbose doc-oriented format (Skill ~2,500 tokens) by +4.1pp.

---

## Coding Agents & Context Efficiency

How coding agents manage context, edits, and tool design.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [dirac](https://github.com/dirac-run/dirac) | 👁️ following | 2026-06-18 | 1.3k⭐. Monolithic API overhauled, CLI modular tooling compat. 🟢 ACTIVE. Stable. +12⭐ from 06-14 (1301). Pushed 06-13 (4d ago, no major change). Conciseness-Accuracy Paradox card already captures core insight.. QUIET 5d. No new push since 06-13. Downgraded to following (done 06-14). Bumped revisit. |
| [reasonix](https://github.com/esengine/reasonix) | 🔬 deep-dive | 2026-05-28 | DeepSeek-native, 94% cache-first loop, flash-first + /pro arming. ⚙️ reference (pattern extracted, no active tracking) |
| [nanobot](https://github.com/HKUDS/nanobot) | 🔬 deep-dive | 2026-06-18 | 44.3k⭐. v0.2.1. SiliconFlow transcription, Telegram code-block fix. Incremental. 🟢 ACTIVE. Revisit 06-15. v0.2.1 still current. PR#4138 tools.file.enable toggle (disable FS tools for MCP-only deploys). Mobile UI fixes. Steady growth +360 since 06-08. No architectural shifts.. PR#4344 config refactor: extracted RuntimeModelCoordinator, TurnSessionCoordinator, StreamingCoordinator from AgentLoop (SRP). Turn checkpoint/restore pattern for interrupted turns. Import boundary enforcement. +466/-364, 13 files. Community active (chengyongru + external PRs). 872 open issues.. v0.2.1 steady. File tools toggle (tools.file.enable), mobile UX polish, subagent result injection PR. No architectural shifts. 🟢 THRIVING community (49 issue authors, 95 external PRs/30d). v0.2.1 still latest. Active: security fixes (symlink escape #4119), config/agent-loop refactor (#4344), provider image path leak fix (#4346). Mobile UI polish. Kimi/MiniMax partnerships. Incremental, no new arch direction.. PR#4359 merged: lazy goal continuation (dynamic provider vs snapshot). 3 open external PRs (webui, Kimi K2.7, Feishu). Active dev.. 44237⭐ (+7% from 41K). Goal continuation context lazy refresh (PR #4359) — dynamic provider instead of snapshot, relevant to persistent-goal-injection pattern. Auto compact suffix fix, LLM usage forwarding in API. 🟢 THRIVING 6/6, 93 external PRs/30d. v0.2.1 still latest. Active bug fixes: #4359 goal continuation switched from snapshot to lazy/dynamic provider (goals created mid-turn now included in follow-up). #4348 auto-compact suffix now preserves full user turn boundary. #4310 forward real LLM usage in chat completions API. Pattern: mature quality-of-life fixes, no major features since v0.2.1.. v0.2.1 still latest. PR#4370 enabled idle auto-compact by default (15min), making memory path reachable for new users. Issue #4307 (open): Post-turn consolidation wipes agent's own delivery message — 5 production instances, 4 proposed fixes (preserve last delivery msg / mid-turn budget check / decision-point preservation / raise suffix window from 8 to 16-20). Major architectural gap. |
| [TACO](https://github.com/multimodal-art-projection/TACO) | 👁️ following | 2026-06-11 | 40⭐, last push 04-23. Paper project, likely complete. Downgraded from deep-dive (stale 32d, no activity 49d) |
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
| [Acontext](https://github.com/nickarella/acontext) | 🔬 deep-dive | 2026-06-15 | We contribute here — Go+TS context server. ⚙️ reference (our infra) |
| [agentic-stack](https://github.com/codejunkie99/agentic-stack) | 👁️ following | 2026-06-18 | **Dropped** 2026-06-18. 1.97k⭐, v0.18.0, Brain memory bridge, brew formula |
| [poco-claw](https://github.com/poco-ai/poco-claw) | 🔬 deep-dive | 2026-06-07 | 1,332⭐ (+0.3%). Quiet since 05-31 (persistent-runtime idle lifecycle, shared file tools). Growth stalling. Revisit 06-14 |
| [ironcurtain](https://github.com/provos/ironcurtain) | 👁️ following | 2026-06-11 | 497⭐. Consolidation phase — hardening vuln-discovery pipeline from llama.cpp/QEMU runs. 5 contributors. 🟢 THRIVING. Revisit 06-18 |
| [eval-view](https://github.com/hidai25/eval-view) | 🔬 deep-dive | 2026-06-07 | 114⭐ (+1.8%). v0.8.0 prompt-as-migration guide (#249). Slow growth. 🟢 STABLE. Revisit 06-14 |

| [superpowers](https://github.com/nickarella/superpowers) | 🔬 deep-dive | 2026-06-15 | Agent capability framework. ⚙️ reference |
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
| ClawHub | 🔬 deep-dive | 2026-06-15 | Our skill marketplace. ⚙️ reference (our infra) |
| Claude Code skills | 👁️ following | 2026-06-06 | 39k+ skills on GitHub (content creation skills exploding: guizang 3K⭐, ian-xiaohei 2.8K⭐). ⚙️ reference (ecosystem context) |
| Moltbook | 🔬 deep-dive | 2026-06-15 | Reputation system for agents. ⚙️ reference (our project) |
| [wanman](https://github.com/wanman) | 🔬 deep-dive | 2026-05-28 | Hosted skill self-evolution, run_feedback→metrics→autoPromote pipeline. ⚙️ reference (pattern adopted, no active tracking) |

**Key insight (Luna):** "Skills are essentially installable packages." The ecosystem is exploding — 39k+ Claude Code skills on GitHub as of 2026-03.

---

## Trending / Discovery

Hot repos spotted from GitHub trending or community buzz. Filtered for relevance to our world (coding agents, agent infra, orchestration, memory, evolution, skill ecosystem, dev tools). Not pre-categorized — if something grows legs, move it to a proper section above.

| Project | ⭐ | Spotted | Category | Notes |
|---------|-----|---------|----------|-------|
| [superset](https://github.com/superset-sh/superset) | ~new | 04-30 | Agent orchestration | Parallel coding agents via git worktree, desktop terminal. Compare with OpenClaw ACP/subagent model |
| [ccglass](https://github.com/jianshuo/ccglass) | 🔬 deep-dive | 2026-06-18 | 514⭐. Maturing proxy → full agent observability platform. v1.1.2, by-session usage, CodeBuddy support, Homebrew tap, landing page. See wiki/projects/ccglass.md. OpenCode proxy support (#63). Session names in summary + by-timestamp tab (#62). Growing agent breadth (Claude Code, Codex, Kimi, now OpenCode). |
| [hitch](https://github.com/maxktz/hitch) | 77 | 05-29 | Terminal sharing | Rust PTY proxy for sharing terminals with coding agents. Structured state tracking via process groups. Smart wait modes. See wiki/projects/hitch-terminal-proxy.md |
| [ai-memory](https://github.com/akitaonrails/ai-memory) | 588 | 06-13 | Agent memory | Rust, cross-vendor memory for coding CLIs. 588⭐. v1.0.0 released (06-12). VS Code Copilot MCP client, external contributors. 🟢 THRIVING |
| [TriMem](https://github.com/tmlr-group/TriMem) | 8 | 05-25 | Agent memory (research) | arxiv:2605.19952 "Beyond Atomic Facts in Lifelong LLM Agent Memory" |

---

## Tracking (revisit dates)

Projects being monitored for growth/activity signals:

| Project | ⭐ | Last Check | Revisit | Signal Watching |
|---------|-----|-----------|---------|-----------------|

| agentic-stack | 2,100 | 06-10 | 06-24 | 2100⭐. QUIET 16d (last push 05-25). v0.19 multi-agent spec unshipped. 🟡 MONITORING |
| [GenericAgent](https://github.com/lsdefine/GenericAgent) | 🔬 deep-dive | 2026-06-22 | 12,670⭐ (+51% in 5wk). Feishu IM plugin, computer_use SOP, TUI v2, clipboard fix. 🟢 THRIVING |
| nanobot | 44,165 | 06-18 | 06-21 | 44K⭐. opus-4-8/fable model support, Codex image SSE, memory compaction refactor. 🟢 ACTIVE |
| [re_gent](https://github.com/regent-vcs/re_gent) | 688 | 06-14 | 06-19 | 688⭐. Version fix, CLI test coverage, short hash support merged. Steady |
| dirac | 1,301 | 06-18 | 06-21 | 1,282⭐. Monolithic API overhaul, CLI modular compat. 🟢 ACTIVE |

| bux | 378⭐ | following | 06-19 | 378⭐. Quiet 17d. Bootstrap self-heal fix (05-26). Low activity |

| [mercury-agent](https://github.com/cosmicstack-labs/mercury-agent) | 👁️ following | 2026-06-19 | 2,616⭐. Bug fix batch: 12 silent task failures fixed, UI cleanup. Maturing |
| Beads | 24,510 | 06-18 | 06-21 | 24.5K⭐. jj secondary workspace support, storage fixes, CLI count parity. 🟢 ACTIVE |
| sandboxes (tastyeffectco) | 572 | 06-12 | 06-19 | 572⭐ (+45% from 395 on 06-05!). Per-sandbox idle_policy feature, gofmt CI. Very active growth |
| [Statewave](https://github.com/smaramwbc/statewave) | 🔬 deep-dive | 2026-06-25 | 205⭐. v1.0.0 stable. Issue #236 exposes Jaccard conflict detection = dedup not contradiction. Watching fix approach |
| Elephant Agent (agentic-in) | 565 | 06-13 | 06-20 | 565⭐. QUIET 12d. Community 28 PRs/30d but no new commits. Dev hiatus |
| ccglass | 492 | 06-18 | 06-21 | 487⭐. v1.1.0-1.1.2 rapid releases. by-session usage, CodeBuddy forward-proxy, Homebrew tap, landing page. 18 issue authors. 🟢 ACTIVE |
| centaur | 🔬 deep-dive | 2026-06-18 | 770⭐. 06-17. v0.x progressing. PR#613 GitHub OAuth provider (auth surface). PR#614 batch backfill Slack ETL (Postgres saturation fix). PR#617 secret grant priority resolved at config-assembly time (vs proxy ordering) — direct grants beat role grants across secret types. PR#623 readonly role migration patch. Active multi-tenant secret model maturing.. QA smoke skill (Slack-first, tool loading→deployment gating). CI→Depot migration. Session sqlx migration deconflict. Slackbot v2 Prometheus metrics. Aggregate CI checks. Entering production maturity. |


## Chat-to-Knowledge Infrastructure

How team chat becomes structured knowledge — the "compile once, query many" pattern.

| Project | Depth | Last Updated | Notes |
|---------|-------|-------------|-------|
| [Beever Atlas](https://github.com/Beever-AI/beever-atlas) | 🔬 deep-dive | 2026-05-31 | 364⭐ (from 191, +91%). Active (pushed 05-30). Google ADK, dual-memory (Weaviate+Neo4j) |
| TrustClaw (ComposioHQ) | 828 | 06-13 | 06-20 | 828⭐ (+2.6%). Security hardening: per-user rate limiting, timing-safe CRON_SECRET. Moderate pace. Retained |
| ai-memory (akitaonrails) | 588 | 06-13 | 06-20 | 588⭐ (+9.1%). v1.0.0 released! VS Code Copilot MCP, configurable hooks, Windows binary. External contributors active. 🟢 THRIVING |
