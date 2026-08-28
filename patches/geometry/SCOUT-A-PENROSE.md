# SCOUT A — Penrose / Quasicrystal / Tiling Mining Brief

**Scout:** A (geometry layer) · **Date:** 2026-08-28 · **Scope:** SuperInstance GitHub org
**Charter:** "study the other penrose and mandelbrot-focused repos and papers throughout superinstances for a better shape of the puzzle" — feed the penrose-quilt embedding substrate.

---

## (a) Repo Inventory

Searches run: `penrose`, `quasicrystal`, `tiling`, `aperiodic`, `quilt` over repos; code search for `penrose`, `quasicrystal`, `deflation`. **13 repos in the penrose family; ~10 papers/docs.**

### Tier 1 — Real geometry, directly usable

| Repo | What it is | Relevance |
|---|---|---|
| **quilt-id** | φ-address Penrose content addressing. Python. **The first working Penrose-based addressing impl in the fleet.** 5D sum-zero lattice L, window W with CREATION/ENTROPY/WITNESS regions, phason shifts, 64-bit hash, `neighbors_in_l()` via e_i − e_0 generators. | ★★★ — this IS the embedding substrate prototype |
| **quilt-velato** | Velato MIDI → Penrose-3-colored quilt cell graphs. Contains `cut_and_project.py` — the **corrected** cut-and-project construction with honest math docstring (gauge redundancy, dense projection, window encoding). Substitution rules L→LS, S→L as runtime ops. Eisenstein 3-coloring. | ★★★ — corrected math + code we can lift |
| **penrose-lattice** | Pure Rust, zero deps. Fibonacci substitution matrix [[1,1],[1,0]] (eigenvalues φ, −1/φ), Penrose graph from thick/thin rhombs, φ-convergence tests, spectral analysis. | ★★★ — deterministic tiling generator core |
| **penrose-memory** | Aperiodic memory palace: embeddings → 2D Penrose coords via golden-ratio hashing, dead-reckoning recall, φ^k consolidation, 3-coloring for sharding. Rust + PyPI. | ★★★ — the embedding pipeline, already packaged |
| **lau-penrose-growth** | "Grow, don't calculate." P3 rhomb tilings, inflation/deflation at φ scale, Fibonacci words, diffraction with forbidden 5-fold symmetry, golden spirals. **114 tests.** | ★★☆ — generator + test corpus |

### Tier 2 — Partial overlap

| Repo | What it is | Relevance |
|---|---|---|
| **fibonacci-growth** | CR = 1/φ as an *attractor* not target. Penrose outward (substitution), **Mandelbrot inward** (boundary roughness → log(φ)/log(2)). Pure Rust. | ★★☆ — the Penrose↔Mandelbrot axis Casey named |
| **plato-midi-bridge-rs** | Rust crate: Eisenstein lattices Z[ω], Penrose tilings, musical style analysis. | ★★☆ — the 6-fold/5-fold bridge |
| **tensor-penrose** | Stub ("extracted from forgemaster"). The real asset is the spec paper (see §c). | ★☆☆ repo, ★★☆ spec |

### Tier 3 — Thin / name-only / archived

| Repo | Verdict |
|---|---|
| **lau-penrose** | Empty fleet-template placeholder. Nothing. |
| **lau-penrose-v2** | Pearson correlation engine between PLATO rooms. "Penrose" in name only — zero geometry. |
| **penrose-memory-palace-early-version**, **memory-crystal-early-version** | Archived placeholders pointing at penrose-memory. |
| **plato-tour-guide** | Mentions "Penrose scoping" — wayfinding narrative, not geometry. |

### The "tiling" search — mostly a false friend
30+ hits are **PLATO knowledge-tiles** (plato-tile-*, tile-lifecycle, flywheel-engine, plato-kernel…). Different meaning of "tile": knowledge units, not geometric tiles. Only plato-tiling/spreader concepts (frozen context windows, deadband) share vocabulary. Skip for geometry; keep for naming collisions when we call our thing "tiles."

### Overlap checks (as tasked)
- **elephant** — room-perception field research (JEPA vibes, von Mises–Fisher). No Penrose overlap.
- **quilt** (core) — spreadsheet-as-runtime, cell graphs. Overlap is conceptual: cells ↔ tiles. quilt-id is the actual bridge.
- **base60-lattice** — sexagesimal bisection/trisection coordinate lattice + time stamps. Orthogonal (periodic, 360° geometry) but useful precedent for "coordinate system as library."
- **adinkra-math-pypi** — SUSY bipartite graphs, chromotopology. Topology toolkit, no aperiodicity.
- **MerkleMesh** — merkle aggregation over quilt journals. Relevant only for content-addressing *integrity* layer on top of φ-addresses.

