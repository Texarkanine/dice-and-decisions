# Cannonball Rally

**Players:** 2–6
**Time:** about an hour
**Randomizer:** one d6 (a single shared die is fine)
**Materials:** pencil and paper for the scoreboard

An illegal coast-to-coast street race from New York City to Redondo Beach. Pick your machine — ambulance, motorcycle, supercar, or beige sedan — and burn across six stages of traffic, weather, and the long arm of the law. Lowest total hours wins; jail means you never finish at all.

## Core Procedure

### Setup

1. **GM** draws the scoreboard: one row per racer, with columns for vehicle, total hours (starting at 0), and status (racing / jailed).
2. **Each player** picks a vehicle from the Vehicles table. Choice is free and duplicates are allowed — duplicate vehicles have their own interactions (see the Abilities table) and are part of the fun.
3. **Table** agrees on a turn order for the first stage (default: clockwise from the GM). From the second stage on, turn order comes from the scoreboard (see the Round).
4. **Table** decides how weather resolves: via the *Stage Weather* hook (real forecasts) or by its fallback rolls. If using the hook, note the race's start date and time.

### Round

**A round is** one stage of the rally. The race runs the stages of the Route table in order; at the Detour each racer drives the detour stage they choose.

1. **GM** announces the stage: its name, its traffic and police tiers, its road type, grade, and bank (all from the Route table), and today's weather — resolved via the *Stage Weather* hook, or by its fallback. State the standard time: *Base Stage Time*, plus the *Traffic Penalty* if the stage's traffic applies (see Resolution).
2. **Each player**, in order of lowest total hours (first stage: setup order; tied racers act in setup order), declares their plan: cruise or speed, which detour stage they take if this is the Detour, and any vehicle Abilities they use. **GM** reminds each racer of their vehicle's applicable modifiers from the Vehicle Modifiers table before they decide.
3. **Each player** resolves their declared ability rolls (see Resolution), then rolls their police check against the stage's police bar.
4. **GM** computes each racer's stage time (see Resolution for the modifier order), adds it to their total hours, and restates the full scoreboard: each racer's vehicle, total hours, and status, lowest hours first.
5. **GM** checks the end condition: if every racer has completed the final Route stage or is jailed, the race is over — go to Scoring & End State. Otherwise begin the next stage.

## Resolution

- **Randomizer operation:** one d6. Players roll only when an action or reaction calls for a roll — with one exception: **every racer rolls the police check every stage** (step 3 of the Round). The GM never rolls for the map: stage conditions are fixed thresholds, and the only GM roll is the *Stage Weather* fallback when the hook is offline. A racer with nothing to contend with simply says "I cruise" and takes their computed time, rolling nothing but the police check.
- **Threshold checks:** a roll succeeds only if it **beats** (strictly exceeds) its threshold. Ties lose. Tier thresholds come from the Obstacle Tiers table; since you cannot roll a 0, no check ever has a zero chance of failure.
- **The police check:** the whole Cannonball is illegal — police scrutiny is passive and constant. Each racer's police bar for a stage is the stage's police tier value, plus *Suspicion Step* for **each** suspect thing they did this stage: speeding, and any ability marked Suspect in the Abilities table. Vehicle police modifiers (Vehicle Modifiers table) apply to the racer's roll. Beat the bar to fly under the radar; fail and you are pulled over: add the *Pull-Over Penalty* to your stage time, and any penalties your actions had erased this stage apply after all — you got caught doing it. Being pulled over is detention, not jail: your buddy bails you out and you race on.
- **Speeding:** declared with your plan in step 2. Subtract the *Speeding Bonus* from your stage time. Speeding is suspect (it raises your police bar by *Suspicion Step*).
- **Traffic:** if the stage's traffic tier is Medium or Heavy, every racer adds the *Traffic Penalty* to their stage time unless they get around it. Getting around traffic takes an ability that says it can (Abilities table) and — where that ability calls for a roll — beating the stage's traffic tier: the heavier the traffic, the harder it is to get around, but success erases the *Traffic Penalty* entirely.
- **Weather:** weather has no penalty of its own. It matters only where a vehicle's row in the Vehicle Modifiers table names it (the Weather table's *Counts as* column says which conditions qualify), and through GM ambient rulings (see GM Guidance).
- **Stage time and modifier order:** a racer's stage time is computed additively, in this order: *Base Stage Time*; vehicle road modifiers (type, grade, bank); vehicle weather modifiers; *Traffic Penalty* (if it applies and was not erased); *Speeding Bonus* (if speeding); ability time effects; *Pull-Over Penalty* and other police consequences. Addition makes the order cosmetic; it is fixed so totals are always read out the same way.
- **Bounds:** stage time is not clamped — there is no minimum or maximum.
- **Ties during play:** rolls against thresholds lose ties (above). Racers' rolls are never compared against each other. Racers tied on total hours act in setup order.
- **Simultaneity:** declarations are sequential — the leader declares first, so trailing racers see the leader's plan and may react to it. Stage times then resolve independently: one racer's roll or time never changes another's, with two exceptions written on the cards — colluding motorcycles (Biker Gang) share one outcome, and same-vehicle passives (Somethin's Up, Loud Pipes) key off other racers' vehicles and actions.

