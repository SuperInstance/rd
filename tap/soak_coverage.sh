#!/bin/bash
# soak_coverage.sh — H-ROAD-0 (Rung 1) coverage counter. Research-adjacent measurement ONLY.
# After each tap round: count arrival-stamped vs total entries in logs written inside the
# soak window, append one line (date, total, stamped, pct) to rd/soak-coverage.log.
#
# Honesty rules (per research/registrations/hroad0-coverage.md):
#   - Window = logs written after the .soak-window-start marker (first run arms it).
#     Pre-registration logs are "unknown", NOT counted as uncovered — excluded entirely.
#   - Entry units: 1 round wrapper (`# The Tap` header) + each model-response section
#     (`## ` header). Stamps: `<!-- arrival {...} -->` lines. A section whose API call
#     failed carries no stamp and honestly counts as unstamped (nothing arrived).
#   - Zero semantics: nothing downstream reads the arrival fields; this script only counts.
RD=/home/eileen/projects/rd
TAP=$RD/tap
MARKER="$TAP/.soak-window-start"
LOG="$RD/soak-coverage.log"

[ -f "$MARKER" ] || echo "2026-08-28T15:06:00-08:00" > "$MARKER"   # fallback; tap_round.sh arms at round start. t0 = H-ROAD-0 registration commit.

WIN=$(cat "$MARKER")
WIN_FMT=$(date -d "$WIN" +%Y%m%d-%H%M 2>/dev/null || echo 19700101-0000)
total=0
stamped=0
for f in "$TAP"/log-*.md; do
  [ -f "$f" ] || continue
  base=$(basename "$f" .md); base=${base#log-}
  # in-window only (round-start ts from filename vs window t0);
  # pre-registration logs are "unknown", NOT counted as uncovered — excluded entirely
  [ "$base" \> "$WIN_FMT" ] || continue
  secs=$(grep -c '^## ' "$f" || true)
  rounds=$(grep -c '^# The Tap' "$f" || true)
  total=$((total + secs + rounds))
  st=$(grep -c '<!-- arrival ' "$f" || true)
  stamped=$((stamped + st))
done

pct=0
[ "$total" -gt 0 ] && pct=$(awk "BEGIN{printf \"%.1f\", 100*$stamped/$total}")
echo "$(date -Is) window_start=$(cat "$MARKER") total=$total stamped=$stamped pct=$pct" >> "$LOG"
tail -1 "$LOG"