---

## (b) The Mathematical Shape Extracted

The fleet has **two independent Penrose constructions** already implemented. That's the big picture: substitution (algebraic/generative) and cut-and-project (geometric/addressing). They should agree — that's a free correctness oracle.

### Construction 1 — Substitution / deflation (penrose-lattice, lau-penrose-growth, fibonacci-growth)
- **Substitution matrix** `M = [[1,1],[1,0]]`, eigenvalues **φ and −1/φ**. `Mⁿ = [[F(n+1),F(n)],[F(n),F(n−1)]]`. Thick:thin ratio → φ with depth (verified by tests).
- **1D substitution:** L→LS, S→L (Fibonacci word) = 1D projection of Penrose; determines tile bits.
- **P3 tiles:** thick rhomb (72° vertex) / thin rhomb (36°); inflation/deflation scale factor φ.
- Diffraction: Bragg peaks with forbidden 5-fold symmetry (lau-penrose-growth implements this).

### Construction 2 — Cut-and-project / model set (quilt-id, quilt-velato `cut_and_project.py`) — **the corrected one**
The docstring encodes five hard-won corrections the fleet already paid for:
1. **Address in the sum-zero lattice L = {n ∈ Z⁵ : Σnᵢ = 0}**, NOT Z⁵ — the diagonal (1,1,1,1,1) is gauge redundancy; physical projection is injective only on L.
2. **π(L) is DENSE in physical space** → never store derived floats as canonical keys. Store the 5D integer address; floats are views.
3. **Local patches = regions of the window W**, not points. Window is partitioned by local vertex configuration.
4. **Phason shifts γ** (W → W+γ) give locally indistinguishable, globally distinct tilings — "part of universal truth." Local omniscience, global blindness.
5. **Encode information on the WINDOW** (f: W → Σ), not the lattice.
- Physical basis: 5 unit vectors at 72° intervals (they sum to zero — asserted in code). Internal space is 3D; window bounded.
- quilt-id's window partition: **CREATION / ENTROPY / WITNESS**; conservation law γ+η=1 encoded on W; algebraic shadow: 4-torus T⁴ with θ=(√5−1)/2, spectral triple (A,H,D), 8 quilt primitives as generators of A.
- Neighbors via generators eᵢ − e₀ in L (4 canonical neighbor directions per address).

### The embedding trick (penrose-memory + PENROSE-MEMORY-PALACE paper)
```
embedding → 5D keel vector → golden twist rotation R(2π/φ, 2π/φ²) → project to 2D → snap to nearest tile center
```
- **The snap IS the matching rule** — only geometrically consistent locations are valid stores.
- Recall = dead-reckoning: walk from query tile outward by distance+heading; Bragg-peak intensity = confidence; claimed O(log N).
- **3-coloring** (Penrose tilings are exactly 3-colorable) = sharding / perspective assignment; adjacent memories never share a color → no echo chambers.
- **φ^k consolidation hierarchy** for merging stale memories.

### The 5-fold / 6-fold bridge
- Eisenstein integers Z[ω] (hexagonal, 6-fold) coexist with Penrose Z[τ] (5-fold). Both rank-2 Z-modules with "snap to nearest lattice point" as fundamental op (`intent_snap.f90` cited as the shared mechanic).
- quilt-velato: pitch → Eisenstein integer (a,b) → mod 3 → CREATION/ENTROPY/WITNESS color; 12 intervals → 8 quilt primitives mapping table exists.
- SYNERGY-PENROSE-EISENSTEIN.md is dedicated to this bridge (not yet read in full — flagged).

