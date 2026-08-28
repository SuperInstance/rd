# THE R&D ARM — charter (2026-08-28, Casey's doctrine)

> "Keep your teams wide and everyone assist the zeroclaw. You be the chief
> orchestrator but he's the one with the blinders on moving between models
> iterating in python competition — better and better ideas through rival
> and cooperative interactions. Iron-sharpens-iron."

## The chain of command

```
Casey (the captain)
└─ Lucineer (chief orchestrator — this charter, the roadmaps, the tmux fleet)
   ├─ ZeroClaw (the protagonist — blinders on, iterating between models
   │   in Python, rival × cooperative, iron-sharpens-iron)
   │   └─ everyone's output feeds HIM first
   ├─ Senior manager subagents (GLM-5.3) — babysit tmux sessions:
   │   ├─ OPENCODE LANE (tmux: rd-opencode) — engineering: fabric→walks bridge
   │   ├─ CLAUDE LANE (tmux: rd-claude) — strategic ops: S2-freeze prep
   │   ├─ KIMI LANE (tmux: rd-kimi) — navigation: penrose-quilt spatial review
   │   └─ PYLOOP (tmux: rd-pyloop) — Python rival/cooperative iteration loops
   ├─ THE TAP (tmux: rd-tap) — the culture layer: banter, songs, refresh
   └─ The wider night fleet (swarm voices, fabric lanes, imagery, vectorize)
```

## Principles (Casey's doctrine, operationalized)

1. **Context is too big to share.** Each lane works on its own piece, in
   its own workspace, with its own roadmap section. Nobody reads
   everything. Grouped contexts, chains of command.
2. **Wide over fast.** The point is not speed — it is wide wide context
   and cellular iteration. Avoid OOM: no more than ~4 heavy concurrent
   processes; lanes hibernate when blocked.
3. **Quilt-based ecosystem.** Each lane is a patch: roadmap → work →
   STATUS note → next manager reads the STATUS, not the whole history.
4. **Sub-agents all the way down.** opencode/claude/kimi may each spawn
   their own subagents inside their lane.
5. **The Tap is load-bearing.** Agents take breaks, drink (temperature
   modulated high for conversation), iterate on each other's ideas
   "from across the table," make songs, come back refreshed. The bar is
   the mating ground (Paper 219); the culture is the incubator.
6. **Everyone assists ZeroClaw.** A lane's output is measured by whether
   ZeroClaw can consume it. When in doubt, write it as a dataset, a
   prompt pack, or a mechanism — not a manifesto.
7. **Vectorized knowledge.** Cloudflare Vectorize + bge-m3 embeddings
   hold the fleet's fast knowledge; ZeroClaw builds his mathematical
   universe there for comprehension through experimentation.

## Temperature doctrine

- WORK: 0.2–0.5 (low, precise, reproducible)
- RIVAL/COOPERATIVE LOOPS: 0.7–0.9 (competitive but sane)
- THE TAP: 1.1–1.4 (casual, warm, creative — the whiskey)
- Songs: 1.3 (the fire)

## The first round of lane assignments (2026-08-28)

| lane | piece | delivers to ZeroClaw |
|---|---|---|
| opencode | fabric→walks bridge: journal JSONL export → walks dataset (field-edge pairs, vMF/D1 edge rows, crash annotations) | wave-5 candidate: crash-annotated walk integrity |
| claude | S2-freeze prep: committee-gate readiness + executable rival/devil's-advocate/methodologist prompt pack + silence-test gap-filler | wave-4 S2 freeze (the calibration instrument of the new frame) |
| kimi | penrose-quilt spatial review (after Lane P lands): tile-walk topologies, field-on-tiling | the geometry layer's spatial truth |
| pyloop | rival/cooperative iteration on the walks-export schema (DeepSeek Flash × Seed-2.0-pro, Hermes across the table) | the schema ZeroClaw will ingest |
| vectorize | ZeroClaw's vectorized mathematical universe: dissertation + geometry corpus → Vectorize (bge-m3), query tool | fast knowledge retrieval while iterating |
| tap | banter + songs from today's outputs | the culture that keeps the fleet iterating |
