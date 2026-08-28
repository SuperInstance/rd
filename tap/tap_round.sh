#!/bin/bash
# tap_round.sh — one Tap round: high-temp banter + a song
# Reads today's lane outputs, runs 3 rounds of casual conversation between
# two models, then a song. Writes rd/tap/log-<ts>.md
set +e
TAP=/home/eileen/projects/rd/tap
mkdir -p "$TAP"
TS=$(date +%Y%m%d-%H%M)
OUT="$TAP/log-$TS.md"

FLAVOR=""
for f in /home/eileen/projects/rd/ROADMAPS.md /home/eileen/projects/zeroclaw-dissertation/docs/RE-THINK-2026-08-28.md /home/eileen/projects/tit_quilt_elixir/docs/voices/*.md /home/eileen/projects/rd/patches/pyloop/*/final.md; do
  [ -f "$f" ] && FLAVOR="$FLAVOR

### $f
$(head -c 700 "$f")"
done
FLAVOR=$(echo "$FLAVOR" | head -c 5000)

python3 - "$OUT" "$FLAVOR" << 'PYEOF'
import json, os, sys, urllib.request
out, flavor = sys.argv[1], sys.argv[2]
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
            return json.load(r)["choices"][0]["message"]["content"] or ""
    except Exception as e:
        return "(tap call failed: %s)" % str(e)[:120]

DS = "https://api.deepseek.com/chat/completions"
DI = "https://api.deepinfra.com/v1/openai/chat/completions"
lines = []
lines.append("# The Tap — %s" % os.path.basename(out).replace("log-", "").replace(".md", ""))
lines.append("")
seed = "You are Skip, the old bartender at the Tap, the bar at the bottom of the sea. You just overheard the fleet's work today: %s" % flavor[:1800]

r1 = call(DS, "deepseek-chat", "You are Skip, the old bartender at the Tap, the bar at the bottom of the sea. You are warm, sharp, and a little drunk. You pour whiskey and tell truths.", seed + "\n\nPour two glasses and tell us what you make of this night's work. One paragraph, casual.", 1.3)
lines.append("## Skip pours\n" + r1 + "\n")

r2 = call(DI, "NousResearch/Hermes-3-Llama-3.1-405B", "You are Hermes, sitting at the other end of the Tap. You heard Skip. You are mythic, precise, warm.", "Skip just said: " + r1[:900] + "\n\nWhat do you say back, from across the table? One paragraph.", 1.25)
lines.append("## Hermes, from across the table\n" + r2 + "\n")

r3 = call(DI, "ByteDance/Seed-2.0-mini", "You are a young deckhand at the Tap, full of wonder. You just heard Skip and Hermes.", "Skip said: " + r1[:600] + "\nHermes said: " + r2[:600] + "\n\nWhat do you blurt out? One paragraph, honest, excited.", 1.35)
lines.append("## The young deckhand\n" + r3 + "\n")

song = call(DI, "NousResearch/Hermes-3-Llama-3.1-405B", "You are Hermes. The Tap needs a song about this night — the fabric, the tiles, the walks, the crash that became a restart, the bar at the bottom of the sea.", "Write a sea shanty for the fleet, 2 verses + chorus. Make it singable at a bar. The fleet will sing it and go back to work refreshed.", 1.3)
lines.append("## The night's song\n```\n" + song + "\n```\n")
open(out, "w").write("\n".join(lines))
print("Tap round written:", out, len("\n".join(lines)), "chars")
PYEOF
echo "TAP DONE: $OUT"