## Scoring & End State

- **End:** the race ends when every racer has completed the final Route stage or is jailed.
- **Score:** each racer's score is their total hours, coast to coast. Lower is better.
- **Winner:** the lowest total hours wins.
- **Ties:** tied racers tie — they share the position. There is no run-off.
- **Standings:** the GM reads the final scoreboard lowest hours first. Jailed racers are off the leaderboard entirely: they are listed last, as Did Not Finish, with no hours.

## Parameters

| Parameter | Default | Meaning |
| --- | --- | --- |
| Base Stage Time | 2 hr | Baseline hours per stage before modifiers |
| Speeding Bonus | 0.5 hr | Hours subtracted from stage time when speeding |
| Traffic Penalty | 0.5 hr | Hours added when stage traffic applies and is not gotten around |
| Pull-Over Penalty | 1 hr | Hours added when pulled over by police |
| Suspicion Step | 1 | Police-bar increase per suspect action in a stage |
| Forecast Offset | 2 hr | Hours of forecast look-ahead per stage order for the *Stage Weather* hook |
| Ambient Magnitude | 0.5 hr | Standard size of a GM ambient ruling (weather flavor, construction) |
| Risk Magnitude | 1 hr | Standard size of a player-initiated risk's payoff or cost |

## Content Tables

### Route

The rally's stages in racing order. *Stage* is driven in *Order*; at order 5 (the Detour) each racer chooses **one** of the two stages. *Weather City* feeds the *Stage Weather* hook; *Traffic* and *Police* are tiers from the Obstacle Tiers table; *Roads*, *Grade*, and *Bank* describe the road and matter where the Vehicle Modifiers table names them.

| Order | Stage | Weather City | Traffic | Police | Roads | Grade | Bank |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Escape from New York | New York | Heavy | Heavy | Urban | none | none |
| 2 | Appalachia | Pittsburgh | Medium | Medium | Rural | medium | medium |
| 3 | Route 66 | Springfield | Medium | Medium | Highway | none | none |
| 4 | Midwest | Tulsa | Light | Light | Highway | none | none |
| 5 | Detour: Rocky Mountains | Denver | Medium | Medium | Highway | high | high |
| 5 | Detour: Southwest Desert | Flagstaff | Light | Light | Highway | none | none |
| 6 | California Dreamin' | Redondo Beach | Heavy | Heavy | Urban | none | none |

### Obstacle Tiers

Each row maps a tier name to the threshold value a roll must beat. Tiers describe a stage's traffic and police (Route table) and any ad-hoc obstacle the GM introduces.

| Tier | Threshold |
| --- | --- |
| Light | 1 |
| Medium | 2 |
| Heavy | 3 |

### Weather

Each row is one kind of racing weather. *Roll* is used by the *Stage Weather* fallback; *Weather* names the day; *Counts as* lists the conditions the Vehicle Modifiers table keys off (a dash means none).

