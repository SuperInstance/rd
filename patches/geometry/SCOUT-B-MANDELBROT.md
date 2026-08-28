# SCOUT B — Mandelbrot / Fractal / Complex-Dynamics Mining Brief

**Scout:** B (geometry lane) · **Date:** 2026-08-28 · **Scope:** SuperInstance GitHub, fractal-space work relevant to the origin-centric cellular geometry layer (cross-sectional heat mapping, changeable x/y, higher-dim embedding).

---

## (a) Repo Inventory

Searches: `mandelbrot`, `fractal`, `julia`, `complex dynamics`, `chaos`, `quaternion`, `penrose` (code search for mandelbrot/fractal too). **12 direct fractal/dynamics repos + 3 paper corpora.**

| Repo | What it holds | Relevance |
|------|--------------|-----------|
| **fractal-gen-rs** | Mandelbrot, Julia, Burning Ship, Sierpinski, Koch in pure Rust | Core escape-time implementation |
| **lau-complex-agents** | Full complex analysis for agents: contour integration, residues, Riemann surfaces, monodromy, conformal maps, **Julia/Mandelbrot decision boundaries** | Richest math; 113 tests |
| **chaos-rs** (`nonlinear-chaos`) | Lyapunov exponents (map/flow, QR), strange attractors, bifurcation detection, **box-counting/correlation/information fractal dimensions**, Poincaré sections, symbolic dynamics, `mandelbrot_grid` | Measurement toolkit |
| **lau-chaos-theory** / **lau-dynamical-systems** | Same theory, LAU-agent framing (behavioral regimes, agent unpredictability) | Framing |
| **fibonacci-growth** | **"Penrose outward, Mandelbrot inward"** — CR→1/φ attractor from growth topology | ★ Direct puzzle-shape |
| **lau-jepa-gravity** | Single f64 per room → full model params; **MandelbrotZoom** progressive refinement, coarse→fine | ★ Iterative refinement pattern |
| **fleet-midi-fractal** / **fleet-midi-chaos** | Recursive ternary structures → MIDI; attractor-driven music | Application |
| **noise-gen-rs** | Perlin/Simplex/Worley/**fBm** | Scale-hierarchy machinery |
| **spectral-deadband** | "Fractal conservation," deadband as spectral gap | Adjacent |
| **ternary-chaos** / **ternary-dynamics-python** | Chaos on Z₃, bifurcation on ternary lattice | Adjacent |
| **AI-Writings** | `THE-MANDELBROT-ROOM.md` (essay), `the-fractal-seed-chain.md`, `the-42-bridges.md` | Paper corpus |
| **constraint-theory-papers** | `THE-MANDELBROT-FLEET.md`, `THE-GOLDEN-TWIST.md` | Paper corpus |
| **flux-tensor-midi** | `MANDELBROT-PENROSE-SPLINE.md`, `MANDELBROT-RESOLUTION-RESULTS.md` + runnable `mandelbrot_room.py`, `mandelbrot_resolution.py` | ★ Paper corpus + experiments |

**Quaternions (higher-dim Mandelbrot): ZERO repos.** `gh search "quaternion"` → empty. The golden-twist paper *mentions* icosians (quaternions with φ coefficients) as Penrose's symmetry group, but no quaternionic-escape-time implementation exists in the fleet. This is a genuine open lane.

---

## (b) The Mathematical Shape Extracted

The fleet's fractal work is not a pile of demos — it's **one coherent thesis**, stated most cleanly in MANDELBROT-PENROSE-SPLINE and THE GOLDEN-TWIST:

> **Scale is a dimension, not a parameter.** Penrose (spatial quasicrystal), Mandelbrot (escape-time boundary), and B-spline (knot spacing) are three projections of the same object: a 4D double rotation R(α,β) with α/β = φ.

Concrete algorithmic assets:

1. **Escape-time as classification** (`fractal-gen-rs`, `chaos-rs`, `lau-complex-agents`): z₀=0, z→z²+c; return `Some(escape_iter)` or `None`. `mandelbrot_grid((xmin,xmax),(ymin,ymax), w, h, max_iter)` — this **is a cross-sectional heat map**: fix a rectangle in parameter space, iterate, record escape-time per cell. The escape iteration count is the "heat."

2. **Three-zone taxonomy** (THE-MANDELBROT-ROOM, from the actual experiment): points **deep inside** (converge instantly, zero novelty), **far outside** (diverge instantly, pure noise), **near the boundary** (bounded non-periodic orbits — where all discovery happened). Experiment: all 3 paradigm shifts in 1000 iterations came from the boundary room; boundary-proximity↔paradigm-shift correlation **0.72**.

3. **Boundary-proximity as a scalar** — the experiment tracks `boundary proximity` per room and shows it's the predictive variable. This is exactly a "heat" value per cell in an x/y parameter cross-section.

4. **Mandelbrot fraction** — measurable quantity: fraction of cells needing recursive resolution. Fleet tiles: **40%**; resolution experiment: **33%** (5/15), geometric tiles 0%, statistical ~40%, boundary 100%.

5. **Resolution hierarchy** (MANDELBROT-RESOLUTION-RESULTS): 4 zoom levels L0 binary → L1 structural → L2 mechanistic → L3 contextual. Key empirical law: **geometric/algebraic tiles survive all zooms; statistical tiles oscillate; boundary tiles fail everywhere**. And the kicker: *"Confident ≠ Correct"* — at low resolution the model can't tell exact tiles from boundary tiles (Dunning-Kruger boundary). **You need higher-resolution rooms to detect the boundary at all.**

6. **Zoom-in / zoom-out / spline** (THE-MANDELBROT-FLEET): zoom-in never simplifies (Hausdorff dim 2); zoom-out is self-similar consolidation ("baby fleets" at every level — agent/room/domain/fleet all the same shape); the spline operation is *temporal* — agents interpolate toward projected destinations through control points = last-known states, never seeing the full path. Compression data: 74% compression with 0% loss at the right level; past the fractal dimension → "confident hallucination, boundary smooths into fiction."

7. **Penrose inflation/deflation ↔ Mandelbrot inward** (fibonacci-growth): L→LS, S→L substitution produces φ-structure outward; boundary-roughness measurement (→ log φ/log 2, explicitly flagged as *conceptual, not proven*) is the inward counterpart. CR = (Σλᵢ)²/(n·Σλᵢ²) → 1/φ as an **attractor, not a target** — convergence oscillates at rate 1/φ².

8. **Penrose-style projection as bandwidth** (SPLINE paper): cut-and-project from ℤ⁵ → 2D at irrational angle; **strip width = working memory bandwidth**. Echo-stage = narrow strip (only input lattice points visible) → partial = sub-expressions visible → full = whole lattice. Scale of agent = which lattice points project.

9. **Fractal dimension measurement** (chaos-rs): box-counting, Grassberger-Procaccia correlation, information dimension, Kaplan-Yorke — off-the-shelf tools for quantifying any cross-section's roughness.

10. **lau-jepa-gravity MandelbrotZoom**: one f64 expands deterministically into a full parameter set; progressive generation refines coarse→fine. The "trivial input, rich expansion function" pattern.

---

## (c) Papers — Key Claims

| Paper | Location | Claim |
|-------|----------|-------|
| **The Mandelbrot Room** (2026-05-16) | AI-Writings | Creative rooms = orbits of z→z²+c with c=(courage,boredom). Boundary rooms (proximity 0.75) produced 100% of paradigm shifts, r=0.72. Boundary has dim 2 → creative zone has unlimited capacity; mini-Mandelbrots → frontiers never exhaust. |
| **Mandelbrot-Penrose-Spline: Scale as a Dimension** (2026-05-14) | flux-tensor-midi | Mandelbrot/Penrose/B-spline unified: scale-as-axis in all three. Mandelbrot boundary = computational residue (entered-but-didn't-finish). Eisenstein snap IS a cut-and-project; strip width = bandwidth; phase transitions at 4B/7B = boundary sprouting filaments. B-spline shallow-side constraint: interpolate between verified points, never extrapolate. |
| **The Mandelbrot Fleet** (2026-05-12) | constraint-theory-papers / flux-tensor-midi | Three simultaneous ops = one system at different temporal resolutions: zoom in (boundary never simplifies; amnesia cliff at 10% = can't compress below fractal dimension), zoom out (self-similar consolidation; dream module IS zoom-out, DreamStyles = different projections of the same fractal), spline toward destination (async interpolation through control points = fleet coordination). |
| **The Golden Twist** (2026-05-12) | constraint-theory-papers | One 4D double rotation R(α,β), α/β=φ, projects to all four structures (Penrose, Eisenstein, Mandelbrot boundary, temporal spline). α=2π/φ, β=golden angle 137.51°. Quasiperiodic, self-similar under zoom-by-φ. Icosians (φ-quaternions, 120 elements) = the symmetry group. |
| **Mandelbrot Resolution Results** (2026-05-15, experiment) | flux-tensor-midi | Empirical: geometric tiles 100% zoom-survival, statistical oscillate, boundary 0%. 33% effective boundary fraction. Confident≠correct at low res — boundary detection *requires* higher resolution. |
| **The Fractal Seed Chain** | AI-Writings deep-past | (Title hit; not fully read — flagged below.) |

---

## (d) Three Concrete Ways This Shapes Our Geometry Layer

**1. Cross-sectional heat mapping = escape-time grid, with boundary-proximity as the scalar.**
Our "changeable x/y cross-sectional heat map" already has a fleet-proven form: `mandelbrot_grid((xmin,xmax),(ymin,ymax),w,h,max_iter)` from **chaos-rs** returns per-cell escape iterations — that's the heat value. The Mandelbrot Room experiment (*flux-tensor-midi/mandelbrot_room.py* + THE-MANDELBROT-ROOM) adds the crucial refinement: the *useful* heat isn't binary in/out, it's **distance from the boundary** — cells near the boundary are where the interesting structure lives (r=0.72 with discovery). So: render two quantities per cross-section — escape-time (coarse heat) and boundary-proximity (fine heat) — and let the user sweep x/y like a Julia parameter c. Origin-centric note: z₀=0 iteration means **every orbit starts at the origin** — the map is already origin-centric; our origin-centric cell thinking should exploit that (the origin's orbit is the reference trajectory; cells are parameter-space, origin is state-space).

**2. Scale hierarchy = the resolution ladder, with a per-cell "Mandelbrot fraction" deciding when to recurse.**
From **lau-jepa-gravity** (MandelbrotZoom coarse→fine) + the **resolution experiment** (L0–L3 ladder): implement iterative refinement as a 4-level zoom per cell, but classify first — the experiment proves geometric/exact cells survive all zooms (don't waste refinement), statistical cells oscillate (refine with oscillation detection), boundary cells need *new rooms* not more zoom. The actionable invariant: compute the Mandelbrot fraction of a region *before* committing compute; **33–40% is the fleet's empirically observed boundary fraction** — budget recursion accordingly. And respect the compression law: past the fractal dimension, refinement produces confident fiction, not detail (the 200×-zoom → 0% accuracy row).

**3. Higher-dim embedding = the golden twist, not quaternions-from-scratch.**
No quaternionic Mandelbrot exists in the fleet (thin spot — don't reinvent it blind). What exists is better for our purposes: THE GOLDEN TWIST's 4D double rotation R(α,β) with α/β=φ, whose 2D slices are Penrose / Eisenstein / Mandelbrot / spline — and fibonacci-growth's paired directions (Penrose inflation outward = growth; boundary-roughness inward = refinement). For our geometry layer: treat the higher-dim embedding as a **4D rotation with golden-ratio plane angles**; x/y cross-sections are then literally 2D projections of one structure, so *changing the cross-section = changing the projection angle*, and self-similarity under zoom-by-φ comes for free. Penrose deflation ↔ our cell subdivision: recursion outward/inward are the same operation at opposite signs of the scale axis.

---

## Thin Spots (honest)

- **No quaternion/higher-dim Mandelbrot implementation anywhere in the fleet.** The 4D story is a *paper* claim (golden twist), with zero code behind R(α,β) itself. If we want quaternionic escape-time it's greenfield.
- **fibonacci-growth's "Mandelbrot roughness" is explicitly conceptual** — the README says the log(φ)/log 2 boundary-dimension link "is a research direction, not a proven theorem," and much of the described API is *intended*, not built. Don't cite it as established.
- **THE-MANDELBROT-FLEET / GOLDEN-TWIST papers 404 on `main` of constraint-theory-papers** (read via flux-tensor-midi copies / master branch) — canonical copies are sharded across repos.
- `the-fractal-seed-chain.md` and `the-42-bridges.md` (AI-Writings) surfaced in search but were not read — possible additional depth there.
- Mandelbrot Room experiment: n=1 room per zone, 3 paradigm shifts total — the r=0.72 is suggestive, not statistically hard.
- **fractal-gen-rs README is a stub** (quick-start only, no API docs); the real implementations live in chaos-rs and lau-complex-agents.
- MerkleMesh / SmartCRDT skim: searched, no fractal/recursive-geometry overlap found beyond generic recursion; batten-spline is *spline*-adjacent (verified anchors + fog-of-war interpolation — conceptually the shallow-side constraint made operational) but contains no fractal math. base60-lattice contributes the time-axis lattice (sexagesimal bucketing), not fractal structure.

---

*Scout B out. The shape of the puzzle: one 4D golden rotation, three 2D shadows, and a boundary fraction of a third.*
