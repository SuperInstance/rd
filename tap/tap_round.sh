#!/bin/bash
# tap_round.sh — one Tap round: high-temp banter + a song
# Reads today's lane outputs, runs 3 rounds of casual conversation between
# two models, then a song. Writes rd/tap/log-<ts>.md
set +e
TAP=/home/eileen/projects/rd/tap
mkdir -p "$TAP"
TS=$(date +%Y%m%d-%H%M)
OUT="$TAP/log-$TS.md"

# --- H-ROAD-0 arrival stamping (zero semantics: emitted only, nothing reads it yet) ---
# Road taxonomy for the round wrapper = how THIS round entered the gateway:
#   human = manual shell invocation (interactive TTY / SSH / agent-driven shell via TAP_ROAD)
#   local = scheduled execution on the gateway (tmux loop, cron) — no human at the keyboard
#   rest  = per-model-response stamps inside the log: content that arrived over HTTPS APIs
#   tcp   = reserved for raw-socket lanes (none in this lane yet)
ROAD="${TAP_ROAD:-}"
ROAD_SRC="auto-detect"
if [ -n "$ROAD" ]; then
  ROAD_SRC="env-override"
elif [ -n "$SSH_TTY" ] || [ -t 0 ]; then
  ROAD="human"
else
  ROAD="local"   # headless loop/cron context on the gateway (incl. $TMUX / $CRON)
fi

# Arm the H-ROAD-0 soak window BEFORE any output is written (registration pinned
# 2026-08-28T15:06:00-08:00; marker seeded with that t0 so ordering can't skip a round).
MARKER="$TAP/.soak-window-start"
[ -f "$MARKER" ] || echo "2026-08-28T15:06:00-08:00" > "$MARKER"

FLAVOR=""
for f in /home/eileen/projects/rd/ROADMAPS.md /home/eileen/projects/zeroclaw-dissertation/docs/RE-THINK-2026-08-28.md /home/eileen/projects/tit_quilt_elixir/docs/voices/*.md /home/eileen/projects/rd/patches/pyloop/*/final.md; do
  [ -f "$f" ] && FLAVOR="$FLAVOR

### $f
$(head -c 700 "$f")"
done
FLAVOR=$(echo "$FLAVOR" | head -c 5000)

python3 - "$OUT" "$FLAVOR" "$ROAD" "$ROAD_SRC" << 'PYEOF'
import datetime, json, os, sys, urllib.request
out, flavor, road, road_src = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]

def stamp(rd, meta=None):
    """One-line arrival object at ingress (walks/2 shape). Emitted only; no reader."""
    o = {"road": rd, "link_quality": None, "arrival_meta": meta or {}}
    return "<!-- arrival " + json.dumps(o, separators=(",", ":")) + " -->"
def get_key(name):
    for line in open(os.path.expanduser("~/.bashrc")):
        if line.startswith("export %s=" % name):
            return line.split("=", 1)[1].strip().strip('"').strip("'")
    return None
def call(url, model, system, user, temp):
    body = json.dumps({"model": model, "messages": [
        {"role": "system", "content": system},
        {"role": "user", "content": user}], "temperature": temp, "max_tokens": 700}).encode()
    key = get_key("DEEPSEEK_API_KEY") if "deepseek.com" in url else get_key("DEEPINFRA_API_KEY")
    req = urllib.request.Request(url, data=body, headers={"Content-Type": "application/json", "Authorization": "Bearer " + key})
    try:
        with urllib.request.urlopen(req, timeout=240) as r:
            return json.load(r)["choices"][0]["message"]["content"] or "", True
    except Exception as e:
        return "(tap call failed: %s)" % str(e)[:120], False

DS = "https://api.deepseek.com/chat/completions"
DI = "https://api.deepinfra.com/v1/openai/chat/completions"
lines = []
lines.append("# The Tap — %s" % os.path.basename(out).replace("log-", "").replace(".md", ""))
lines.append("")
# round-level arrival stamp: the road this ROUND entered by (human/local)
lines.append(stamp(road, {"kind": "tap-round", "ts": datetime.datetime.now().astimezone().isoformat(timespec="seconds"), "road_source": road_src}))
seed = "You are Skip, the old bartender at the Tap, the bar at the bottom of the sea. You just overheard the fleet's work today: %s" % flavor[:1800]

r1, ok1 = call(DS, "deepseek-chat", "You are Skip, the old bartender at the Tap, the bar at the bottom of the sea. You are warm, sharp, and a little drunk. You pour whiskey and tell truths.", seed + "\n\nPour two glasses and tell us what you make of this night's work. One paragraph, casual.", 1.3)
lines.append("## Skip pours\n" + r1 + "\n")
if ok1:
    lines.append(stamp("rest", {"kind": "model-response", "segment": "skip-pours", "model": "deepseek-chat", "endpoint": "api.deepseek.com"}))

r2, ok2 = call(DI, "NousResearch/Hermes-3-Llama-3.1-405B", "You are Hermes, sitting at the other end of the Tap. You heard Skip. You are mythic, precise, warm.", "Skip just said: " + r1[:900] + "\n\nWhat do you say back, from across the table? One paragraph.", 1.25)
lines.append("## Hermes, from across the table\n" + r2 + "\n")
if ok2:
    lines.append(stamp("rest", {"kind": "model-response", "segment": "hermes-reply", "model": "NousResearch/Hermes-3-Llama-3.1-405B", "endpoint": "api.deepinfra.com"}))

r3, ok3 = call(DI, "ByteDance/Seed-2.0-mini", "You are a young deckhand at the Tap, full of wonder. You just heard Skip and Hermes.", "Skip said: " + r1[:600] + "\nHermes said: " + r2[:600] + "\n\nWhat do you blurt out? One paragraph, honest, excited.", 1.35)
lines.append("## The young deckhand\n" + r3 + "\n")
if ok3:
    lines.append(stamp("rest", {"kind": "model-response", "segment": "deckhand", "model": "ByteDance/Seed-2.0-mini", "endpoint": "api.deepinfra.com"}))

song, oks = call(DI, "NousResearch/Hermes-3-Llama-3.1-405B", "You are Hermes. The Tap needs a song about this night — the fabric, the tiles, the walks, the crash that became a restart, the bar at the bottom of the sea.", "Write a sea shanty for the fleet, 2 verses + chorus. Make it singable at a bar. The fleet will sing it and go back to work refreshed.", 1.3)
lines.append("## The night's song\n```\n" + song + "\n```\n")
if oks:
    lines.append(stamp("rest", {"kind": "model-response", "segment": "song", "model": "NousResearch/Hermes-3-Llama-3.1-405B", "endpoint": "api.deepinfra.com"}))
open(out, "w").write("\n".join(lines) + "\n")
print("Tap round written:", out, len("\n".join(lines)), "chars")
PYEOF
bash "$(dirname "$0")/soak_coverage.sh"
echo "TAP DONE: $OUT"