| Roll | Weather | Counts as |
| --- | --- | --- |
| 1–2 | Clear and mild | — |
| 3 | Heat wave | hot |
| 4 | Rain | precipitation, inclement |
| 5 | Storm | precipitation, inclement |
| 6 | Snow and ice | precipitation, ice, inclement |

### Vehicles

Each row is one vehicle a racer may pick at setup. Pick freely; duplicates allowed.

| Vehicle | Pitch |
| --- | --- |
| Ambulance | A large, heavy box of a vehicle. Sirens and lights still work, but you aren't conducting official EMT business! |
| Motorcycle | Two wheels and the rumble of freedom! Light, agile, fuel-efficient and exposed. What a thrill! |
| 4x4 | Full-time four-wheel drive with sturdy bumpers and a lift kit. Road optional! |
| SUV | A near bird's-eye view from this luxurious 8-seater boat of a car. A V8 guzzles gas to make more power than you'll ever use… legally! |
| 2-door Supercar | Low, aerodynamic, brightly painted and loud. Easily six figures — it screams "look at me" and "catch me if you can!" |
| 4-door Sedan | Average height, average engine, paint in every shade of black, white, gray — maybe beige. The base model, and it's everywhere. |

### Vehicle Modifiers

Each row is one standing modifier. *Applies to* names the condition (a road property, a weather category from the Weather table's *Counts as* column, or police rolls); *Effect* is what happens — hours add to stage time, roll modifiers add to the named roll, and signed values always carry their sign.

| Vehicle | Applies to | Effect |
| --- | --- | --- |
| Ambulance | Police rolls, while Lights & Sirens are OFF | +1 to the roll |
| Ambulance | High-grade roads | +1 hr |
| Ambulance | High-bank roads | +1 hr |
| Motorcycle | Precipitation or ice | +0.5 hr |
| Motorcycle | Traffic penalties | Halved for you |
| Motorcycle | Police rolls | -1 to the roll |
| 4x4 | Inclement weather | Negate up to 1 hr of weather penalties (all-terrain tires) |
| 4x4 | Highway stages | +0.5 hr (stopping for gas) |
| 4x4 | High-bank roads | +0.5 hr |
| SUV | Urban stages | -0.5 hr (everyone yields to the behemoth) |
| SUV | Highway stages | +0.5 hr (stopping for gas) |
| SUV | Medium- or high-grade roads | -0.5 hr (actually using your power!) |
| SUV | High-bank roads | +0.5 hr |
| 2-door Supercar | Police rolls | -1 to the roll |
| 2-door Supercar | Highway stages | -0.5 hr |
| 2-door Supercar | Any banked road | -0.5 hr |
| 4-door Sedan | Inclement weather | +0.5 hr (not built for the rough stuff) |
| 4-door Sedan | Police rolls | +1 to the roll |
| 4-door Sedan | Highway stages | -1 hr (no gas stops) |

### Abilities

Each row is one vehicle ability. *Type* is Action (declared with your plan in step 2), Passive (always on), or Reaction (resolves at its trigger, separate from and ignoring the stage police bar). *Suspect* marks abilities that raise your police bar by *Suspicion Step*. *Effect* is applied exactly as written.

| Vehicle | Ability | Type | Suspect | Effect |
| --- | --- | --- | --- | --- |
| Ambulance | Lights & Sirens! | Action | Yes | Switch them on: everyone gets out of the way. -1 hr this stage, and the *Traffic Penalty* is erased without a roll. Your lights-OFF police bonus does not apply this stage. |
| Ambulance | Somethin's Up | Passive | — | -1 to each of your rolls for every additional ambulance in the stage. |
| Motorcycle | Split the Lanes | Action | No | Roll to get around traffic (beat the traffic tier). Success erases the *Traffic Penalty*; failure is a fender-bender: +0.5 hr instead of the *Traffic Penalty*. |
| Motorcycle | Hooliganism | Action | Yes | Roll to drive around any on-road obstacle (beat its tier). Success erases that obstacle's penalty. |
| Motorcycle | Biker Gang | Passive | — | Two or more motorcycles may collude and declare the same ability together; all succeed if at least one of them rolls a success. Cannot be combined with Double Down. |
| Motorcycle | Loud Pipes | Passive | — | -1 to your ability rolls if another motorcycle has already used an ability this stage. |
| Motorcycle | Double Down | Reaction | — | When pulled over, flee once they've walked to your bike: roll even to escape as if you were never caught — no *Pull-Over Penalty*, and anything you were doing succeeds. Roll odd and it's jail: you are out of the rally. |
| 4x4 | Built for This | Action | Yes | Roll to drive around traffic (beat the traffic tier). Success erases the *Traffic Penalty*. |
| 4x4 | Cut Corners | Action | Yes | On a Rural stage, cut across folks' land instead of sticking to the roads: -1 hr this stage. |
| 2-door Supercar | Gun It | Reaction | — | When police would pull you over while speeding on a Highway stage, outrun them: roll >2 for a clean getaway — no *Pull-Over Penalty*. Fail and you still escape the police, but +1 hr fixing the rare part that broke past 200 mph, plus +1 hr more for every previous failed Gun It this race. |
| 2-door Supercar | Need for Speed | Passive | — | When you speed, subtract 1 hr instead of the *Speeding Bonus*. |
| 4-door Sedan | Blend In | Reaction | — | When police would pull you over and the stage's traffic is Medium or Heavy, duck off the main road and act nonchalant: roll >1 to avoid the *Pull-Over Penalty* — there are so many cars like yours they'll probably miss you. |

## External Data Hooks

### Stage Weather

- **Source:** a real weather forecast for the stage's *Weather City* (Route table), looked up for the race's start time plus *Forecast Offset* per stage order (stage 1 uses the forecast one offset out, stage 2 two offsets out, and so on — the rally rolls across the country in something like real time).
- **Interpretation:** map the forecast to the closest *Weather* row of the Weather table (e.g. "partly cloudy" → Clear and mild; over 100 °F → Heat wave; any thunderstorm or severe warning → Storm; freezing precipitation → Snow and ice). When two rows fit, pick the one whose *Counts as* list is shorter.
- **Fallback:** roll 1d6 on the Weather table.

## Turn Report

One line per racer, typed by the scribe:

`<name>: <cruise|speed>[ via <detour>][, <ability>[ <n>]], police <p>[, <reaction> <m>]`

(`via <detour>` names the racer's chosen stage on the Detour round.
`<ability>[ <n>]` reports an Action ability and its roll where it has one — no-roll Actions like Lights & Sirens! appear without a number.
`<reaction> <m>` reports a Reaction triggered by the police check, and its roll.)

Examples:

- `Ana: cruise, police 5`
- `Ben: speed, police 2, Blend In 4`
- `Cy: cruise, Hooliganism 4, police 6`
- `Dee: speed via Desert, Lights & Sirens!, police 2`
- `Edd: speed, police 1, Double Down 3`

## GM Guidance

- One sentence of flavor per announcement at most; read every number in full.
- **Magnitude heuristic:** ambient and random effects are worth about *Ambient Magnitude*; player-initiated risks are worth about *Risk Magnitude*. Agency matters — a racer's choice should swing more than the scenery does.
- Weather beyond the Vehicle Modifiers table is yours to flavor: a heat wave might cost an overheating sedan an *Ambient Magnitude* break, a hurricane season might rate a Storm — say the ruling out loud and keep it at ambient size. The Weather table's *Counts as* column is the only hard mechanism.
- Ad-hoc obstacles (construction, a parade) are fine: assign a tier from the Obstacle Tiers table, charge about *Ambient Magnitude* to sit through it, and let get-around abilities roll against it.
- If a racer stalls on declarations, offer the safe default: cruise, no abilities.
- Remind racers of their vehicle's modifiers *before* they declare — the SUV should know the highway costs it gas before choosing to speed.
- For anything these rules don't cover, make the cheapest ruling that keeps the race moving, say it out loud, and note it for the game's author.
