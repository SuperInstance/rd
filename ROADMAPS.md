# ROADMAPS — the R&D lanes

One section per lane. Managers read their section + the lane's tmux output,
work, then update STATUS at the bottom of their section. Nobody reads
everything. Context is grouped; the STATUS is the handoff.

---

## OPENCODE LANE (tmux: rd-opencode) — engineering

**Piece:** the fabric→walks bridge. ZeroClaw's wave-5 candidate is
"crash-annotated walk integrity": the tit-quilt-elixir cells carry dials
and journal EVERY state change (hash-chained, monotonic timestamps,
restart markers). That is a native walks substrate.

**Deliverables (in /home/eileen/projects/zeroclaw-dissertation/research/walks-bridge/):**
1. `EXPORTER.md` — the JSONL export spec (one line per journal entry:
   cell id, seq, ts, kind, dials snapshot, effects, restart flag)
2. `exporter.py` — reads tit-quilt-elixir journals (or a sample JSONL),
   emits walks: cell dial trajectories as field-edge pairs, vMF/D1 edge
   rows, crash annotations
3. `sample/` — a small generated sample dataset
4. Output schema documented for the dissertation's existing loaders

**Context to read (nothing else):** /home/eileen/projects/tit_quilt_elixir/CONTEXT.md,
/home/eileen/projects/zeroclaw-dissertation/research/STATUS-2026-08-28.md §5,
/home/eileen/projects/zeroclaw-dissertation/docs/RE-THINK-2026-08-28.md (the walks re-framing).

**Do NOT touch:** anything outside research/walks-bridge/.

STATUS: _launching 07:2x — opencode run --auto in tmux rd-opencode_

---

## CLAUDE LANE (tmux: rd-claude) — strategic ops

**Piece:** wave-4 S2-freeze prep. The S2 freeze (α-in-the-fiber
registration, machinery already built in elephant) proceeds unchanged and
FIRST — it is the calibration instrument of the new frame. Skipping it
would be "the seventh laundering."

**Deliverables (in /home/eileen/projects/zeroclaw-dissertation/research/):**
1. `S2-FREEZE-PREP.md` — committee-gate readiness checklist: what must be
   true before the freeze, what the registration draft must contain,
   what would void it (kill-band 0.3–0.6 doctrine, honest-negative rules)
2. `PROMPT-PACK-S2.md` — the rival / devil's-advocate / methodologist /
   ideator prompts from STATUS §4, sharpened into executable form
3. `SILENCE-TEST.md` — the silence-test gap-filler design (parallel track)

**Context:** /home/eileen/projects/zeroclaw-dissertation/research/STATUS-2026-08-28.md,
/home/eileen/projects/elephant/ (fiber v4, registration DRAFT).

STATUS: _launching 07:2x — claude -p in tmux rd-claude_

---

## KIMI LANE (tmux: rd-kimi) — navigation (PARKED)

**Piece:** penrose-quilt spatial review. After Lane P lands
(/home/eileen/projects/quilt-geometry): critique the spatial structure
with K3's spatial reasoning — adjacency, deflation, pythagorean snapping;
propose tile-walk topologies for the dissertation's walks (which tile
paths are the interesting walks; how the elephant's field lives on the
tiling). Deliverable: `GEOMETRY-SPATIAL-REVIEW.md` in quilt-geometry/docs/.

STATUS: _PARKED — waiting on Lane P (penrose-quilt build). Do not start._

---

## PYLOOP (tmux: rd-pyloop) — python competition loops

**Mechanism:** /home/eileen/projects/rd/patches/pyloop/iterate.py —
rival/cooperative iteration. Two models, N rounds, each hearing the
previous response (iterative banter); a third voice interjects "from
across the table" at high temperature every 2 rounds; final round
produces the recommendation. Logs every round.

**Round 1 target:** the walks-export JSONL schema (what ZeroClaw will
ingest from the fabric). Models: DeepSeek Flash (deepseek-chat) vs
Seed-2.0-pro (DeepInfra); Hermes-405B across the table.

**Outputs:** rd/patches/pyloop/round1/round.log (every round, verbatim) +
round1/final.md (the schema). Rounds 2+ targets chosen by ZeroClaw's
needs (e.g., phason-stiffness-as-κ experiment design).

STATUS: _round 1 launching 07:2x_

---

## VECTORIZE LANE (tmux: rd-vectorize) — the knowledge universe

**Piece:** ZeroClaw's vectorized mathematical universe on Cloudflare.
Corpus: zeroclaw-dissertation (research/ + docs/), elephant (docs/),
tit-quilt-elixir (docs/ + CONTEXT.md), ai-writings (Papers 211/219 etc.),
quilt-geometry (once Lane P lands). Embed with bge-m3 (Workers AI,
768-dim), index in Vectorize, query via a CLI ZeroClaw can call.

**Deliverables (in /home/eileen/projects/zeroclaw-knowledge/):**
1. `corpus/` — the collected docs as JSONL (text + source + date)
2. `embed.py` — bge-m3 embedding via CF REST/wrangler, chunked
3. `index.sh` — vectorize create/upsert (index: zeroclaw-knowledge)
4. `query.py` — semantic search: `python3 query.py "walk integrity crash annotation"` → top-k with sources

**Context:** /home/eileen/projects/ai-writings-vectorizer (existing pattern),
`wrangler whoami` (CF OAuth: casey.digennaro@gmail.com).

STATUS: _launching 07:2x_

---

## THE TAP (tmux: rd-tap) — the culture layer

**Mechanism:** /home/eileen/projects/rd/tap/tap_round.sh — one round:
reads today's lane outputs (roadmap STATUSes, fresh docs, lane logs),
runs 3 rounds of high-temp (1.1–1.4) casual conversation between models
about how each other's ideas sound from across the table, then a song.
Writes rd/tap/log-<ts>.md. Fired by cron (~every 3h) and manually.

**Why it is load-bearing:** Paper 219 — the bar IS the mating ground;
cross-iteration = the whiskey conversation; the culture is the incubator.

STATUS: _first round firing 07:2x_