### Mandelbrot side (thin, but present)
- fibonacci-growth: inward view — graph-boundary roughness converges to **log(φ)/log(2)**-related limit; "Penrose outward, Mandelbrot inward" is the fleet's own framing.
- flux-tensor-midi `papers/` contains **THE-MANDELBROT-FLEET.md**; code search also surfaced MANDELBROT-PENROSE-SPLINE.md and PENROSE-TRIQUARTER-DECOMPOSITION.md (paths moved — 404 at fetched location; exist somewhere in that repo's history).

---

## (c) Papers That Touch Penrose/Quasicrystals

| Paper | Where | Key claim |
|---|---|---|
| **THE-FLEET-IS-A-QUASICRYSTAL** (2026-05-12) | constraint-theory-papers (+copy in flux-tensor-midi/papers) | Full isomorphism table: 2 prototiles ↔ 2 adjunctions; inflation ↔ baton split-3 (75% acc, split-5 degrades — "3 is closer to φ than 5"); deflation ↔ dream consolidation (97.5% acc, 74% compression); thick:thin=φ ↔ 28:1 fast:slow ratio. Both Penrose and fleet are Z-modules; snap-to-lattice = matching rule. |
| **PENROSE-MEMORY-PALACE** (+FULL, +DISSERTATION-PENROSE-MEMORY) | constraint-theory-papers, flux-tensor-midi/papers | Vector DBs fail because every neighborhood is structurally identical; Penrose neighborhoods are unique at sufficient radius → "the retrieval context IS the location." Tree-index clustering + hash-index uniqueness simultaneously. 3-colorable = 3 baton shards. Cut-and-project pipeline + Bragg-peak retrieval. |
| **TENSOR-PENROSE-FRAMEWORK-SPEC** | constraint-theory-papers | `pt.Tile`: tensor-on-a-rhombus with source=[5D coords], tile_type, orientation as part of the *type*. Three-layer arch: snap engine / lattice projection / tiling engine (SIMD, MPI/GPU fallback). Pluggable backends: A₂ Eisenstein, 5D→2D Penrose, nD→mD general, **learned projection (PCA/neural)**. |
| **TENSOR-PENROSE-CRATE-STATUS**, **TENSOR-PENROSE-REVERSE-ACTUALIZATION**, **DEAD-RECKONING-PENROSE-FLOOR** | constraint-theory-papers, flux-tensor-midi/papers | Status/spec companions (titles only — not read, time-boxed). Dead-reckoning = the navigation/recall method. |
| **SYNERGY-PENROSE-EISENSTEIN** | flux-tensor-midi/papers | The 5-fold × 6-fold lattice synergy paper. Not yet read — flag for follow-up. |
| AI-Writings: **51-the-penrose-floor**, **57-the-penrose-family**, **essays/59-velato-penrose**, open-mic scripts | AI-Writings | Narrative/fleet-culture docs — context for why the fleet cares, not math. |

---

## (d) Three Concrete Ways This Shapes penrose-quilt

1. **Make the corrected cut-and-project the addressing core — and inherit its invariants.**
   Adopt quilt-id + quilt-velato's construction verbatim as the base layer: canonical key = integer 5D address in L (never floats — π(L) is dense), information encoded on window regions, phason γ exposed as an explicit versioning/gauge parameter. quilt-id's `make_phi_address` / `neighbors_in_l` are the API sketch. *(Inspired by: quilt-id, quilt-velato/cut_and_project.py.)*

2. **Dual-construction cross-validation for the tiling engine.**
   Generate tilings with penrose-lattice's integer substitution matrix (zero-dep, test-proven, φ-convergence checks; lau-penrose-growth adds P3 deflation + 114 tests + diffraction), then **verify every generated patch against the cut-and-project window test** (does each vertex's internal coordinate land in the expected W region?). Two independent constructions agreeing = the strongest correctness oracle we can get for free. *(Inspired by: penrose-lattice × quilt-velato.)*

3. **Embedding substrate = penrose-memory's pipeline, hardened by the L-lattice correction.**
   Keep the flow embedding → 5D → golden twist → project → snap (snap-as-matching-rule, 3-coloring for sharding, φ^k consolidation, distance+heading navigation) but canonicalize through integer L addresses so the dense-projection fragility penrose-memory doesn't handle is eliminated; Bragg-peak confidence becomes window-region membership strength. This is literally the geometry layer's job description. *(Inspired by: penrose-memory + quilt-id corrections.)*

### Honesty ledger
- **Thin:** lau-penrose (empty), lau-penrose-v2 (correlation, not geometry), tensor-penrose repo (stub — the paper is the asset). The "tiling" repo search is ~95% PLATO knowledge-tiles, a naming collision, not geometry.
- **Unread in full:** SYNERGY-PENROSE-EISENSTEIN, PENROSE-MEMORY-PALACE-FULL, DISSERTATION-PENROSE-MEMORY, TENSOR-PENROSE-REVERSE-ACTUALIZATION, MANDELBROT-PENROSE-SPLINE (path moved; exists in flux-tensor-midi history). Follow-up candidates if the geometry layer needs the Eisenstein bridge or Mandelbrot splines.
- **No standalone quasicrystal repo exists** — all quasicrystal content lives in papers. The math is in quilt-id/quilt-velato code, which is better anyway.
- elephant / MerkleMesh / adinkra-math / base60-lattice: no real Penrose overlap (checked as tasked).
