**User:**

<command-name>/model</command-name>
            <command-message>model</command-message>
            <command-args></command-args>

**User:**

<local-command-stdout>Set model to [1mSonnet 4.6[22m and saved as your default for new sessions</local-command-stdout>

**User:**

<command-name>/effort</command-name>
            <command-message>effort</command-message>
            <command-args></command-args>

**User:**

<local-command-stdout>Set effort level to low (saved as your default for new sessions): Quick, straightforward implementation with minimal overhead</local-command-stdout>

**User:**

<command-message>gm</command-message>
<command-name>/gm</command-name>
<command-args>run a cannonball-rally with 6 players, 1 per vehicle. All players played by me. script dice, weather mcp for real weather. seed=sonnet1</command-args>

Reading the session procedure and game rules now.

_(Read)_ `{"file_path": "/mnt/v/users/Austin/Documents/git/lite-rpg/.claude/skills/gm/references/session-procedure.md"}`

```
1	# Session Procedure
2	
3	The full GM procedure for refereeing one session of any conforming game. The game's `references/GAME.md` is the law; this document is how the referee applies it: setup, turn briefs, the round loop, hook resolution, dice discipline, and conduct. The transcript journal it feeds is specified in `journal-format.md`.
4	
5	Two rules frame everything below:
6	
7	- **The conversation is the working memory.** Canonical state is the latest restated state table in chat — not a file, not the GM's recollection. Everything here works with no filesystem at all.
8	- **The paper is the law.** A conforming `GAME.md` (per the format spec at `skills/author/references/game-format.md`) answers every mechanics question. If it doesn't, the paper is incomplete — flag it, don't patch it from the GM's chair.
... (86 more lines truncated)
```

_(Read)_ `{"file_path": "/mnt/v/users/Austin/Documents/git/lite-rpg/.claude/skills/cannonball-rally/references/GAME.md"}`

```
1	# Cannonball Rally
2	
3	**Players:** 2–6
4	**Time:** about an hour
5	**Randomizer:** one d6 (a single shared die is fine)
6	**Materials:** pencil and paper for the scoreboard
7	
8	An illegal coast-to-coast street race from New York City to Redondo Beach. Pick your machine — ambulance, motorcycle, supercar, or beige sedan — and burn across six stages of traffic, weather, and the long arm of the law. Lowest total hours wins; jail means you never finish at all.
... (288 more lines truncated)
```

Now checking the roller and journal format, and fetching weather for all 6 stages.

```sh
ls /mnt/v/users/Austin/Documents/git/lite-rpg/scripts/roll.sh && cat /mnt/v/users/Austin/Documents/git/lite-rpg/scripts/roll.sh
```

_(Read)_ `{"file_path": "/mnt/v/users/Austin/Documents/git/lite-rpg/.claude/skills/gm/references/journal-format.md"}`

```
1	# Transcript Journal Format
2	
3	The session transcript contract: what the GM writes where disk exists, and what later consumers — a resuming GM, a human auditing a dispute, and batch-playtest extraction — may rely on. The journal is a **tee of the conversation**, not a second bookkeeping system: every machine-critical record in it reuses a grammar the GM already emits in chat (the game's Turn Report lines, `roll.sh`'s log lines, GFM state tables). One transcript, two audiences.
4	
5	## When a Journal Exists
6	
7	The journal is strictly opportunistic:
8	
... (105 more lines truncated)
```

_(ToolSearch)_ `{"query": "select:mcp__weather__get_forecast,mcp__weather__search_location"}`

```
Exit code 2
ls: cannot access '/mnt/v/users/Austin/Documents/git/lite-rpg/scripts/roll.sh': No such file or directory
```

```sh
find /mnt/v/users/Austin/Documents/git/lite-rpg -name "roll.sh" 2>/dev/null
```

_(mcp__weather__search_location)_ `{"query": "New York City", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Pittsburgh PA", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Springfield IL", "limit": 1}`

```
/mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh
```

_(mcp__weather__search_location)_ `{"query": "Tulsa OK", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Denver CO", "limit": 1}`

```
# Location Search Results

**Query:** "New York City"
**Found:** 1 location

---

## 1. New York
... (14 more lines truncated)
```

```
OpenMeteo API Error: No locations found matching "Pittsburgh PA". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

_(mcp__weather__search_location)_ `{"query": "Flagstaff AZ", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Redondo Beach CA", "limit": 1}`

```
OpenMeteo API Error: No locations found matching "Springfield IL". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

```
OpenMeteo API Error: No locations found matching "Tulsa OK". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

```
OpenMeteo API Error: No locations found matching "Denver CO". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

```
OpenMeteo API Error: No locations found matching "Flagstaff AZ". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

```
OpenMeteo API Error: No locations found matching "Redondo Beach CA". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

_(mcp__weather__search_location)_ `{"query": "Pittsburgh", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Springfield Illinois", "limit": 1}`

```
# Location Search Results

**Query:** "Pittsburgh"
**Found:** 1 location

---

## 1. Pittsburgh
... (14 more lines truncated)
```

```
OpenMeteo API Error: No locations found matching "Springfield Illinois". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

_(mcp__weather__search_location)_ `{"query": "Tulsa Oklahoma", "limit": 1}`

```
OpenMeteo API Error: No locations found matching "Tulsa Oklahoma". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

_(mcp__weather__search_location)_ `{"query": "Denver Colorado", "limit": 1}`

```
OpenMeteo API Error: No locations found matching "Denver Colorado". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

_(mcp__weather__search_location)_ `{"query": "Flagstaff Arizona", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Redondo Beach California", "limit": 1}`

```
OpenMeteo API Error: No locations found matching "Flagstaff Arizona". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

```
OpenMeteo API Error: No locations found matching "Redondo Beach California". Try:
- Using a different spelling
- Being more specific (e.g., "Paris, France" instead of "Paris")
- Using a nearby city or landmark
```

_(mcp__weather__search_location)_ `{"query": "Springfield", "limit": 3}`

_(mcp__weather__search_location)_ `{"query": "Tulsa", "limit": 1}`

```
# Location Search Results

**Query:** "Springfield"
**Found:** 3 locations

---

## 1. Springfield
... (44 more lines truncated)
```

```
# Location Search Results

**Query:** "Tulsa"
**Found:** 1 location

---

## 1. Tulsa
... (14 more lines truncated)
```

_(mcp__weather__search_location)_ `{"query": "Denver", "limit": 1}`

```
# Location Search Results

**Query:** "Denver"
**Found:** 1 location

---

## 1. Denver
... (14 more lines truncated)
```

_(mcp__weather__search_location)_ `{"query": "Flagstaff", "limit": 1}`

_(mcp__weather__search_location)_ `{"query": "Redondo Beach", "limit": 1}`

```
# Location Search Results

**Query:** "Flagstaff"
**Found:** 1 location

---

## 1. Flagstaff
... (14 more lines truncated)
```

```
# Location Search Results

**Query:** "Redondo Beach"
**Found:** 1 location

---

## 1. Redondo Beach
... (14 more lines truncated)
```

Got all coordinates. Now fetching 2-day hourly forecasts for all 7 stage cities in parallel.

_(mcp__weather__get_forecast)_ `{"latitude": 40.7143, "longitude": -74.006, "days": 2, "granularity": "hourly"}`

```
# Weather Forecast (Hourly)

**Location:** 40.7143, -74.0060
**Elevation:** 2.1336m
**Showing:** 48 hours

## 6/15/2026, 2:00 PM
**Temperature:** 75°F
... (336 more lines truncated)
```

_(mcp__weather__get_forecast)_ `{"latitude": 40.4406, "longitude": -79.9959, "days": 2, "granularity": "hourly"}`

```
# Weather Forecast (Hourly)

**Location:** 40.4406, -79.9959
**Elevation:** 248.1072m
**Showing:** 48 hours

## 6/15/2026, 2:00 PM
**Temperature:** 69°F
... (336 more lines truncated)
```

_(mcp__weather__get_forecast)_ `{"latitude": 39.8017, "longitude": -89.6437, "days": 2, "granularity": "hourly"}`

```
# Weather Forecast (Hourly)

**Location:** 39.8017, -89.6437
**Elevation:** 182.88m
**Showing:** 48 hours

## 6/15/2026, 1:00 PM
**Temperature:** 74°F
... (336 more lines truncated)
```

_(mcp__weather__get_forecast)_ `{"latitude": 36.154, "longitude": -95.9928, "days": 2, "granularity": "hourly"}`

```
# Weather Forecast (Hourly)

**Location:** 36.1540, -95.9928
**Elevation:** 234.0864m
**Showing:** 48 hours

## 6/15/2026, 1:00 PM
**Temperature:** 77°F
... (336 more lines truncated)
```

_(mcp__weather__get_forecast)_ `{"latitude": 39.7392, "longitude": -104.9847, "days": 2, "granularity": "hourly"}`

```
# Weather Forecast (Hourly)

**Location:** 39.7392, -104.9847
**Elevation:** 1608.1248m
**Showing:** 48 hours

## 6/15/2026, 12:00 PM
**Temperature:** 72°F
... (336 more lines truncated)
```

_(mcp__weather__get_forecast)_ `{"latitude": 35.1981, "longitude": -111.6513, "days": 2, "granularity": "hourly"}`

_(mcp__weather__get_forecast)_ `{"latitude": 33.8492, "longitude": -118.3884, "days": 2, "granularity": "hourly"}`

```
# Weather Forecast (Hourly)

**Location:** 35.1981, -111.6513
**Elevation:** 2129.9424m
**Showing:** 48 hours

## 6/15/2026, 11:00 AM
**Temperature:** 83°F
... (336 more lines truncated)
```

```
# Weather Forecast (Hourly)

**Location:** 33.8492, -118.3884
**Elevation:** 0m
**Showing:** 48 hours

## 6/15/2026, 11:00 AM
**Temperature:** 70°F
... (336 more lines truncated)
```

All weather data in hand. Now I'll verify the roller and open the journal.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --help 2>&1 || sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label test-init 2>&1
```

```
Usage: roll.sh --label TEXT [--seed SEED] [--sides N] [--count N]
```

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label test-init 2>&1
```

```
roll seed=sonnet1 label=test-init die=d6 => 1
1
```

Roller confirmed. Writing the session journal and launching the race.

_(Write)_ `{"file_path": "/mnt/v/users/Austin/Documents/git/lite-rpg/transcripts/cannonball-rally-20260615-140000.md", "content": "# Cannonball Rally\n\n**Date:** 2026-06-15 14:00\n**Seed:** sonnet1\n**Dice:** script\n**Seats:**\n- Alex — player, Ambulance\n- Blake — player, Motorcycle\n- Casey — player, 4x4\n- Drew — player, SUV\n- Ellis — player, 2-door Supercar\n- Frankie — player, 4-door Sedan\n- GM — referee (AI)\n\n**Weather mode:** Stage Weather hook (real NOAA forecasts)\n**Race start:** 2026-06-15 14:00 EDT; Forecast Offset 6 hr per stage order\n"}`

```
File created successfully at: /mnt/v/users/Austin/Documents/git/lite-rpg/transcripts/cannonball-rally-20260615-140000.md (file state is current in your context — no need to Read it back)
```

---

# CANNONBALL RALLY

**Seed:** `sonnet1` | **Dice:** script | **Weather:** real NOAA forecasts

## Session Setup

**Seats** (you play all six):

| Seat | Racer | Vehicle |
|------|-------|---------|
| 1 | **Alex** | Ambulance |
| 2 | **Blake** | Motorcycle |
| 3 | **Casey** | 4x4 |
| 4 | **Drew** | SUV |
| 5 | **Ellis** | 2-door Supercar |
| 6 | **Frankie** | 4-door Sedan |

**Turn order, Stage 1:** setup order — Alex, Blake, Casey, Drew, Ellis, Frankie.

**Stage weather pre-computed** (NOAA, race start 14:00 EDT + 6 hr per stage):

| Stage | City | Forecast window | Raw forecast | Ruling |
|-------|------|-----------------|--------------|--------|
| 1 — Escape from New York | New York | +6 hr → 8 PM EDT 6/15 | Mostly Clear, 73°F, 0% precip | **Clear and mild** |
| 2 — Appalachia | Pittsburgh | +12 hr → 2 AM EDT 6/16 | Mostly Clear, 54°F, 0% precip | **Clear and mild** |
| 3 — Route 66 | Springfield IL | +18 hr → 7 AM CDT 6/16 | Chance Showers and Thunderstorms, 61°F, 27% | **Storm** |
| 4 — Midwest | Tulsa | +24 hr → 1 PM CDT 6/16 | Sunny, 83°F, 3% | **Clear and mild** |
| 5a — Rocky Mountains | Denver | +30 hr → 6 PM MDT 6/16 | Mostly Clear, 90°F, 0% | **Clear and mild** |
| 5b — Southwest Desert | Flagstaff | +30 hr → 5 PM MST 6/16 | Sunny, 86°F, 0% | **Clear and mild** |
| 6 — California Dreamin' | Redondo Beach | +36 hr → 11 PM PDT 6/16 | Patchy Fog, 64°F, 0% precip | **Clear and mild** |

**Initial scoreboard:**

| Racer | Vehicle | Total Hours | Status |
|-------|---------|-------------|--------|
| Alex | Ambulance | 0 | Racing |
| Blake | Motorcycle | 0 | Racing |
| Casey | 4x4 | 0 | Racing |
| Drew | SUV | 0 | Racing |
| Ellis | 2-door Supercar | 0 | Racing |
| Frankie | 4-door Sedan | 0 | Racing |

---

## Round 1: Escape from New York

**Announcement.** Stage Weather hook resolved from NOAA source: 8 PM EDT 6/15 New York → Mostly Clear, 73°F → **Clear and mild** (no counts-as effects trigger). Standard time: Base 2 hr + Traffic Penalty 0.5 hr (Heavy traffic) = **2.5 hr** to sit through it. Police tier: **Heavy (threshold 3)** — beat a 3 to avoid pull-over.

---

### Alex's Brief — Ambulance

**Standing:** 0 hr | Racing

**Applicable effects:**
- Police save (Lights OFF): **+1** to police roll
- Medium/high-grade roads: +0.5 hr (none here — Urban stage, Grade: none)
- Medium/high-bank roads: +0.5 hr (none here — Bank: none)
- Traffic: **Heavy** → +0.5 hr unless erased
- **Lights & Sirens!** *(Action)* — Switch on: −1 hr, erases Traffic Penalty without a roll. Your lights-OFF police bonus does **not** apply this stage if you use it.
- **Somethin's Up** *(Passive)* — −1 to police save per additional ambulance. (No other ambulances: no effect.)
- **You See, Officer...** *(Passive)* — +0.5 hr extra when pulled over.

**Police bar:** 3 (Heavy). Beat it strictly to avoid pull-over.

**Decision:** Cruise or speed? Use Lights & Sirens? (Speeding lowers police save by −1.)

`Alex: <cruise|speed>[, Lights & Sirens!], police <roll>`

**User:**

cruise

`Alex: cruise, police [pending]`

Noted. Moving to Blake.

---

### Blake's Brief — Motorcycle

**Standing:** 0 hr | Racing

**Applicable effects:**
- Precipitation/ice: +0.5 hr (weather is Clear and mild — no effect)
- Traffic penalties: **halved** for you (Heavy traffic → +0.25 hr instead of 0.5 hr)
- Police save: **−1**
- **Split the Lanes** *(Action)* — Roll to erase Traffic Penalty (beat traffic tier 3). Fail: +0.5 hr fender-bender on top of the penalty.
- **Hooliganism** *(Action, Suspect)* — Roll to get around any on-road obstacle (beat its tier). Suspect: −1 to police save.
- **Biker Gang** *(Passive)* — No other motorcycles in race, so no effect.
- **Loud Pipes** *(Passive)* — No other motorcycle has used an ability yet, so no penalty.
- **Double Down** *(Reaction)* — If pulled over: roll even to escape (no Pull-Over Penalty, actions succeed); roll odd → **jail** (DNF).

**Traffic:** Heavy (tier 3). Your base penalty is halved to **+0.25 hr**. Split the Lanes can erase it entirely (beat a 3), but failure costs you +0.5 hr extra.

**Police bar:** 3 (Heavy). Your save is at **−1** baseline. Speeding adds another −1.

**Decision:** Cruise or speed? Use Split the Lanes or Hooliganism?

`Blake: <cruise|speed>[, Split the Lanes <roll>][, Hooliganism <roll>], police <roll>`

**User:**

split the lanes, cruise

`Blake: cruise, Split the Lanes [roll pending], police [pending]`

Noted. Moving to Casey.

---

### Casey's Brief — 4x4

**Standing:** 0 hr | Racing

**Applicable effects:**
- Inclement weather: negate up to 1 hr of weather penalties (weather is Clear and mild — no inclement, no effect)
- Highway stages: +0.5 hr (this is Urban — no effect)
- High-bank roads: +0.5 hr (Bank: none — no effect)
- Traffic: Heavy → +0.5 hr unless erased
- **Built for This** *(Action, Suspect)* — Roll to erase Traffic Penalty (beat traffic tier 3). Fail: +0.5 hr fender-bender on top. Suspect: −1 to police save.
- **Cut Corners** *(Action, Suspect)* — Non-Urban only. This stage is Urban — **unavailable**.

**Police bar:** 3 (Heavy). No baseline save modifier. Speeding −1, Built for This −1 each if used.

**Decision:** Cruise or speed? Use Built for This?

`Casey: <cruise|speed>[, Built for This <roll>], police <roll>`

**User:**

cruise

`Casey: cruise, police [pending]`

Noted. Moving to Drew.

---

### Drew's Brief — SUV

**Standing:** 0 hr | Racing

**Applicable effects:**
- Urban stages: **−0.5 hr** (everyone yields to the behemoth — applies here!)
- Highway stages: +0.5 hr (not a highway — no effect)
- Medium/high-grade roads: −0.5 hr (Grade: none — no effect)
- High-bank roads: +0.5 hr (Bank: none — no effect)
- Traffic: Heavy → +0.5 hr unless erased
- No abilities (SUV has no Action/Reaction/Passive abilities)

**Police bar:** 3 (Heavy). No police save modifier. Speeding −1.

**Decision:** Cruise or speed?

`Drew: <cruise|speed>, police <roll>`

**User:**

cruise

`Drew: cruise, police [pending]`

Noted. Moving to Ellis.

---

### Ellis's Brief — 2-door Supercar

**Standing:** 0 hr | Racing

**Applicable effects:**
- Police save: **−1**
- Highway stages: −0.5 hr (this is Urban — no effect)
- Any banked road: −0.5 hr (Bank: none — no effect)
- Precipitation: +0.5 hr (Clear and mild — no effect)
- Traffic: Heavy → +0.5 hr unless erased
- **Need for Speed** *(Passive)* — When speeding, subtract **1 hr** instead of the Speeding Bonus (0.5 hr). A big upgrade if you speed.
- **Gun It** *(Reaction)* — If pulled over **while speeding on a Highway stage**: roll >2 to escape. This stage is Urban, not Highway — **Gun It is unavailable here**.

**Police bar:** 3 (Heavy). Baseline **−1** to save. Speeding adds another −1.

**Decision:** Cruise or speed? (Speeding saves 1 hr via Need for Speed, but police save drops to roll−2, must beat 3.)

`Ellis: <cruise|speed>, police <roll>`

**User:**

cruise

`Ellis: cruise, police [pending]`

Noted. Moving to Frankie.

---

### Frankie's Brief — 4-door Sedan

**Standing:** 0 hr | Racing

**Applicable effects:**
- Inclement weather: +0.5 hr (Clear and mild — no effect)
- High-grade roads: +0.5 hr (Grade: none — no effect)
- High traffic: **+0.5 hr** (Heavy traffic qualifies — this stacks on top of the standard Traffic Penalty!)
- Police save: **+1**
- Highway stages: −1 hr (Urban stage — no effect)
- **Blend In** *(Reaction)* — If pulled over when traffic is Medium or Heavy: take +1 to police save and re-roll. Pass → no Pull-Over Penalty. Fail → Pull-Over Penalty + additional +0.5 hr.

**Traffic:** Heavy → standard +0.5 hr Traffic Penalty, PLUS Frankie's passive +0.5 hr (high traffic). Total +1.0 hr from traffic if not erased. No ability to get around traffic.

**Police bar:** 3 (Heavy). Baseline **+1** to save. Speeding −1.

**Decision:** Cruise or speed?

`Frankie: <cruise|speed>, police <roll>`

**User:**

speed

`Frankie: speed, police [pending]`

All six declarations received. Declarations phase complete.

---

**Declarations (Stage 1 — Escape from New York):**
- `Alex: cruise, police [pending]`
- `Blake: cruise, Split the Lanes [pending], police [pending]`
- `Casey: cruise, police [pending]`
- `Drew: cruise, police [pending]`
- `Ellis: cruise, police [pending]`
- `Frankie: speed, police [pending]`

Now rolling all at once — Blake's ability check first, then all six police saves.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-blake-split-lanes 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-alex-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-blake-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-casey-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-drew-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-ellis-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-frankie-police 2>&1
```

```
roll seed=sonnet1 label=stage1-blake-split-lanes die=d6 => 2
2
roll seed=sonnet1 label=stage1-alex-police die=d6 => 5
5
roll seed=sonnet1 label=stage1-blake-police die=d6 => 3
3
roll seed=sonnet1 label=stage1-casey-police die=d6 => 3
3
... (6 more lines truncated)
```

**Rolls:**

```
roll seed=sonnet1 label=stage1-blake-split-lanes die=d6 => 2
roll seed=sonnet1 label=stage1-alex-police die=d6 => 5
roll seed=sonnet1 label=stage1-blake-police die=d6 => 3
roll seed=sonnet1 label=stage1-casey-police die=d6 => 3
roll seed=sonnet1 label=stage1-drew-police die=d6 => 3
roll seed=sonnet1 label=stage1-ellis-police die=d6 => 3
roll seed=sonnet1 label=stage1-frankie-police die=d6 => 2
```

---

**Reactions beat — stop before applying mechanics:**

**Blake's Split the Lanes:** rolled 2, must beat traffic tier 3. 2 does not beat 3 → **failure** (fender-bender pending).

**Police saves** (must beat threshold 3 — ties lose):
- Alex: 5 + 1 (lights OFF) = **6 → pass** ✓
- Blake: 3 − 1 (motorcycle) = **2 → pulled over** ✗
- Casey: 3 + 0 = **3 → pulled over** ✗ (tie loses)
- Drew: 3 + 0 = **3 → pulled over** ✗
- Ellis: 3 − 1 (supercar) = **2 → pulled over** ✗
- Frankie: 2 + 1 (sedan) − 1 (speeding) = **2 → pulled over** ✗

Five racers are pulled over. Offering reactions now — each is your call:

---

**Blake — Double Down (Reaction)**
You're pulled over on the bike. Roll even → clean getaway: no Pull-Over Penalty, and your Split the Lanes **succeeds** (Traffic Penalty erased). Roll odd → **jail** (DNF from the rally). This is always your call.

> Use Double Down? (yes / no)

**User:**

no

Blake declines Double Down. Pull-over stands.

**Casey — no applicable reaction.** Pull-over stands automatically.

**Drew — no applicable reaction.** Pull-over stands automatically.

**Ellis — Gun It requires speeding on a Highway stage.** Ellis was cruising on an Urban stage — no reaction available. Pull-over stands.

---

**Frankie — Blend In (Reaction)**
Traffic is Heavy, so Blend In is available. Take +1 to your police save and re-roll. Your net modifier on the re-roll: +1 (sedan) − 1 (speeding) + 1 (Blend In) = **+1**. Need to roll > 2 (i.e., 3 or higher) to beat the bar. Pass → no Pull-Over Penalty. Fail → Pull-Over Penalty (+1 hr) **plus** an additional +0.5 hr.

> Use Blend In? (yes / no)

**User:**

yes

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage1-frankie-blend-in 2>&1
```

```
roll seed=sonnet1 label=stage1-frankie-blend-in die=d6 => 4
4
```

```
roll seed=sonnet1 label=stage1-frankie-blend-in die=d6 => 4
```

Frankie: 4 + 1 (sedan) − 1 (speeding) + 1 (Blend In) = **5 → beats 3** ✓ — they blend into traffic, no Pull-Over Penalty.

All reactions resolved. Now applying mechanics.

---

**Resolution — Stage 1: Escape from New York**

Modifier order: Base Stage Time → road modifiers → weather modifiers → Traffic Penalty → Speeding Bonus → ability time effects → Pull-Over Penalty.

Cross-check field-keyed effects: Somethin's Up (Ambulance passive) — only 1 ambulance, no effect. Loud Pipes (Motorcycle passive) — Blake's the only motorcycle, no other motorcycle used an ability before Blake, no effect.

Cross-check consequence-revoked benefits: pulled-over racers who used no Suspect abilities have nothing to revoke.

**Alex:** cruise, no abilities, lights OFF (no Lights & Sirens! used), pass police.
- Base: 2.0 hr
- Roads (Urban, no grade, no bank): 0
- Weather (Clear and mild): 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Speeding Bonus: 0 (cruising)
- Ability effects: 0
- Pull-Over Penalty: 0 (passed)
- **Stage total: 2.5 hr**

**Blake:** cruise, Split the Lanes failed (fender-bender), pulled over (declined Double Down).
- Base: 2.0 hr
- Roads: 0
- Weather: 0
- Traffic Penalty (Heavy, not erased — fail means penalty stays, halved for motorcycle): +0.25 hr
- Speeding Bonus: 0
- Ability effects: fender-bender +0.5 hr (from failed Split the Lanes)
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.75 hr**

**Casey:** cruise, no abilities, pulled over.
- Base: 2.0 hr
- Roads (Urban, no grade, no bank, not highway): 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Speeding Bonus: 0
- Ability effects: 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.5 hr**

**Drew:** cruise, no abilities, pulled over.
- Base: 2.0 hr
- Urban stage: −0.5 hr (SUV passive)
- Roads (no grade, no bank): 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Speeding Bonus: 0
- Ability effects: 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.0 hr**

**Ellis:** cruise, no abilities, pulled over.
- Base: 2.0 hr
- Roads (Urban, not highway, no bank): 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Speeding Bonus: 0
- Ability effects: 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.5 hr**

**Frankie:** speed, Blend In succeeded (no Pull-Over Penalty).
- Base: 2.0 hr
- Roads (not highway, no grade, no bank): 0
- Weather: 0
- Traffic Penalty — Heavy traffic applies AND Frankie's passive adds +0.5 hr (high traffic). Not erased. Standard penalty +0.5 hr + passive +0.5 hr = **+1.0 hr**
- Speeding Bonus: −0.5 hr
- Ability effects: 0
- Pull-Over Penalty: 0 (Blend In passed)
- **Stage total: 2.5 hr**

---

**State after Stage 1** (sorted by total hours, ties in setup order):

| Racer | Vehicle | Total Hours | Status |
|-------|---------|-------------|--------|
| Alex | Ambulance | 2.5 | Racing |
| Frankie | 4-door Sedan | 2.5 | Racing |
| Drew | SUV | 3.0 | Racing |
| Casey | 4x4 | 3.5 | Racing |
| Ellis | 2-door Supercar | 3.5 | Racing |
| Blake | Motorcycle | 3.75 | Racing |

End check: final slot is 6 — race continues. Turn order for Stage 2: Alex, Frankie (tied at 2.5, setup order Alex=1/Frankie=6), Drew, Casey, Ellis, Blake.

---

## Round 2: Appalachia

**Announcement.** Stage Weather hook, NOAA source: 2 AM EDT 6/16 Pittsburgh → Mostly Clear, 54°F → **Clear and mild** (no counts-as effects). Standard time: Base 2 hr + Traffic Penalty 0.5 hr (Medium traffic) = **2.5 hr** to sit through it. Police tier: **Medium (threshold 2)**. Road modifiers in play: **Grade: medium, Bank: medium** — check your vehicle card.

---

### Alex's Brief — Ambulance

**Standing:** 2.5 hr | Racing

**Applicable effects this stage:**
- Medium-grade roads: **+0.5 hr**
- Medium-bank roads: **+0.5 hr**
- Police save (lights OFF): **+1**
- Traffic: Medium → +0.5 hr unless erased
- **Lights & Sirens!** *(Action)* — −1 hr, erases Traffic Penalty without roll. Lights-OFF police bonus does NOT apply if used.
- **Somethin's Up** *(Passive)* — No other ambulances. No effect.
- **You See, Officer...** *(Passive)* — +0.5 hr extra if pulled over.

Road penalties are steep (+1.0 hr) before traffic. Lights & Sirens saves 1.5 hr total but costs the police bonus.

**Police bar:** 2 (Medium). Beat strictly.

**Decision:** Cruise or speed? Use Lights & Sirens?

`Alex: <cruise|speed>[, Lights & Sirens!], police <roll>`

**User:**

cruise

`Alex: cruise, police [pending]`

Noted. Moving to Frankie.

---

### Frankie's Brief — 4-door Sedan

**Standing:** 2.5 hr | Racing

**Applicable effects this stage:**
- Inclement weather: +0.5 hr (Clear and mild — no effect)
- High-grade roads: +0.5 hr (Grade: **medium** — not high, no effect)
- High traffic: +0.5 hr (traffic is **Medium** — not high, no effect)
- Police save: **+1**
- Highway stages: −1 hr (Rural stage — no effect)
- **Blend In** *(Reaction)* — Requires Medium or Heavy traffic. Traffic is Medium ✓ — available if pulled over.

**Traffic:** Medium → +0.5 hr unless erased. No ability to get around it.

**Police bar:** 2 (Medium). Beat strictly. Baseline +1 to save. Speeding −1.

**Decision:** Cruise or speed?

`Frankie: <cruise|speed>, police <roll>`

**User:**

speed

`Frankie: speed, police [pending]`

Noted. Moving to Drew.

---

### Drew's Brief — SUV

**Standing:** 3.0 hr | Racing

**Applicable effects this stage:**
- Urban stages: −0.5 hr (Rural stage — no effect)
- Highway stages: +0.5 hr (Rural stage — no effect)
- Medium/high-grade roads: **−0.5 hr** (Grade: medium ✓ — applies!)
- High-bank roads: +0.5 hr (Bank: **medium** — not high, no effect)
- Traffic: Medium → +0.5 hr unless erased
- No abilities.

**Police bar:** 2 (Medium). No baseline modifier. Speeding −1.

**Decision:** Cruise or speed?

`Drew: <cruise|speed>, police <roll>`

**User:**

cruise

`Drew: cruise, police [pending]`

Noted. Moving to Casey.

---

### Casey's Brief — 4x4

**Standing:** 3.5 hr | Racing

**Applicable effects this stage:**
- Inclement weather: negate up to 1 hr weather penalties (Clear and mild — no effect)
- Highway stages: +0.5 hr (Rural stage — no effect)
- High-bank roads: +0.5 hr (Bank: **medium** — not high, no effect)
- Traffic: Medium → +0.5 hr unless erased
- **Built for This** *(Action, Suspect)* — Roll to erase Traffic Penalty (beat traffic tier 2). Fail: +0.5 hr fender-bender on top. Suspect: −1 to police save.
- **Cut Corners** *(Action, Suspect)* — Non-Urban stage ✓ (Rural). Cut across land: −1 hr, −1 to police save. Suspect.

**Police bar:** 2 (Medium). No baseline modifier. Speeding −1, Built for This −1, Cut Corners −1 each if used.

**Decision:** Cruise or speed? Use Built for This? Use Cut Corners?

`Casey: <cruise|speed>[, Built for This <roll>][, Cut Corners], police <roll>`

**User:**

cut corners & speed

`Casey: speed, Cut Corners, police [pending]`

Noted. Moving to Ellis.

---

### Ellis's Brief — 2-door Supercar

**Standing:** 3.5 hr | Racing

**Applicable effects this stage:**
- Police save: **−1**
- Highway stages: −0.5 hr (Rural stage — no effect)
- Any banked road: **−0.5 hr** (Bank: medium ✓ — applies!)
- Precipitation: +0.5 hr (Clear and mild — no effect)
- Traffic: Medium → +0.5 hr unless erased
- **Need for Speed** *(Passive)* — Speeding subtracts **1 hr** instead of 0.5 hr.
- **Gun It** *(Reaction)* — Requires speeding on a Highway stage. This is Rural — **unavailable**.

**Police bar:** 2 (Medium). Baseline **−1**. Speeding adds another −1.

**Decision:** Cruise or speed? (Need for Speed makes speeding save 1 hr, but police save drops to roll−2 vs bar 2.)

`Ellis: <cruise|speed>, police <roll>`

**User:**

cruise

`Ellis: cruise, police [pending]`

Noted. Moving to Blake.

---

### Blake's Brief — Motorcycle

**Standing:** 3.75 hr | Racing

**Applicable effects this stage:**
- Precipitation/ice: +0.5 hr (Clear and mild — no effect)
- Traffic penalties: **halved** (Medium → +0.25 hr instead of 0.5 hr)
- Police save: **−1**
- **Split the Lanes** *(Action)* — Roll to erase Traffic Penalty (beat tier 2). Fail: +0.5 hr fender-bender on top.
- **Hooliganism** *(Action, Suspect)* — Roll to get around any on-road obstacle (beat tier). Suspect: −1 police save.
- **Loud Pipes** *(Passive)* — No other motorcycle, no effect.
- **Double Down** *(Reaction)* — If pulled over: roll even → escape, no penalty; roll odd → **jail**.

**Police bar:** 2 (Medium). Baseline **−1**. Speeding −1. Hooliganism −1 if used.

**Decision:** Cruise or speed? Use Split the Lanes or Hooliganism?

`Blake: <cruise|speed>[, Split the Lanes <roll>][, Hooliganism <roll>], police <roll>`

**User:**

split the lanes, cruise

`Blake: cruise, Split the Lanes [pending], police [pending]`

All six declarations in. Declarations phase complete.

---

**Declarations (Stage 2 — Appalachia):**
- `Alex: cruise, police [pending]`
- `Frankie: speed, police [pending]`
- `Drew: cruise, police [pending]`
- `Casey: speed, Cut Corners, police [pending]`
- `Ellis: cruise, police [pending]`
- `Blake: cruise, Split the Lanes [pending], police [pending]`

Rolling Blake's ability check and all six police saves now.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-blake-split-lanes 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-alex-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-frankie-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-drew-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-casey-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-ellis-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage2-blake-police 2>&1
```

```
roll seed=sonnet1 label=stage2-blake-split-lanes die=d6 => 1
1
roll seed=sonnet1 label=stage2-alex-police die=d6 => 5
5
roll seed=sonnet1 label=stage2-frankie-police die=d6 => 5
5
roll seed=sonnet1 label=stage2-drew-police die=d6 => 3
3
... (6 more lines truncated)
```

**Rolls:**

```
roll seed=sonnet1 label=stage2-blake-split-lanes die=d6 => 1
roll seed=sonnet1 label=stage2-alex-police die=d6 => 5
roll seed=sonnet1 label=stage2-frankie-police die=d6 => 5
roll seed=sonnet1 label=stage2-drew-police die=d6 => 3
roll seed=sonnet1 label=stage2-casey-police die=d6 => 2
roll seed=sonnet1 label=stage2-ellis-police die=d6 => 6
roll seed=sonnet1 label=stage2-blake-police die=d6 => 2
```

---

**Blake's Split the Lanes:** rolled 1, must beat tier 2. Failure — fender-bender pending.

**Police saves** (must beat threshold 2):
- Alex: 5 + 1 (lights OFF) = **6 → pass** ✓
- Frankie: 5 + 1 (sedan) − 1 (speeding) = **5 → pass** ✓
- Drew: 3 + 0 = **3 → pass** ✓
- Casey: 2 − 1 (speeding) − 1 (Cut Corners, Suspect) = **0 → pulled over** ✗
- Ellis: 6 − 1 (supercar) = **5 → pass** ✓
- Blake: 2 − 1 (motorcycle) = **1 → pulled over** ✗

Casey and Blake pulled over. Offering reactions:

**Casey — 4x4 has no Reaction ability.** Pull-over stands. Note: Casey was speeding (Suspect) and used Cut Corners (Suspect) — both benefits are revoked on pull-over.

---

**Blake — Double Down (Reaction)**
Pulled over again. Roll even → clean getaway: no Pull-Over Penalty, and Split the Lanes **retroactively succeeds** (Traffic Penalty erased). Roll odd → **jail** (DNF).

> Use Double Down? (yes / no)

**User:**

no

Blake declines. Pull-over stands.

No more reactions. Applying mechanics.

---

**Resolution — Stage 2: Appalachia**

Cross-check field-keyed effects: no Somethin's Up (one ambulance), no Loud Pipes trigger (Blake is only motorcycle). No field-keyed effects apply.

Cross-check consequence-revoked benefits for pulled-over racers:
- **Casey** used Cut Corners (Suspect, −1 hr benefit) and was speeding (Suspect, −0.5 hr Speeding Bonus). Both benefits revoked on pull-over.
- **Blake** used no Suspect abilities. Nothing to revoke.

**Alex:** cruise, no abilities, lights OFF, pass police.
- Base: 2.0 hr
- Medium-grade roads: +0.5 hr
- Medium-bank roads: +0.5 hr
- Weather: 0
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: 0
- Ability effects: 0
- Pull-Over Penalty: 0
- **Stage total: 3.5 hr → Running total: 2.5 + 3.5 = 6.0 hr**

**Frankie:** speed, pass police (Blend In not triggered).
- Base: 2.0 hr
- Roads (Rural, grade medium = not high, bank medium = not high): 0
- Weather: 0
- Traffic Penalty (Medium — not "high traffic," so Frankie's passive does NOT add extra here): +0.5 hr
- Speeding Bonus: −0.5 hr
- Ability effects: 0
- Pull-Over Penalty: 0
- **Stage total: 2.0 hr → Running total: 2.5 + 2.0 = 4.5 hr**

**Drew:** cruise, pass police.
- Base: 2.0 hr
- Medium/high-grade roads: **−0.5 hr** (grade medium ✓)
- High-bank roads: 0 (bank medium, not high)
- Weather: 0
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: 0
- Pull-Over Penalty: 0
- **Stage total: 2.0 hr → Running total: 3.0 + 2.0 = 5.0 hr**

**Casey:** speed, Cut Corners, pulled over. Both Suspect benefits revoked.
- Base: 2.0 hr
- Roads (Rural, no grade/bank penalties for 4x4 here): 0
- Weather: 0
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: **revoked** (Suspect, pulled over) → 0
- Cut Corners benefit (−1 hr): **revoked** (Suspect, pulled over) → 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.5 hr → Running total: 3.5 + 3.5 = 7.0 hr**

**Ellis:** cruise, pass police.
- Base: 2.0 hr
- Any banked road: **−0.5 hr** (bank medium ✓)
- Roads (Rural, not highway): 0
- Weather: 0
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: 0
- Pull-Over Penalty: 0
- **Stage total: 2.0 hr → Running total: 3.5 + 2.0 = 5.5 hr**

**Blake:** cruise, Split the Lanes failed (fender-bender), pulled over (declined Double Down).
- Base: 2.0 hr
- Roads: 0
- Weather: 0
- Traffic Penalty (Medium, not erased — fail means penalty stays, halved for motorcycle): +0.25 hr
- Speeding Bonus: 0
- Fender-bender: +0.5 hr
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.75 hr → Running total: 3.75 + 3.75 = 7.5 hr**

---

**State after Stage 2** (sorted lowest hours first, ties in setup order):

| Racer | Vehicle | Total Hours | Status |
|-------|---------|-------------|--------|
| Frankie | 4-door Sedan | 4.5 | Racing |
| Drew | SUV | 5.0 | Racing |
| Ellis | 2-door Supercar | 5.5 | Racing |
| Alex | Ambulance | 6.0 | Racing |
| Casey | 4x4 | 7.0 | Racing |
| Blake | Motorcycle | 7.5 | Racing |

End check: final slot is 6 — race continues. Turn order for Stage 3: Frankie, Drew, Ellis, Alex, Casey, Blake.

---

## Round 3: Route 66

**Announcement.** Stage Weather hook, NOAA source: 7 AM CDT 6/16 Springfield IL → Chance Showers and Thunderstorms, 61°F, 27% → **Storm** (thunderstorms qualify; storm has the longer counts-as list: precipitation, inclement). Storm counts as: **precipitation** and **inclement**. Standard time: Base 2 hr + Traffic Penalty 0.5 hr (Medium traffic) = **2.5 hr**. Police tier: **Light (threshold 1)**.

Storm matters for: Blake (+0.5 hr precipitation), Ellis (+0.5 hr precipitation), Casey's all-terrain negates up to 1 hr weather penalties if inclement, 4-door Sedan +0.5 hr inclement.

---

### Frankie's Brief — 4-door Sedan

**Standing:** 4.5 hr | Racing

**Applicable effects this stage:**
- Inclement weather: **+0.5 hr** (Storm is inclement ✓)
- High-grade roads: 0 (Grade: none)
- High traffic: 0 (Medium traffic — not high)
- Police save: **+1**
- Highway stages: **−1 hr** (Highway stage ✓ — applies!)
- **Blend In** *(Reaction)* — Medium traffic ✓ — available if pulled over.

**Traffic:** Medium → +0.5 hr unless erased. No ability to erase it.

**Police bar:** 1 (Light). Beat strictly. Baseline +1. Speeding −1.

**Decision:** Cruise or speed?

`Frankie: <cruise|speed>, police <roll>`

**User:**

speed

`Frankie: speed, police [pending]`

Noted. Moving to Drew.

---

### Drew's Brief — SUV

**Standing:** 5.0 hr | Racing

**Applicable effects this stage:**
- Urban stages: −0.5 hr (Highway — no effect)
- Highway stages: **+0.5 hr** (Highway ✓ — stopping for gas)
- Medium/high-grade roads: −0.5 hr (Grade: none — no effect)
- High-bank roads: +0.5 hr (Bank: none — no effect)
- Traffic: Medium → +0.5 hr unless erased
- No abilities.

**Police bar:** 1 (Light). No baseline modifier. Speeding −1.

**Decision:** Cruise or speed?

`Drew: <cruise|speed>, police <roll>`

**User:**

speed

`Drew: speed, police [pending]`

Noted. Moving to Ellis.

---

### Ellis's Brief — 2-door Supercar

**Standing:** 5.5 hr | Racing

**Applicable effects this stage:**
- Police save: **−1**
- Highway stages: **−0.5 hr** (Highway ✓ — applies!)
- Any banked road: −0.5 hr (Bank: none — no effect)
- Weather precipitation: **+0.5 hr** (Storm counts as precipitation ✓ — applies!)
- Traffic: Medium → +0.5 hr unless erased
- **Need for Speed** *(Passive)* — Speeding subtracts **1 hr** instead of 0.5 hr.
- **Gun It** *(Reaction)* — If pulled over while speeding on a Highway stage ✓ — **available if speeding**. Roll >2 to escape, no Pull-Over Penalty. Fail: escape but +1 hr repair, +1 hr more per previous failed Gun It (zero so far).

**Police bar:** 1 (Light). Baseline **−1**. Speeding adds another −1. Bar is only 1 — even at −1 baseline you need to roll > 1 (i.e., 2+) to pass; speeding means roll > 1 with net −2 so need roll ≥ 4 to beat 1.

Wait — let me re-check: modified save = roll + modifiers, must beat 1. With no speeding: roll − 1 > 1 → roll > 2 → need 3+. With speeding: roll − 2 > 1 → roll > 3 → need 4+.

**Gun It** is available if you speed and get pulled over. First failure costs +1 hr (no previous failures).

**Decision:** Cruise or speed? (Need for Speed saves 1 hr but police save tightens to needing 4+.)

`Ellis: <cruise|speed>, police <roll>`

**User:**

speed

`Ellis: speed, police [pending]`

Noted. Moving to Alex.

---

### Alex's Brief — Ambulance

**Standing:** 6.0 hr | Racing

**Applicable effects this stage:**
- Medium/high-grade roads: 0 (Grade: none)
- Medium/high-bank roads: 0 (Bank: none)
- Police save (lights OFF): **+1**
- Traffic: Medium → +0.5 hr unless erased
- **Lights & Sirens!** *(Action)* — −1 hr, erases Traffic Penalty without roll. Lights-OFF police bonus does NOT apply if used.
- **Somethin's Up** *(Passive)* — No other ambulances. No effect.
- **You See, Officer...** *(Passive)* — +0.5 hr extra if pulled over.

**Weather:** Storm — Ambulance card has no weather effects. No modifier.

**Police bar:** 1 (Light). Beat strictly. Baseline +1 (lights OFF). Speeding −1.

Lights & Sirens! saves 1.5 hr total (−1 hr + Traffic erased) but costs the +1 police bonus — on a Light bar, that matters: without L&S you pass on any roll ≥ 1 (always); with L&S your save is unmodified, still pass on roll ≥ 2.

**Decision:** Cruise or speed? Use Lights & Sirens?

`Alex: <cruise|speed>[, Lights & Sirens!], police <roll>`

**User:**

lights & sirens, speed

`Alex: speed, Lights & Sirens!, police [pending]`

Noted. Moving to Casey.

---

### Casey's Brief — 4x4

**Standing:** 7.0 hr | Racing

**Applicable effects this stage:**
- Inclement weather: **negate up to 1 hr of weather penalties** (Storm is inclement ✓ — all-terrain tires)
- Highway stages: **+0.5 hr** (Highway ✓ — stopping for gas)
- High-bank roads: 0 (Bank: none)
- Traffic: Medium → +0.5 hr unless erased
- **Built for This** *(Action, Suspect)* — Roll to erase Traffic Penalty (beat tier 2). Fail: +0.5 hr fender-bender. Suspect: −1 police save.
- **Cut Corners** *(Action, Suspect)* — Non-Urban only ✓ (Highway). −1 hr, −1 police save. Suspect.

**Weather:** Storm counts as inclement. 4x4's passive negates up to 1 hr of weather penalties — but Storm itself carries no penalty in the base rules (weather penalties only come from vehicle cards). No weather penalty to negate here.

**Police bar:** 1 (Light). No baseline modifier. Speeding −1, Built for This −1, Cut Corners −1 each if used.

**Decision:** Cruise or speed? Use Built for This? Use Cut Corners?

`Casey: <cruise|speed>[, Built for This <roll>][, Cut Corners], police <roll>`

**User:**

speed, built for this

`Casey: speed, Built for This [pending], police [pending]`

Noted. Moving to Blake.

---

### Blake's Brief — Motorcycle

**Standing:** 7.5 hr | Racing

**Applicable effects this stage:**
- Precipitation/ice: **+0.5 hr** (Storm counts as precipitation ✓ — applies!)
- Traffic penalties: **halved** (Medium → +0.25 hr instead of 0.5 hr)
- Police save: **−1**
- **Split the Lanes** *(Action)* — Roll to erase Traffic Penalty (beat tier 2). Fail: +0.5 hr fender-bender on top.
- **Hooliganism** *(Action, Suspect)* — Roll to get around any on-road obstacle (beat tier). Suspect: −1 police save.
- **Loud Pipes** *(Passive)* — No other motorcycle. No effect.
- **Double Down** *(Reaction)* — If pulled over: roll even → escape, no penalty; roll odd → **jail**.

**Police bar:** 1 (Light). Baseline **−1**. Must beat 1: roll − 1 > 1 → need roll ≥ 3. Speeding drops that to needing roll ≥ 4. Hooliganism too.

**Decision:** Cruise or speed? Use Split the Lanes or Hooliganism?

`Blake: <cruise|speed>[, Split the Lanes <roll>][, Hooliganism <roll>], police <roll>`

**User:**

split lanes, cruise

`Blake: cruise, Split the Lanes [pending], police [pending]`

All six declarations in. Declarations phase complete.

---

**Declarations (Stage 3 — Route 66):**
- `Frankie: speed, police [pending]`
- `Drew: speed, police [pending]`
- `Ellis: speed, police [pending]`
- `Alex: speed, Lights & Sirens!, police [pending]`
- `Casey: speed, Built for This [pending], police [pending]`
- `Blake: cruise, Split the Lanes [pending], police [pending]`

Rolling all ability checks and police saves now.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-casey-built-for-this 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-blake-split-lanes 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-frankie-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-drew-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-ellis-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-alex-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-casey-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-blake-police 2>&1
```

```
roll seed=sonnet1 label=stage3-casey-built-for-this die=d6 => 6
6
roll seed=sonnet1 label=stage3-blake-split-lanes die=d6 => 3
3
roll seed=sonnet1 label=stage3-frankie-police die=d6 => 2
2
roll seed=sonnet1 label=stage3-drew-police die=d6 => 3
3
... (8 more lines truncated)
```

**Rolls:**

```
roll seed=sonnet1 label=stage3-casey-built-for-this die=d6 => 6
roll seed=sonnet1 label=stage3-blake-split-lanes die=d6 => 3
roll seed=sonnet1 label=stage3-frankie-police die=d6 => 2
roll seed=sonnet1 label=stage3-drew-police die=d6 => 3
roll seed=sonnet1 label=stage3-ellis-police die=d6 => 1
roll seed=sonnet1 label=stage3-alex-police die=d6 => 3
roll seed=sonnet1 label=stage3-casey-police die=d6 => 1
roll seed=sonnet1 label=stage3-blake-police die=d6 => 5
```

---

**Casey's Built for This:** 6 beats tier 2 → **success** — Traffic Penalty erased (for now).

**Blake's Split the Lanes:** 3 beats tier 2 → **success** — Traffic Penalty erased!

**Police saves** (must beat threshold 1):
- Frankie: 2 + 1 (sedan) − 1 (speeding) = **2 → pass** ✓
- Drew: 3 + 0 − 1 (speeding) = **2 → pass** ✓
- Ellis: 1 − 1 (supercar) − 1 (speeding) = **−1 → pulled over** ✗
- Alex: 3 + 0 (L&S! active, no lights-OFF bonus) − 1 (speeding) = **2 → pass** ✓
- Casey: 1 − 1 (speeding) − 1 (Built for This, Suspect) = **−1 → pulled over** ✗
- Blake: 5 − 1 (motorcycle) = **4 → pass** ✓

Ellis and Casey pulled over. Reactions:

**Casey — no Reaction ability.** Pull-over stands. Note: speeding (Suspect) and Built for This (Suspect, erased traffic) — both benefits revoked, including the traffic erasure.

---

**Ellis — Gun It (Reaction)**
Pulled over while speeding on a Highway stage — Gun It is available. Roll >2 to outrun them: clean getaway, no Pull-Over Penalty. Fail: you still escape, but **+1 hr** fixing what broke past 200 mph (no previous failures, so no stacking penalty yet).

> Use Gun It? (yes / no)

**User:**

yes

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage3-ellis-gun-it 2>&1
```

```
roll seed=sonnet1 label=stage3-ellis-gun-it die=d6 => 5
5
```

```
roll seed=sonnet1 label=stage3-ellis-gun-it die=d6 => 5
```

5 > 2 → **clean getaway!** Ellis punches it and disappears into the storm. No Pull-Over Penalty.

All reactions resolved. Applying mechanics.

---

**Resolution — Stage 3: Route 66**

Cross-check field-keyed effects: one ambulance, no Somethin's Up effect. Blake is only motorcycle, no Loud Pipes effect. No field-keyed effects apply.

Cross-check consequence-revoked benefits for pulled-over racers:
- **Casey** used Built for This (Suspect — erased Traffic Penalty) and speeding (Suspect — −0.5 hr). Both revoked: Traffic Penalty reinstated, Speeding Bonus lost.
- **Ellis** used Gun It successfully — no pull-over penalty. Ellis was speeding (Suspect) but passed the pull-over via Reaction, so no revocation applies.

**Frankie:** speed, pass police.
- Base: 2.0 hr
- Highway: −1.0 hr (sedan passive ✓)
- Weather (Storm, inclement): +0.5 hr (sedan passive)
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: −0.5 hr
- Pull-Over Penalty: 0
- **Stage total: 1.5 hr → Running total: 4.5 + 1.5 = 6.0 hr**

**Drew:** speed, pass police.
- Base: 2.0 hr
- Highway: +0.5 hr (SUV gas stop)
- Weather: 0 (SUV has no weather effects)
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: −0.5 hr
- Pull-Over Penalty: 0
- **Stage total: 2.5 hr → Running total: 5.0 + 2.5 = 7.5 hr**

**Ellis:** speed, Gun It succeeded (no Pull-Over Penalty).
- Base: 2.0 hr
- Highway: −0.5 hr (supercar)
- Weather (Storm, precipitation): +0.5 hr (supercar)
- Traffic Penalty (Medium, not erased): +0.5 hr
- Need for Speed: −1.0 hr (speeding, uses 1 hr instead of 0.5 hr Speeding Bonus)
- Pull-Over Penalty: 0 (Gun It)
- **Stage total: 1.5 hr → Running total: 5.5 + 1.5 = 7.0 hr**

**Alex:** speed, Lights & Sirens!, pass police.
- Base: 2.0 hr
- Roads (Highway, no grade, no bank for ambulance): 0
- Weather: 0 (ambulance has no weather effects)
- Traffic Penalty: **erased** (Lights & Sirens!)
- Speeding Bonus: −0.5 hr
- Lights & Sirens! effect: −1.0 hr
- Pull-Over Penalty: 0
- **Stage total: 0.5 hr → Running total: 6.0 + 0.5 = 6.5 hr**

**Casey:** speed, Built for This succeeded but pull-over revokes it; both Suspect benefits revoked.
- Base: 2.0 hr
- Highway: +0.5 hr (4x4 gas stop)
- Weather (Storm, inclement): 0 — 4x4 negates up to 1 hr weather penalties, but base Storm has no penalty; no penalty to negate.
- Traffic Penalty (Medium, not erased — Built for This revoked): +0.5 hr
- Speeding Bonus: **revoked** → 0
- Built for This benefit: **revoked** → 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 4.0 hr → Running total: 7.0 + 4.0 = 11.0 hr**

**Blake:** cruise, Split the Lanes succeeded (Traffic Penalty erased), pass police.
- Base: 2.0 hr
- Roads (Highway, no grade, no bank for motorcycle): 0
- Weather (Storm, precipitation): +0.5 hr (motorcycle)
- Traffic Penalty: **erased** (Split the Lanes ✓)
- Speeding Bonus: 0 (cruising)
- Pull-Over Penalty: 0
- **Stage total: 2.5 hr → Running total: 7.5 + 2.5 = 10.0 hr**

---

**State after Stage 3** (sorted lowest hours first):

| Racer | Vehicle | Total Hours | Status |
|-------|---------|-------------|--------|
| Frankie | 4-door Sedan | 6.0 | Racing |
| Alex | Ambulance | 6.5 | Racing |
| Ellis | 2-door Supercar | 7.0 | Racing |
| Drew | SUV | 7.5 | Racing |
| Blake | Motorcycle | 10.0 | Racing |
| Casey | 4x4 | 11.0 | Racing |

End check: not at final slot yet. Turn order for Stage 4: Frankie, Alex, Ellis, Drew, Blake, Casey.

---

## Round 4: Midwest

**Announcement.** Stage Weather hook, NOAA source: 1 PM CDT 6/16 Tulsa → Sunny, 83°F, 3% → **Clear and mild** (no counts-as effects). Standard time: Base 2 hr, no Traffic Penalty (Light traffic — Light tier applies only to police, not standard time addition). 

Wait — re-reading: "Traffic Penalty: Hours added when stage traffic applies and is not gotten around." The rule says traffic applies when Medium or Heavy. Light traffic does NOT trigger the Traffic Penalty. Standard time: **2.0 hr**. Police tier: **Light (threshold 1)**.

---

### Frankie's Brief — 4-door Sedan

**Standing:** 6.0 hr | Racing

**Applicable effects this stage:**
- Inclement weather: +0.5 hr (Clear and mild — no effect)
- High-grade roads: 0 (Grade: none)
- High traffic: +0.5 hr (Light traffic — not high, no effect)
- Police save: **+1**
- Highway stages: **−1 hr** (Highway ✓ — applies!)
- **Blend In** *(Reaction)* — Requires Medium or Heavy traffic. Traffic is Light — **unavailable this stage**.

**Traffic:** Light → no Traffic Penalty.

**Police bar:** 1 (Light). Baseline +1. Speeding −1. Net 0 when speeding — need roll > 1, i.e., 2+.

**Decision:** Cruise or speed?

`Frankie: <cruise|speed>, police <roll>`

**User:**

cruise

`Frankie: cruise, police [pending]`

Noted. Moving to Alex.

---

### Alex's Brief — Ambulance

**Standing:** 6.5 hr | Racing

**Applicable effects this stage:**
- Medium/high-grade roads: 0 (Grade: none)
- Medium/high-bank roads: 0 (Bank: none)
- Police save (lights OFF): **+1**
- Traffic: Light → **no Traffic Penalty**
- **Lights & Sirens!** *(Action)* — −1 hr, erases Traffic Penalty (already none). Lights-OFF police bonus lost if used. Less valuable here with no traffic to erase.
- **You See, Officer...** *(Passive)* — +0.5 hr extra if pulled over.

**Weather:** Clear and mild — no ambulance effects.

**Police bar:** 1 (Light). Baseline +1 (lights OFF). Speeding −1.

**Decision:** Cruise or speed? Use Lights & Sirens? (L&S only saves 1 hr this stage, no traffic to erase.)

`Alex: <cruise|speed>[, Lights & Sirens!], police <roll>`

**User:**

lights & sirens, speed

`Alex: speed, Lights & Sirens!, police [pending]`

Noted. Moving to Ellis.

---

### Ellis's Brief — 2-door Supercar

**Standing:** 7.0 hr | Racing

**Applicable effects this stage:**
- Police save: **−1**
- Highway stages: **−0.5 hr** (Highway ✓ — applies!)
- Any banked road: −0.5 hr (Bank: none — no effect)
- Weather precipitation: +0.5 hr (Clear and mild — no effect)
- Traffic: Light → **no Traffic Penalty**
- **Need for Speed** *(Passive)* — Speeding subtracts **1 hr** instead of 0.5 hr.
- **Gun It** *(Reaction)* — If pulled over while speeding on a Highway stage ✓ — available if speeding. Roll >2 to escape clean. Fail: +1 hr repair **+1 hr more** for the previous failed Gun It (0 previous failures — wait, Ellis's Gun It succeeded last stage, so 0 failed Gun Its). Cost if fail: +1 hr.

**Police bar:** 1 (Light). Baseline **−1**. Speeding −1 more. Need roll > 1 modified: cruising needs roll ≥ 3; speeding needs roll ≥ 4.

**Decision:** Cruise or speed?

`Ellis: <cruise|speed>, police <roll>`

**User:**

speed

`Ellis: speed, police [pending]`

Noted. Moving to Drew.

---

### Drew's Brief — SUV

**Standing:** 7.5 hr | Racing

**Applicable effects this stage:**
- Urban stages: −0.5 hr (Highway — no effect)
- Highway stages: **+0.5 hr** (Highway ✓ — gas stop)
- Medium/high-grade roads: −0.5 hr (Grade: none — no effect)
- High-bank roads: +0.5 hr (Bank: none — no effect)
- Traffic: Light → **no Traffic Penalty**
- No abilities.

**Police bar:** 1 (Light). No baseline modifier. Speeding −1. Cruising: need roll ≥ 2. Speeding: need roll ≥ 3.

**Decision:** Cruise or speed?

`Drew: <cruise|speed>, police <roll>`

**User:**

speed

`Drew: speed, police [pending]`

Noted. Moving to Blake.

---

### Blake's Brief — Motorcycle

**Standing:** 10.0 hr | Racing

**Applicable effects this stage:**
- Precipitation/ice: +0.5 hr (Clear and mild — no effect)
- Traffic penalties: halved (Light traffic → no penalty anyway — no effect)
- Police save: **−1**
- **Split the Lanes** *(Action)* — Roll to erase Traffic Penalty (no penalty here — no benefit). Not useful.
- **Hooliganism** *(Action, Suspect)* — Roll to get around any on-road obstacle (beat its tier). Suspect: −1 police save.
- **Double Down** *(Reaction)* — If pulled over: roll even → escape; roll odd → **jail**.

**Traffic:** Light → no Traffic Penalty. Split the Lanes has nothing to erase.

**Police bar:** 1 (Light). Baseline **−1**. Need roll ≥ 3 to pass. Speeding drops to need ≥ 4. Hooliganism drops to need ≥ 4.

**Decision:** Cruise or speed? Any ability?

`Blake: <cruise|speed>[, Hooliganism <roll>], police <roll>`

**User:**

split traffic, cruise

Noted — Blake declares Split the Lanes on Light traffic. The brief flagged no penalty to erase, but the roll still happens and a failure still costs +0.5 hr fender-bender. Moving to Casey.

---

### Casey's Brief — 4x4

**Standing:** 11.0 hr | Racing

**Applicable effects this stage:**
- Inclement weather: negate up to 1 hr penalties (Clear and mild — no effect)
- Highway stages: **+0.5 hr** (Highway ✓ — gas stop)
- High-bank roads: 0 (Bank: none)
- Traffic: Light → **no Traffic Penalty**
- **Built for This** *(Action, Suspect)* — Roll to erase Traffic Penalty (none here — no benefit, but failure costs +0.5 hr). Not useful.
- **Cut Corners** *(Action, Suspect)* — Non-Urban ✓ (Highway). −1 hr, −1 police save. Suspect.

**Police bar:** 1 (Light). No baseline modifier. Speeding −1, Cut Corners −1 each if used. Cruising: need roll ≥ 2. Speeding: need roll ≥ 3. Both: need roll ≥ 4.

**Decision:** Cruise or speed? Use Cut Corners?

`Casey: <cruise|speed>[, Cut Corners], police <roll>`

**User:**

speed & cut corners

`Casey: speed, Cut Corners, police [pending]`

All six declarations in. Declarations phase complete.

---

**Declarations (Stage 4 — Midwest):**
- `Frankie: cruise, police [pending]`
- `Alex: speed, Lights & Sirens!, police [pending]`
- `Ellis: speed, police [pending]`
- `Drew: speed, police [pending]`
- `Blake: cruise, Split the Lanes [pending], police [pending]`
- `Casey: speed, Cut Corners, police [pending]`

Rolling all at once.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-blake-split-lanes 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-frankie-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-alex-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-ellis-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-drew-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-blake-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-casey-police 2>&1
```

```
roll seed=sonnet1 label=stage4-blake-split-lanes die=d6 => 1
1
roll seed=sonnet1 label=stage4-frankie-police die=d6 => 5
5
roll seed=sonnet1 label=stage4-alex-police die=d6 => 5
5
roll seed=sonnet1 label=stage4-ellis-police die=d6 => 2
2
... (6 more lines truncated)
```

**Rolls:**

```
roll seed=sonnet1 label=stage4-blake-split-lanes die=d6 => 1
roll seed=sonnet1 label=stage4-frankie-police die=d6 => 5
roll seed=sonnet1 label=stage4-alex-police die=d6 => 5
roll seed=sonnet1 label=stage4-ellis-police die=d6 => 2
roll seed=sonnet1 label=stage4-drew-police die=d6 => 1
roll seed=sonnet1 label=stage4-blake-police die=d6 => 6
roll seed=sonnet1 label=stage4-casey-police die=d6 => 2
```

---

**Blake's Split the Lanes:** rolled 1, must beat tier 1 — tie loses. **Failure** — fender-bender +0.5 hr (and no Traffic Penalty to erase anyway).

**Police saves** (must beat threshold 1):
- Frankie: 5 + 1 (sedan) = **6 → pass** ✓
- Alex: 5 + 0 (L&S! active) − 1 (speeding) = **4 → pass** ✓
- Ellis: 2 − 1 (supercar) − 1 (speeding) = **0 → pulled over** ✗
- Drew: 1 − 1 (speeding) = **0 → pulled over** ✗
- Blake: 6 − 1 (motorcycle) = **5 → pass** ✓
- Casey: 2 − 1 (speeding) − 1 (Cut Corners, Suspect) = **0 → pulled over** ✗

Ellis, Drew, and Casey pulled over. Reactions:

**Drew — no Reaction ability.** Pull-over stands.

**Casey — no Reaction ability.** Pull-over stands. Speeding (Suspect) and Cut Corners (Suspect) — both benefits revoked.

---

**Ellis — Gun It (Reaction)**
Speeding on a Highway stage — available. Roll >2 → clean getaway, no Pull-Over Penalty. Fail → escape but **+1 hr** repair (0 previous failed Gun Its).

> Use Gun It? (yes / no)

**User:**

yes

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage4-ellis-gun-it 2>&1
```

```
roll seed=sonnet1 label=stage4-ellis-gun-it die=d6 => 2
2
```

```
roll seed=sonnet1 label=stage4-ellis-gun-it die=d6 => 2
```

2 does NOT beat 2 (ties lose) → **Gun It fails.** Ellis escapes but something critical lets go past 200 mph. **+1 hr** repair (first failure). Pull-Over Penalty is waived per the card — "you still escape the police" — but the repair cost stands.

All reactions resolved. Applying mechanics.

---

**Resolution — Stage 4: Midwest**

Cross-check field-keyed effects: one ambulance, no Somethin's Up. Blake only motorcycle, no Loud Pipes. No field-keyed effects.

Cross-check consequence-revoked benefits:
- **Ellis** — Gun It failed. Ellis was speeding (Suspect) and got pulled over, but Gun It resolved as a Reaction and the card says the racer escapes — no Pull-Over Penalty. However, speeding is Suspect and Ellis was "pulled over" before the Reaction fired. Does the pull-over revoke speeding benefit? Re-reading: "without one — or declining it — they add the Pull-Over Penalty… and any Suspect ability they used this stage loses its benefits." Ellis used Gun It (a Reaction, not marked Suspect) and did NOT decline it. The Reaction fired and Ellis escaped via card text (no Pull-Over Penalty). So the pull-over consequence is replaced by the Gun It outcome. Ellis keeps the Need for Speed speeding benefit. The repair cost (+1 hr) is the only penalty.
- **Drew** — no Suspect abilities. No revocation.
- **Casey** — speeding (Suspect) and Cut Corners (Suspect). Both benefits revoked.

**Frankie:** cruise, pass police.
- Base: 2.0 hr
- Highway: −1.0 hr (sedan)
- Weather: 0
- Traffic Penalty: 0 (Light — no penalty)
- Speeding Bonus: 0 (cruising)
- Pull-Over Penalty: 0
- **Stage total: 1.0 hr → Running total: 6.0 + 1.0 = 7.0 hr**

**Alex:** speed, Lights & Sirens!, pass police.
- Base: 2.0 hr
- Roads: 0 (Highway, no grade, no bank for ambulance)
- Weather: 0
- Traffic Penalty: 0 (Light — no penalty; L&S! has nothing to erase)
- Speeding Bonus: −0.5 hr
- Lights & Sirens! effect: −1.0 hr
- Pull-Over Penalty: 0
- **Stage total: 0.5 hr → Running total: 6.5 + 0.5 = 7.0 hr**

**Ellis:** speed, Gun It failed (+1 hr repair, no Pull-Over Penalty), keeps Need for Speed.
- Base: 2.0 hr
- Highway: −0.5 hr (supercar)
- Weather: 0
- Traffic Penalty: 0 (Light)
- Need for Speed: −1.0 hr
- Gun It repair cost: +1.0 hr
- Pull-Over Penalty: 0 (Gun It card text)
- **Stage total: 1.5 hr → Running total: 7.0 + 1.5 = 8.5 hr**

**Drew:** speed, pulled over, no Suspect abilities.
- Base: 2.0 hr
- Highway: +0.5 hr (SUV gas)
- Weather: 0
- Traffic Penalty: 0 (Light)
- Speeding Bonus: −0.5 hr
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.0 hr → Running total: 7.5 + 3.0 = 10.5 hr**

**Blake:** cruise, Split the Lanes failed (fender-bender), pass police.
- Base: 2.0 hr
- Roads: 0
- Weather: 0
- Traffic Penalty: 0 (Light — nothing to erase either way)
- Fender-bender: +0.5 hr
- Pull-Over Penalty: 0
- **Stage total: 2.5 hr → Running total: 10.0 + 2.5 = 12.5 hr**

**Casey:** speed, Cut Corners, pulled over — both Suspect benefits revoked.
- Base: 2.0 hr
- Highway: +0.5 hr (4x4 gas)
- Weather: 0
- Traffic Penalty: 0 (Light)
- Speeding Bonus: **revoked** → 0
- Cut Corners benefit (−1 hr): **revoked** → 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.5 hr → Running total: 11.0 + 3.5 = 14.5 hr**

---

**State after Stage 4** (sorted lowest hours first):

| Racer | Vehicle | Total Hours | Status |
|-------|---------|-------------|--------|
| Frankie | 4-door Sedan | 7.0 | Racing |
| Alex | Ambulance | 7.0 | Racing |
| Ellis | 2-door Supercar | 8.5 | Racing |
| Drew | SUV | 10.5 | Racing |
| Blake | Motorcycle | 12.5 | Racing |
| Casey | 4x4 | 14.5 | Racing |

End check: not at final slot yet. Turn order for Stage 5: Frankie, Alex (tied 7.0, setup order), Ellis, Drew, Blake, Casey.

---

## Round 5: The Detour

**Announcement.** Slot 5 offers a choice — each racer picks their route:

- **Rocky Mountains** — Weather City: Denver. Grade: **high**, Bank: **high**. Traffic: Medium. Police: Medium (threshold 2). Base Stage Time: 2 hr.
- **Southwest Desert** — Weather City: Flagstaff. Grade: none, Bank: none. Traffic: Light. Police: Light (threshold 1). Base Stage Time: **3 hr**.

Stage Weather hook resolved for both (NOAA, +30 hr from race start = 6 PM MDT / 5 PM MST 6/16):
- **Denver (Rocky Mountains):** Mostly Clear, 90°F, 0% → **Clear and mild**
- **Flagstaff (Southwest Desert):** Sunny, 86°F, 0% → **Clear and mild**

Both routes: Clear and mild, no weather effects on any vehicle card.

---

### Frankie's Brief — 4-door Sedan

**Standing:** 7.0 hr | Racing

**Rocky Mountains:** Base 2 hr + Traffic Penalty 0.5 hr (Medium) = 2.5 hr standard. Police bar 2. High-grade → +0.5 hr (sedan, but grade needs to be "high" for +0.5 hr — yes, high grade applies ✓). High traffic (+0.5 hr passive) does not apply (Medium traffic, not high). Highway stage: −1 hr ✓. **Blend In** available (Medium traffic).

**Southwest Desert:** Base 3 hr, no Traffic Penalty (Light). Police bar 1. Highway: −1 hr ✓. No grade/bank penalties. **Blend In** unavailable (Light traffic).

Rocky: 2 + 0.5 (grade) + 0.5 (traffic) − 1 (highway) = **2.0 hr** before speed/police.
Desert: 3 + 0 − 1 (highway) = **2.0 hr** before speed/police. But police bar is only 1 and Blend In unavailable.

**Decision:** Which route? Cruise or speed?

`Frankie: <cruise|speed> via <Rocky Mountains|Southwest Desert>, police <roll>`

**User:**

speed through desert

`Frankie: speed via Southwest Desert, police [pending]`

Noted. Moving to Alex.

---

### Alex's Brief — Ambulance

**Standing:** 7.0 hr | Racing

**Rocky Mountains:** Base 2 hr + Traffic Penalty 0.5 hr (Medium) = 2.5 hr standard. Police bar 2. Grade: high → **+0.5 hr**. Bank: high → **+0.5 hr**. Road penalties hurt. Lights & Sirens! saves 1.5 hr (−1 hr + traffic erased).

**Southwest Desert:** Base 3 hr, no Traffic Penalty (Light). Police bar 1. Grade: none, Bank: none — no road penalties. Lights & Sirens! saves 1 hr only (no traffic to erase).

Rocky with L&S!: 2 + 0.5 + 0.5 − 1 (L&S!) = 2.0 hr. Desert: 3 − 1 (L&S!) = 2.0 hr. Desert saves the road penalties but has a higher base.

Police save (lights OFF): +1. Speeding: −1. L&S! active: no lights-OFF bonus.

**Decision:** Which route? Cruise or speed? Use Lights & Sirens?

`Alex: <cruise|speed>[, Lights & Sirens!] via <Rocky Mountains|Southwest Desert>, police <roll>`

**User:**

lights & sirents, speed through desert

`Alex: speed, Lights & Sirens! via Southwest Desert, police [pending]`

Noted. Moving to Ellis.

---

### Ellis's Brief — 2-door Supercar

**Standing:** 8.5 hr | Racing

**Rocky Mountains:** Base 2 hr + Traffic Penalty 0.5 hr (Medium) = 2.5 hr standard. Police bar 2. Grade: none for supercar. Bank: high → **−0.5 hr** (supercar loves banked roads). Highway: −0.5 hr ✓. **Gun It** available if speeding (Highway ✓). 0 clean getaways, **1 failed** Gun It — next failure costs +1 hr + **+1 hr** = +2 hr total.

**Southwest Desert:** Base 3 hr, no Traffic Penalty (Light). Police bar 1. Highway: −0.5 hr. Bank: none. **Gun It** available if speeding (Highway ✓). Same failure cost.

Rocky with Need for Speed: 2 + 0.5 (traffic) − 0.5 (bank) − 0.5 (highway) − 1 (speeding) = **1.5 hr**.
Desert with Need for Speed: 3 − 0.5 (highway) − 1 (speeding) = **1.5 hr**. Same before police.

Rocky police bar 2 (harder), Desert bar 1 (easier). Ellis's save: −1 (supercar) − 1 (speeding) = −2. Rocky: need roll ≥ 5. Desert: need roll ≥ 4. Gun It available both routes.

**Decision:** Which route? Cruise or speed?

`Ellis: <cruise|speed> via <Rocky Mountains|Southwest Desert>, police <roll>`

**User:**

speed through desert

`Ellis: speed via Southwest Desert, police [pending]`

Noted. Moving to Drew.

---

### Drew's Brief — SUV

**Standing:** 10.5 hr | Racing

**Rocky Mountains:** Base 2 hr + Traffic Penalty 0.5 hr (Medium) = 2.5 hr standard. Police bar 2. Grade: high → **−0.5 hr** (SUV loves grade ✓). Bank: high → **+0.5 hr** (SUV penalty). Highway: **+0.5 hr** (gas). Net road modifier: +0.5 hr.

**Southwest Desert:** Base 3 hr, no Traffic Penalty (Light). Police bar 1. Highway: **+0.5 hr** (gas). Grade: none, Bank: none.

Rocky: 2 + 0.5 (traffic) − 0.5 (grade) + 0.5 (bank) + 0.5 (highway gas) = **3.0 hr** before speed.
Desert: 3 + 0.5 (highway gas) = **3.5 hr** before speed. Rocky is cheaper despite the traffic!

Speeding: −0.5 hr either route. Police: no modifier. Rocky bar 2 (need roll ≥ 3 when speeding). Desert bar 1 (need roll ≥ 3 when speeding — same). No reaction ability.

**Decision:** Which route? Cruise or speed?

`Drew: <cruise|speed> via <Rocky Mountains|Southwest Desert>, police <roll>`

**User:**

cruise through mountains

`Drew: cruise via Rocky Mountains, police [pending]`

Noted. Moving to Blake.

---

### Blake's Brief — Motorcycle

**Standing:** 12.5 hr | Racing

**Rocky Mountains:** Base 2 hr + Traffic Penalty 0.5 hr (Medium, halved to 0.25 hr for motorcycle). Police bar 2. Grade: none (motorcycle has no grade modifier). Bank: none (motorcycle has no bank modifier). Highway: none (no highway modifier). Weather: Clear and mild — no precipitation penalty.

**Southwest Desert:** Base 3 hr. Traffic: Light → no penalty. Police bar 1. Highway: none.

Rocky: 2 + 0.25 (halved traffic) = **2.25 hr** standard. Desert: 3.0 hr standard. Rocky is cheaper.

**Split the Lanes** on Rocky (Medium tier 2): roll to erase 0.25 hr traffic. Failure: +0.5 hr fender-bender. **Risky** — fender-bender costs more than the penalty saves. Not recommended but your call.

Police save: −1 baseline. Rocky bar 2: need roll ≥ 4. Desert bar 1: need roll ≥ 3. Speeding adds −1 each.

**Double Down** *(Reaction)* — If pulled over: roll even → escape; roll odd → **jail**.

**Decision:** Which route? Cruise or speed? Any ability?

`Blake: <cruise|speed> via <Rocky Mountains|Southwest Desert>[, Split the Lanes <roll>], police <roll>`

**User:**

split lanes, speed through mountains

`Blake: speed, Split the Lanes [pending] via Rocky Mountains, police [pending]`

Noted. Moving to Casey.

---

### Casey's Brief — 4x4

**Standing:** 14.5 hr | Racing

**Rocky Mountains:** Base 2 hr + Traffic Penalty 0.5 hr (Medium). Police bar 2. Grade: none (4x4 has no grade modifier). Bank: high → **+0.5 hr**. Highway: **+0.5 hr** (gas). Inclement weather: none to negate (Clear and mild).

**Southwest Desert:** Base 3 hr. Traffic: Light → no penalty. Police bar 1. Highway: **+0.5 hr** (gas). No grade/bank penalties.

Rocky: 2 + 0.5 (traffic) + 0.5 (bank) + 0.5 (highway) = **3.5 hr** before abilities.
Desert: 3 + 0.5 (highway) = **3.5 hr** before abilities. Same cost!

**Built for This** (Rocky, Medium tier 2): roll to erase 0.5 hr traffic. Suspect: −1 police save.
**Cut Corners** (either, non-Urban ✓): −1 hr, Suspect: −1 police save.

Police: no baseline modifier. Rocky bar 2, Desert bar 1. Speeding −1, Suspect abilities −1 each.

**Decision:** Which route? Cruise or speed? Any abilities?

`Casey: <cruise|speed>[, Built for This <roll>][, Cut Corners] via <Rocky Mountains|Southwest Desert>, police <roll>`

**User:**

cruise through mountains

`Casey: cruise via Rocky Mountains, police [pending]`

All six declarations in. Declarations phase complete.

---

**Declarations (Stage 5 — The Detour):**
- `Frankie: speed via Southwest Desert, police [pending]`
- `Alex: speed, Lights & Sirens! via Southwest Desert, police [pending]`
- `Ellis: speed via Southwest Desert, police [pending]`
- `Drew: cruise via Rocky Mountains, police [pending]`
- `Blake: speed, Split the Lanes [pending] via Rocky Mountains, police [pending]`
- `Casey: cruise via Rocky Mountains, police [pending]`

Rolling Blake's Split the Lanes and all six police saves now.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-blake-split-lanes 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-frankie-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-alex-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-ellis-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-drew-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-blake-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-casey-police 2>&1
```

```
roll seed=sonnet1 label=stage5-blake-split-lanes die=d6 => 1
1
roll seed=sonnet1 label=stage5-frankie-police die=d6 => 4
4
roll seed=sonnet1 label=stage5-alex-police die=d6 => 3
3
roll seed=sonnet1 label=stage5-ellis-police die=d6 => 3
3
... (6 more lines truncated)
```

**Rolls:**

```
roll seed=sonnet1 label=stage5-blake-split-lanes die=d6 => 1
roll seed=sonnet1 label=stage5-frankie-police die=d6 => 4
roll seed=sonnet1 label=stage5-alex-police die=d6 => 3
roll seed=sonnet1 label=stage5-ellis-police die=d6 => 3
roll seed=sonnet1 label=stage5-drew-police die=d6 => 5
roll seed=sonnet1 label=stage5-blake-police die=d6 => 1
roll seed=sonnet1 label=stage5-casey-police die=d6 => 5
```

---

**Blake's Split the Lanes:** rolled 1, must beat Rocky Mountains traffic tier 2. Failure — fender-bender +0.5 hr.

**Police saves:**
- Frankie (Desert, bar 1): 4 + 1 (sedan) − 1 (speeding) = **4 → pass** ✓
- Alex (Desert, bar 1): 3 + 0 (L&S! active) − 1 (speeding) = **2 → pass** ✓
- Ellis (Desert, bar 1): 3 − 1 (supercar) − 1 (speeding) = **1 → pulled over** ✗ (tie loses)
- Drew (Rocky, bar 2): 5 + 0 = **5 → pass** ✓
- Blake (Rocky, bar 2): 1 − 1 (motorcycle) − 1 (speeding) = **−1 → pulled over** ✗
- Casey (Rocky, bar 2): 5 + 0 = **5 → pass** ✓

Ellis and Blake pulled over. Reactions:

---

**Ellis — Gun It (Reaction)**
Speeding on a Highway stage (Southwest Desert is Highway) ✓. **1 previous failed Gun It** — if this one fails too: +1 hr repair + **+1 hr** stacking = **+2 hr** total. Roll >2 for clean getaway.

> Use Gun It? (yes / no)

**User:**

yes

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-ellis-gun-it 2>&1
```

```
roll seed=sonnet1 label=stage5-ellis-gun-it die=d6 => 5
5
```

```
roll seed=sonnet1 label=stage5-ellis-gun-it die=d6 => 5
```

5 > 2 → **clean getaway!** Ellis vanishes into the desert heat haze. No Pull-Over Penalty.

---

**Blake — Double Down (Reaction)**
Pulled over in the Rockies while speeding. Roll even → clean escape, no Pull-Over Penalty, and Split the Lanes **retroactively succeeds** (Traffic Penalty erased). Roll odd → **jail** (DNF).

> Use Double Down? (yes / no)

**User:**

yes

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage5-blake-double-down 2>&1
```

```
roll seed=sonnet1 label=stage5-blake-double-down die=d6 => 1
1
```

```
roll seed=sonnet1 label=stage5-blake-double-down die=d6 => 1
```

1 is **odd** → **Jail.** Blake's bike roars, the trooper draws, and it's over. Blake is out of the rally.

All reactions resolved. Applying mechanics.

---

**Resolution — Stage 5: The Detour**

Cross-check field-keyed effects: one ambulance, no Somethin's Up. Blake is now jailed — no Loud Pipes to check. No field-keyed effects.

Cross-check consequence-revoked benefits:
- **Ellis** — Gun It succeeded, escaped police. Need for Speed speeding benefit kept.
- **Blake** — Double Down fired (odd). Jail — Blake is out. No further math needed for Blake.

**Southwest Desert racers** (Base Stage Time: 3 hr, Highway, Light traffic, no grade/bank):

**Frankie:** speed, pass police.
- Base: 3.0 hr
- Highway: −1.0 hr (sedan)
- Weather: 0
- Traffic Penalty: 0 (Light)
- Speeding Bonus: −0.5 hr
- Pull-Over Penalty: 0
- **Stage total: 1.5 hr → Running total: 7.0 + 1.5 = 8.5 hr**

**Alex:** speed, Lights & Sirens!, pass police.
- Base: 3.0 hr
- Roads (Highway, no grade, no bank): 0
- Weather: 0
- Traffic Penalty: 0 (Light — L&S! has nothing to erase)
- Speeding Bonus: −0.5 hr
- Lights & Sirens! effect: −1.0 hr
- Pull-Over Penalty: 0
- **Stage total: 1.5 hr → Running total: 7.0 + 1.5 = 8.5 hr**

**Ellis:** speed, Gun It succeeded (no Pull-Over Penalty).
- Base: 3.0 hr
- Highway: −0.5 hr (supercar)
- Weather: 0
- Traffic Penalty: 0 (Light)
- Need for Speed: −1.0 hr
- Gun It repair: 0 (clean getaway)
- Pull-Over Penalty: 0
- **Stage total: 1.5 hr → Running total: 8.5 + 1.5 = 10.0 hr**

**Rocky Mountains racers** (Base Stage Time: 2 hr, Highway, Medium traffic, Grade: high, Bank: high):

**Drew:** cruise, pass police.
- Base: 2.0 hr
- Highway: +0.5 hr (SUV gas)
- Medium/high-grade roads: −0.5 hr (grade high ✓)
- High-bank roads: +0.5 hr (bank high ✓)
- Weather: 0
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: 0
- Pull-Over Penalty: 0
- **Stage total: 3.0 hr → Running total: 10.5 + 3.0 = 13.5 hr**

**Casey:** cruise, pass police.
- Base: 2.0 hr
- Highway: +0.5 hr (4x4 gas)
- High-bank roads: +0.5 hr (bank high ✓)
- Weather: 0
- Traffic Penalty (Medium, not erased): +0.5 hr
- Speeding Bonus: 0
- Pull-Over Penalty: 0
- **Stage total: 3.5 hr → Running total: 14.5 + 3.5 = 18.0 hr**

**Blake:** jailed. Did Not Finish.

---

**State after Stage 5** (sorted lowest hours first):

| Racer | Vehicle | Total Hours | Status |
|-------|---------|-------------|--------|
| Frankie | 4-door Sedan | 8.5 | Racing |
| Alex | Ambulance | 8.5 | Racing |
| Ellis | 2-door Supercar | 10.0 | Racing |
| Drew | SUV | 13.5 | Racing |
| Casey | 4x4 | 18.0 | Racing |
| Blake | Motorcycle | — | **Jailed** |

End check: final slot not yet reached. Turn order for Stage 6: Frankie, Alex (tied 8.5, setup order), Ellis, Drew, Casey.

---

## Round 6: California Dreamin'

**Announcement.** Stage Weather hook, NOAA source: 11 PM PDT 6/16 Redondo Beach → Patchy Fog, 64°F, 0% precip → **Clear and mild** (fog is not precipitation, not inclement, not hot; closest row is Clear and mild, shortest counts-as list). No weather effects trigger. Standard time: Base 2 hr + Traffic Penalty 0.5 hr (Heavy traffic) = **2.5 hr**. Police tier: **Heavy (threshold 3)**.

This is the final stage. Five racers on the road — Blake is out. Every decision here is the last one.

---

### Frankie's Brief — 4-door Sedan

**Standing:** 8.5 hr | Racing

**Applicable effects:**
- Inclement weather: +0.5 hr (Clear and mild — no effect)
- High-grade roads: 0 (Grade: none)
- High traffic: **+0.5 hr** (Heavy traffic ✓ — passive applies!)
- Police save: **+1**
- Highway stages: −1 hr (Urban stage — no effect)
- **Blend In** *(Reaction)* — Heavy traffic ✓ — available if pulled over. +1 to re-roll, pass = no penalty, fail = penalty + additional +0.5 hr.

**Traffic:** Heavy → +0.5 hr standard Traffic Penalty + **+0.5 hr passive** = +1.0 hr total if not erased.

**Police bar:** 3 (Heavy). Baseline +1. Speeding −1. Net: 0 when speeding — need roll > 3, i.e., ≥ 4.

**Decision:** Cruise or speed?

`Frankie: <cruise|speed>, police <roll>`

**User:**

speed

`Frankie: speed, police [pending]`

Noted. Moving to Alex.

---

### Alex's Brief — Ambulance

**Standing:** 8.5 hr | Racing

**Applicable effects:**
- Medium/high-grade roads: 0 (Grade: none)
- Medium/high-bank roads: 0 (Bank: none)
- Police save (lights OFF): **+1**
- Traffic: Heavy → +0.5 hr unless erased
- **Lights & Sirens!** *(Action)* — −1 hr, erases Traffic Penalty. Lights-OFF police bonus lost if used.
- **Somethin's Up** *(Passive)* — No other ambulances. No effect.
- **You See, Officer...** *(Passive)* — +0.5 hr extra if pulled over.

**Weather:** Clear and mild — no effects.

With L&S! + speed: 2 − 1 (L&S!) − 0.5 (speed) = **0.5 hr**. Risky police position (no +1 bonus, −1 for speeding = need roll > 3, ≥ 4), but huge time save.
Cruise + L&S!: 2 − 1 = **1.0 hr**. Police: need roll > 3, ≥ 4 still (speeding gone but lights-OFF bonus also gone).
Cruise no abilities: 2 + 0.5 (traffic) = **2.5 hr**. Police: roll + 1 > 3, need ≥ 3.

**Police bar:** 3 (Heavy).

**Decision:** Cruise or speed? Use Lights & Sirens?

`Alex: <cruise|speed>[, Lights & Sirens!], police <roll>`

**User:**

speed, lights & sirens

`Alex: speed, Lights & Sirens!, police [pending]`

Noted. Moving to Ellis.

---

### Ellis's Brief — 2-door Supercar

**Standing:** 10.0 hr | Racing

**Applicable effects:**
- Police save: **−1**
- Highway stages: −0.5 hr (Urban stage — no effect)
- Any banked road: −0.5 hr (Bank: none — no effect)
- Weather precipitation: +0.5 hr (Clear and mild — no effect)
- Traffic: Heavy → +0.5 hr unless erased
- **Need for Speed** *(Passive)* — Speeding subtracts **1 hr** instead of 0.5 hr.
- **Gun It** *(Reaction)* — Requires speeding on a **Highway** stage. This is Urban — **unavailable**.

**Police bar:** 3 (Heavy). Baseline **−1**. Speeding −1 more. Need roll > 3 modified: cruising needs ≥ 5; speeding needs ≥ 6 (only a natural 6 survives).

Need for Speed saves 1 hr but police save becomes nearly impossible. No Gun It escape available on Urban.

**Decision:** Cruise or speed?

`Ellis: <cruise|speed>, police <roll>`

**User:**

speed

`Ellis: speed, police [pending]`

Noted. Moving to Drew.

---

### Drew's Brief — SUV

**Standing:** 13.5 hr | Racing

**Applicable effects:**
- Urban stages: **−0.5 hr** (Urban ✓ — everyone yields)
- Highway stages: +0.5 hr (Urban — no effect)
- Medium/high-grade roads: −0.5 hr (Grade: none — no effect)
- High-bank roads: +0.5 hr (Bank: none — no effect)
- Traffic: Heavy → +0.5 hr unless erased
- No abilities.

**Police bar:** 3 (Heavy). No baseline modifier. Speeding −1. Cruising: need roll > 3, ≥ 4. Speeding: need roll > 3 with −1, ≥ 5.

**Decision:** Cruise or speed?

`Drew: <cruise|speed>, police <roll>`

**User:**

cruise

`Drew: cruise, police [pending]`

Noted. Moving to Casey.

---

### Casey's Brief — 4x4

**Standing:** 18.0 hr | Racing

**Applicable effects:**
- Inclement weather: negate up to 1 hr weather penalties (Clear and mild — no effect)
- Highway stages: +0.5 hr (Urban — no effect)
- High-bank roads: +0.5 hr (Bank: none — no effect)
- Traffic: Heavy → +0.5 hr unless erased
- **Built for This** *(Action, Suspect)* — Roll to erase Traffic Penalty (beat tier 3). Fail: +0.5 hr fender-bender. Suspect: −1 police save.
- **Cut Corners** *(Action, Suspect)* — **Urban stage — unavailable.**

**Police bar:** 3 (Heavy). No baseline modifier. Speeding −1, Built for This −1 each if used. Cruising, no abilities: need roll > 3, ≥ 4.

Casey is already far behind — catching up requires time savings and a clean police pass.

**Decision:** Cruise or speed? Use Built for This?

`Casey: <cruise|speed>[, Built for This <roll>], police <roll>`

**User:**

cruise

`Casey: cruise, police [pending]`

All five declarations in. Declarations phase complete.

---

**Declarations (Stage 6 — California Dreamin'):**
- `Frankie: speed, police [pending]`
- `Alex: speed, Lights & Sirens!, police [pending]`
- `Ellis: speed, police [pending]`
- `Drew: cruise, police [pending]`
- `Casey: cruise, police [pending]`

Rolling all five police saves now.

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage6-frankie-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage6-alex-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage6-ellis-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage6-drew-police 2>&1 && \
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage6-casey-police 2>&1
```

```
roll seed=sonnet1 label=stage6-frankie-police die=d6 => 3
3
roll seed=sonnet1 label=stage6-alex-police die=d6 => 1
1
roll seed=sonnet1 label=stage6-ellis-police die=d6 => 6
6
roll seed=sonnet1 label=stage6-drew-police die=d6 => 3
3
... (2 more lines truncated)
```

**Rolls:**

```
roll seed=sonnet1 label=stage6-frankie-police die=d6 => 3
roll seed=sonnet1 label=stage6-alex-police die=d6 => 1
roll seed=sonnet1 label=stage6-ellis-police die=d6 => 6
roll seed=sonnet1 label=stage6-drew-police die=d6 => 3
roll seed=sonnet1 label=stage6-casey-police die=d6 => 6
```

---

**Police saves** (must beat threshold 3):
- Frankie: 3 + 1 (sedan) − 1 (speeding) = **3 → pulled over** ✗ (tie loses)
- Alex: 1 + 0 (L&S! active) − 1 (speeding) = **0 → pulled over** ✗
- Ellis: 6 − 1 (supercar) − 1 (speeding) = **4 → pass** ✓
- Drew: 3 + 0 = **3 → pulled over** ✗ (tie loses)
- Casey: 6 + 0 = **6 → pass** ✓

Frankie, Alex, and Drew pulled over. Reactions:

**Alex — You See, Officer... is a Passive, not a Reaction.** No choice — it applies automatically (+0.5 hr extra on top of Pull-Over Penalty). Pull-over stands.

**Drew — no Reaction ability.** Pull-over stands. Drew was cruising — no Suspect benefits to revoke.

---

**Frankie — Blend In (Reaction)**
Heavy traffic ✓. Re-roll with +1 (sedan) − 1 (speeding) + 1 (Blend In) = **net +1** on re-roll. Need roll > 2 (≥ 3) to beat bar 3. Pass → no Pull-Over Penalty. Fail → Pull-Over Penalty (+1 hr) + **additional +0.5 hr**.

> Use Blend In? (yes / no)

**User:**

yes

```sh
sh /mnt/v/users/Austin/Documents/git/lite-rpg/skills/gm/scripts/roll.sh --seed sonnet1 --label stage6-frankie-blend-in 2>&1
```

```
roll seed=sonnet1 label=stage6-frankie-blend-in die=d6 => 4
4
```

```
roll seed=sonnet1 label=stage6-frankie-blend-in die=d6 => 4
```

4 + 1 = **5 → beats 3** ✓ — Frankie blends into the LA fog traffic. No Pull-Over Penalty. That sedan is invisible.

All reactions resolved. Applying mechanics.

---

**Resolution — Stage 6: California Dreamin'**

Cross-check field-keyed effects: one ambulance, no Somethin's Up. Blake jailed — no Loud Pipes. No field-keyed effects.

Cross-check consequence-revoked benefits:
- **Alex** — speeding (Suspect), pulled over (declined/no Reaction). Speeding Bonus revoked. L&S! benefit (−1 hr) is also a Suspect? No — Lights & Sirens! is not marked Suspect. Only the Speeding Bonus is lost. L&S! benefit stands... 

Wait, re-reading the pull-over rule: "any Suspect ability they used this stage loses its benefits too." Speeding is Suspect. L&S! is an Action but is NOT marked Suspect. So only the Speeding Bonus (−0.5 hr) is revoked. The Lights & Sirens! −1 hr and traffic erasure stand.

- **Drew** — cruising, no abilities, no Suspect actions. Nothing to revoke.
- **Frankie** — Blend In succeeded, not pulled over. Speeding benefit kept.

**Frankie:** speed, Blend In succeeded.
- Base: 2.0 hr
- Roads (Urban, no grade, no bank): 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Passive heavy-traffic penalty: +0.5 hr
- Speeding Bonus: −0.5 hr
- Pull-Over Penalty: 0 (Blend In)
- **Stage total: 2.5 hr → Running total: 8.5 + 2.5 = 11.0 hr**

**Alex:** speed, Lights & Sirens!, pulled over. Speeding Bonus revoked (Suspect). L&S! benefit kept (not Suspect).
- Base: 2.0 hr
- Roads: 0
- Weather: 0
- Traffic Penalty: **erased** (Lights & Sirens! — not Suspect, benefit kept)
- Speeding Bonus: **revoked** → 0
- Lights & Sirens! effect: −1.0 hr (kept)
- Pull-Over Penalty: +1.0 hr
- You See, Officer... (Passive): +0.5 hr
- **Stage total: 2.5 hr → Running total: 8.5 + 2.5 = 11.0 hr**

**Ellis:** speed, pass police.
- Base: 2.0 hr
- Roads (Urban, not highway): 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Need for Speed: −1.0 hr
- Pull-Over Penalty: 0
- **Stage total: 1.5 hr → Running total: 10.0 + 1.5 = 11.5 hr**

**Drew:** cruise, pulled over, no Suspect actions.
- Base: 2.0 hr
- Urban: −0.5 hr (SUV passive)
- Roads: 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Speeding Bonus: 0
- Pull-Over Penalty: +1.0 hr
- **Stage total: 3.0 hr → Running total: 13.5 + 3.0 = 16.5 hr**

**Casey:** cruise, pass police.
- Base: 2.0 hr
- Roads (Urban, not highway, no grade, no bank): 0
- Weather: 0
- Traffic Penalty (Heavy, not erased): +0.5 hr
- Speeding Bonus: 0
- Pull-Over Penalty: 0
- **Stage total: 2.5 hr → Running total: 18.0 + 2.5 = 20.5 hr**

---

End check: all racers have completed the final slot's stage (Blake is jailed). **The race is over.**

---

## Standings

| Place | Racer | Vehicle | Total Hours |
|-------|-------|---------|-------------|
| 🏁 1st (tie) | **Frankie** | 4-door Sedan | **11.0 hr** |
| 🏁 1st (tie) | **Alex** | Ambulance | **11.0 hr** |
| 3rd | Ellis | 2-door Supercar | 11.5 hr |
| 4th | Drew | SUV | 16.5 hr |
| 5th | Casey | 4x4 | 20.5 hr |
| DNF | Blake | Motorcycle | — (Jailed, Stage 5) |

---

**The beige sedan and the screaming ambulance hit Redondo Beach dead even at 11.0 hours.** Frankie blended into every crowd all the way to the Pacific; Alex ran lights and sirens across half the country and talked their way through the other half. Ellis pushed the supercar hard and nearly kept up — 30 minutes back at 11.5 hr.

Blake made it through four stages of fender-benders before the Double Down on the Rockies came up odd.

**Session log saved to:** `transcripts/cannonball-rally-20260615-140000.md`
