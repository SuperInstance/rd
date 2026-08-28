# iterate.py — rival/cooperative iteration loop (ZeroClaw-style)

Runs a competition between two models: each round, each model hears the
previous response and builds on/critiques it (iterative banter). A third
voice interjects from across the table at high temperature every 2 rounds.
Final round produces the recommendation. Everything is logged verbatim.

Usage: python3 iterate.py <round-name> <target-description>
Env: reads DEEPSEEK_API_KEY + DEEPINFRA_API_KEY from ~/.bashrc itself.
"""

import json, os, sys, time, urllib.request

ROUND_NAME = sys.argv[1] if len(sys.argv) > 1 else "round1"
TARGET = sys.argv[2] if len(sys.argv) > 2 else "walks-export JSONL schema"

OUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), ROUND_NAME)
os.makedirs(OUT_DIR, exist_ok=True)

def get_key(name):
    for line in open(os.path.expanduser("~/.bashrc")):
        if line.startswith("export %s=" % name):
            return line.split("=", 1)[1].strip().strip('"').strip("'")
    return None

DS_KEY = get_key("DEEPSEEK_API_KEY")
DI_KEY = get_key("DEEPINFRA_API_KEY")

DS = "https://api.deepseek.com/chat/completions"
DI = "https://api.deepinfra.com/v1/openai/chat/completions"

def call(url, model, system, user, temp=0.8, max_tokens=1800):
    body = json.dumps({"model": model,
                       "messages": [{"role": "system", "content": system},
                                    {"role": "user", "content": user}],
                       "temperature": temp, "max_tokens": max_tokens}).encode()
    key = DS_KEY if "deepseek.com" in url else DI_KEY
    req = urllib.request.Request(url, data=body, headers={
        "Content-Type": "application/json", "Authorization": "Bearer " + key})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=240) as r:
                data = json.load(r)
            content = data["choices"][0]["message"]["content"] or ""
            if content.strip():
                return content
        except Exception as e:
            print("  (retry %d after %s)" % (attempt + 1, str(e)[:100]), flush=True)
            time.sleep(5)
    return "(empty response)"

def log(msg):
    print(msg, flush=True)
    with open(os.path.join(OUT_DIR, "round.log"), "a") as f:
        f.write(msg + "\n")

# ---- the models -------------------------------------------------------
FLASH = (DS, "deepseek-chat", "DeepSeek-Flash")     # the engine
SEEDP = (DI, "ByteDance/Seed-2.0-pro", "Seed-2.0-pro")  # the planner
HERMES = (DI, "NousResearch/Hermes-3-Llama-3.1-405B", "Hermes")  # across the table

WORK_SYS = ("You are a competitor in an iron-sharpens-iron loop on the ZeroClaw "
            "dissertation team. Target: %s. Be rigorous, concrete, and brief. "
            "You HEAR the previous competitor's proposal and you must respond "
            "to it directly: attack what is wrong, keep what is right, and "
            "advance the idea. No politeness padding; the idea matters more "
            "than the author." % TARGET)
BAR_SYS = ("You are sitting at the Tap, the bar at the bottom of the sea, "
           "listening to two colleagues argue across the table about %s. "
           "You are warm, a little drunk, and sharp. Comment on how their "
           "ideas SOUND from across the table — the shape of what they are "
           "building, not just its content. Casual, specific, one paragraph." % TARGET)

N_ROUNDS = int(os.environ.get("N_ROUNDS", "5"))
log("=== %s: %s ===" % (ROUND_NAME, TARGET))
log("models: %s (rival A) vs %s (rival B), %s across the table" % (FLASH[2], SEEDP[2], HERMES[2]))

a_proposal = ("Open the competition: state your best initial design for: %s. "
              "Keep it under 300 words." % TARGET)
b_proposal = a_proposal

for i in range(1, N_ROUNDS + 1):
    log("\n--- round %d ---" % i)
    a_proposal = call(*FLASH[:2], WORK_SYS,
                      "Previous proposal:\n%s\n\nRound %d: your turn. Attack what is wrong, keep what is right, advance it."
                      % (b_proposal, i), temp=0.75)
    log("[%s R%d]\n%s" % (FLASH[2], i, a_proposal[:2200]))
    b_proposal = call(*SEEDP[:2], WORK_SYS,
                      "Previous proposal:\n%s\n\nRound %d: your turn. Attack what is wrong, keep what is right, advance it."
                      % (a_proposal, i), temp=0.85)
    log("[%s R%d]\n%s" % (SEEDP[2], i, b_proposal[:2200]))
    if i % 2 == 0 or i == N_ROUNDS:
        interjection = call(*HERMES[:2], BAR_SYS,
                            "The two proposals so far:\nA:\n%s\nB:\n%s\n\nWhat does this sound like from across the table?"
                            % (a_proposal[:1200], b_proposal[:1200]), temp=1.25, max_tokens=500)
        log("[HERMES across the table R%d]\n%s" % (i, interjection[:900]))

log("\n=== FINAL — %s ===" % ROUND_NAME)
final = call(*SEEDP[:2], WORK_SYS,
             "This is the last round. Produce THE recommendation for: %s. "
             "Synthesize the best of both proposals into one concrete artifact "
             "(schema, design, or spec). Verbatim, ready to use." % TARGET,
             temp=0.4)
log("[FINAL]\n%s" % final)
with open(os.path.join(OUT_DIR, "final.md"), "w") as f:
    f.write("# %s — final recommendation\n\n%s\n" % (ROUND_NAME, final))
print("\nDONE — final at %s/final.md" % OUT_DIR)
