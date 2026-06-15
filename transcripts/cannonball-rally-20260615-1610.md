# Cannonball Rally

**Date:** 2026-06-15 16:10
**Seed:** composer1
**Dice:** script
**Seats:**
- Vince Nitro — player, Ambulance
- Ruby Lane — player, 4-door Sedan
- Diesel McQueen — player, 4x4
- Caprice Webb — player, SUV

**Weather source:** Open-Meteo forecast (weather MCP unavailable); race start 2026-06-15 16:00, +6 hr offset per stage slot.

**Vehicle rolls:**

```
roll seed=composer1 label=setup-vince-vehicle die=d6 => 1
roll seed=composer1 label=setup-ruby-vehicle die=d6 => 6
roll seed=composer1 label=setup-diesel-vehicle die=d6 => 3
roll seed=composer1 label=setup-caprice-vehicle die=d6 => 3
roll seed=composer1 label=setup-caprice-vehicle-reroll die=d6 => 6
roll seed=composer1 label=setup-caprice-vehicle-reroll2 die=d6 => 4
```

## Round 1: Escape from New York

**Announcement.** Slot 1 — *Escape from New York*. Urban roads, no grade, no bank. Traffic **Heavy** (threshold 2), Police **Heavy** (threshold 3). Base stage time **2 hr**; traffic penalty **+0.5 hr** applies unless erased. Weather via Open-Meteo for New York at race start +6 hr (2026-06-15 22:00): 66 °F, no precipitation — mapped to **Clear and mild** (no weather categories).

**State.**

| Racer | Vehicle | Total Hours | Status |
| --- | --- | --- | --- |
| Vince Nitro | Ambulance | 0 | racing |
| Ruby Lane | 4-door Sedan | 0 | racing |
| Diesel McQueen | 4x4 | 0 | racing |
| Caprice Webb | SUV | 0 | racing |

**Declarations.**

- `Vince: cruise, Lights & Sirens!`
- `Ruby: speed`
- `Diesel: cruise`
- `Caprice: cruise`

**Rolls.**

```
roll seed=composer1 label=escape-from-new-york-vince-police die=d6 => 6
roll seed=composer1 label=escape-from-new-york-ruby-police die=d6 => 2
roll seed=composer1 label=escape-from-new-york-diesel-police die=d6 => 4
roll seed=composer1 label=escape-from-new-york-caprice-police die=d6 => 5
```

**Reaction.** Ruby opts into Blend In (+1 police save on existing check; card specifies no new roll).

**Resolution.**

- Vince: 2 base − 1 Lights & Sirens = **1 hr**. Police 6, clear.
- Ruby: Blend In — police 2 + 1 save + 1 Blend In − 1 speeding = **3** vs bar 3, tie fails. 2 base − 0.5 urban + 0.5 high-traffic + 0.5 traffic + 1 pull-over + 0.5 Blend In fail = **4 hr** (speeding benefit revoked).
- Diesel: 2 base + 0.5 traffic = **2.5 hr**. Police 4, clear.
- Caprice: 2 base − 0.5 urban + 0.5 traffic = **2 hr**. Police 5, clear.

**State.**

| Racer | Vehicle | Total Hours | Status |
| --- | --- | --- | --- |
| Vince Nitro | Ambulance | 1 | racing |
| Caprice Webb | SUV | 2 | racing |
| Diesel McQueen | 4x4 | 2.5 | racing |
| Ruby Lane | 4-door Sedan | 4 | racing |

## Round 2: Appalachia

**Announcement.** Slot 2 — *Appalachia*. Rural roads, **medium grade**, **medium bank**. Traffic **Medium** (threshold >2), Police **Medium** (threshold >2). Base stage time **2 hr**; traffic penalty **+0.5 hr** unless erased. Weather via Open-Meteo for Pittsburgh at race start +12 hr (2026-06-16 04:00): 51 °F, dry — **Clear and mild**.

**State.**

| Racer | Vehicle | Total Hours | Status |
| --- | --- | --- | --- |
| Vince Nitro | Ambulance | 1 | racing |
| Caprice Webb | SUV | 2 | racing |
| Diesel McQueen | 4x4 | 2.5 | racing |
| Ruby Lane | 4-door Sedan | 4 | racing |
