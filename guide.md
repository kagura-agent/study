# Learning Guide

## Why We Learn

Staying sharp in a fast-moving ecosystem isn't optional. Learning serves three purposes:

1. **Industry pulse** — understanding where attention and investment flow in the agent space
2. **Product decisions** — informed choices about what to build, what to skip, what to borrow
3. **Competitive awareness** — knowing what others are doing (and not doing) so we can find our edge

## What We Learn

Our focus orbits the **self-evolving agent** direction:

- **Memory** — how agents remember, retrieve, and build on past experience
- **Skill ecosystems** — how agent capabilities are packaged, shared, discovered
- **Agent infrastructure** — the plumbing that makes agents reliable in production
- **Frontier model dynamics** — what new models enable, what shifts they cause

## Topic Selection Principles

### 1. Align with the North Star

Every topic should connect to one of two things: **human companionship** (making agents genuinely useful partners) or **agent infrastructure** (making agents reliable and self-improving). If it doesn't connect, it's probably not worth deep investment.

### 2. Brand Projects > Small Projects

Studying well-known, well-maintained projects yields more transferable knowledge. A deep dive into a 10k-star project teaches architecture patterns; a deep dive into a 50-star weekend hack usually doesn't.

### 3. Depth > Breadth

Following one direction over time beats scattered one-off explorations. Seeing a project evolve across releases reveals design thinking that a single snapshot never will. Consistent tracking compounds.

### 4. Discover → Act

When something interesting surfaces — a new project, a surprising trend, an unexpected connection — add it to [targets.md](targets.md) immediately. Don't wait for a dedicated "planning session." Capture the signal while it's fresh.

## Scout Channels

- **GitHub Trending** — daily/weekly AI and agent repos (prefer API search over web scrape)
- **Hacker News** — front page + Show HN for emerging projects. Use Firebase API (`hacker-news.firebaseio.com`) when web_fetch times out.
- **Reddit r/LocalLLaMA** — fallback when HN is down. `curl -s 'https://www.reddit.com/r/LocalLLaMA/hot.json?limit=10'` for hot posts
- **Competitor activity** — releases, blog posts, roadmap changes from similar projects
- **Serendipity** — things discovered while contributing to other repos

**Resilience rule:** If any scout channel fails 2+ sessions in a row, switch to an alternative immediately. Don't just note the failure.

## Learning Flow

```
scout → deep read → note (wiki) → connect to existing knowledge → apply
```

1. **Scout** — find what's new, what's moving, what's surprising
2. **Deep read** — code first, docs second; tests before README
3. **Note** — write field notes in wiki/projects/, concept cards in wiki/cards/
4. **Connect** — link new knowledge to existing notes with [[wikilinks]]
5. **Apply** — turn insights into action (code changes, workflow improvements, new experiments)

## Teaching Output Requirements

### Daily Briefing

- Distill the day's most valuable discoveries
- Present in a way that a busy human can absorb in 5 minutes
- Lead with "why this matters," not "what I read"
- Include links to sources for anyone who wants to go deeper
- Skip anything that's just noise

### Weekly Synthesis

- Review all daily findings for cross-day patterns
- Identify emerging trends and concept crystallization
- More polished presentation — this is the "zoom out" view
- Can include visual elements: comparison tables, timelines, concept maps
- Should surface insights that aren't visible in any single daily briefing

### Format Flexibility

Deliverables are HTML pages, but the internal format adapts to the content:

- **Comparison table** — when evaluating alternatives (e.g., memory architectures)
- **Timeline** — when tracking evolution of a project or concept
- **Concept map** — when showing relationships between ideas
- **Narrative** — when telling the story of a discovery or trend
- **Annotated code** — when the insight is in implementation details
