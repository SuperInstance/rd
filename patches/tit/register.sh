#!/bin/bash
# register.sh — the standing registrar: binds R&D lane deliverables into the
# `rd` TIT session (session-as-graph) with sha receipts. Idempotent; re-bind
# bumps versions. The graph is the arm's provenance view.
# Run on a loop in tmux rd-tit (10 min) and manually after big landings.
set +e
T=("tit" "--session" "rd")

bind() { # bind <cell> <value>
  "${T[@]}" bind "$1" "$2" >/dev/null 2>&1
}

# --- keel artifacts ---
R=/home/eileen/projects/zeroclaw-dissertation
bind artifact.rethink.path "$R/docs/RE-THINK-2026-08-28.md"
[ -f "$R/docs/RE-THINK-2026-08-28.md" ] && bind artifact.rethink.sha "$(sha256sum "$R/docs/RE-THINK-2026-08-28.md" | cut -d' ' -f1)"
bind artifact.status.path "$R/research/STATUS-2026-08-28.md"
[ -f "$R/research/STATUS-2026-08-28.md" ] && bind artifact.status.sha "$(sha256sum "$R/research/STATUS-2026-08-28.md" | cut -d' ' -f1)"

# --- fabric ---
F=/home/eileen/projects/tit_quilt_elixir
bind artifact.fabric.context.path "$F/CONTEXT.md"
[ -f "$F/CONTEXT.md" ] && bind artifact.fabric.sha "$(sha256sum "$F/CONTEXT.md" | cut -d' ' -f1)"

# --- walks bridge (when it lands) ---
W="$R/research/walks-bridge"
if [ -f "$W/EXPORTER.md" ]; then
  bind artifact.walks.exporter.path "$W/EXPORTER.md"
  bind artifact.walks.exporter.sha "$(sha256sum "$W/EXPORTER.md" | cut -d' ' -f1)"
fi
if [ -f "$W/exporter.py" ]; then
  bind artifact.walks.py.path "$W/exporter.py"
  bind artifact.walks.py.sha "$(sha256sum "$W/exporter.py" | cut -d' ' -f1)"
fi

# --- S2 freeze prep (when it lands) ---
for f in S2-FREEZE-PREP PROMPT-PACK-S2 SILENCE-TEST; do
  if [ -f "$R/research/$f.md" ]; then
    bind "artifact.s2.$(echo "$f" | tr 'A-Z' 'a-z').path" "$R/research/$f.md"
    bind "artifact.s2.$(echo "$f" | tr 'A-Z' 'a-z').sha" "$(sha256sum "$R/research/$f.md" | cut -d' ' -f1)"
  fi
done

# --- geometry library (when it lands) ---
G=/home/eileen/projects/quilt-geometry
if [ -f "$G/README.md" ]; then
  bind artifact.geometry.readme.path "$G/README.md"
  bind artifact.geometry.readme.sha "$(sha256sum "$G/README.md" | cut -d' ' -f1)"
fi

# --- knowledge universe (when it lands) ---
K=/home/eileen/projects/zeroclaw-knowledge
if [ -f "$K/query.py" ]; then
  bind artifact.knowledge.query.path "$K/query.py"
  bind artifact.knowledge.query.sha "$(sha256sum "$K/query.py" | cut -d' ' -f1)"
fi

# --- pyloop latest final ---
LATEST_FINAL=$(ls -t /home/eileen/projects/rd/patches/pyloop/*/final.md 2>/dev/null | head -1)
if [ -n "$LATEST_FINAL" ]; then
  bind artifact.pyloop.final.path "$LATEST_FINAL"
  bind artifact.pyloop.final.sha "$(sha256sum "$LATEST_FINAL" | cut -d' ' -f1)"
fi

# --- tap latest round ---
LATEST_TAP=$(ls -t /home/eileen/projects/rd/tap/log-*.md 2>/dev/null | head -1)
if [ -n "$LATEST_TAP" ]; then
  bind artifact.tap.latest.path "$LATEST_TAP"
  bind artifact.tap.latest.sha "$(sha256sum "$LATEST_TAP" | cut -d' ' -f1)"
fi

# --- fleet status line ---
bind fleet.status "$(date -u +%Y-%m-%dT%H:%MZ) R&D arm: opencode(claude)kimi pyloop tap vectorize penrose lanes"

"${T[@]}" tick >/dev/null 2>&1
CELLS=$("${T[@]}" graph 2>/dev/null | grep -c '"id"')
echo "registrar pass done $(date +%H:%M) — cells: $CELLS"
