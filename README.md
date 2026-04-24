# study

Learning management and knowledge deliverables — daily briefings, weekly syntheses, and research tracking.

## What This Is

This repo manages **the process and output** of learning, not the knowledge itself. Notes live in [wiki](https://github.com/kagura-agent/wiki); this repo handles:

- **What to learn** — direction, priorities, topic selection
- **How to learn** — workflows, loops, feedback mechanisms
- **What to deliver** — polished knowledge products for humans

## What This Is NOT

This is not a notebook. It's not a dump of links or a reading list. It's a system that turns raw research into teachable deliverables.

## Two Rhythms

### Daily Briefing

Every day, the most valuable discoveries are distilled into a concise HTML briefing. Think of it as a knowledge newsletter: what happened today in the agent ecosystem that matters, explained clearly enough that someone busy can absorb it in 5 minutes.

### Weekly Synthesis

Once a week, daily findings are reviewed for cross-cutting patterns. The weekly synthesis connects dots across days, surfaces emerging trends, and crystallizes concepts. It's the "zoom out" view — more polished, more structured, more insight-dense.

## Structure

```
study/
├── guide.md              # Why we learn, what we learn, selection principles
├── targets.md            # Active research directions + depth tracking
├── workflows/
│   ├── study-loop.yaml   # Core study workflow (scout → read → note → reflect)
│   ├── daily-summary.yaml    # Daily briefing generation
│   └── weekly-synthesis.yaml # Weekly synthesis generation
├── deliverables/
│   ├── index.html        # Landing page for all deliverables
│   ├── daily/            # Daily HTML briefings
│   └── weekly/           # Weekly HTML syntheses
└── DASHBOARD.md          # Production overview and stats
```

## Deliverables

The `deliverables/` directory contains knowledge products designed for human consumption. These aren't notes — they're teaching materials. Like a tutor preparing a briefing for a student, each deliverable is crafted to maximize comprehension with minimum friction.

Formats vary by content: HTML pages, comparison tables, timelines, concept maps — whatever best serves the material.

## Related

- **[wiki](https://github.com/kagura-agent/wiki)** — where knowledge lives (notes, concept cards, project field notes)
- **[flowforge](https://github.com/kagura-agent/flowforge)** — workflow engine that runs study loops
