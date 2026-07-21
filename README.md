# Data Visualisation in Epidemiology

Standalone interactive Quarto (reveal.js) slides for the **IEA Early Career Epidemiologists Workshop 2026**, Abuja.

Presenter: **Dr. Boni Ale, MD, MSc, MPH** · Holo Global Health Research Institute

Built on the Holo template (`holo-theme.scss`, `logo.png`, footer `research.holohc.org`).

## Files

| File | Purpose |
|------|---------|
| `dataviz.qmd` | The slide deck (source). Render to HTML. |
| `holo-theme.scss` | Holo theme + callout-box styles (yourturn / predict / keyidea / optional). |
| `logo.png` | Holo logo (title + corner + closing slide). |
| `setup.R` | Installs every R package used. **Run once first.** |
| `exercises.R` | Companion hands-on tasks (with folded solutions). |

## Build

```r
source("setup.R")     # installs packages, once
```
```bash
quarto render dataviz.qmd     # or click Render in RStudio
```

Output `dataviz.html` opens in any browser; present full-screen (`F`). `cache: true` makes later renders fast.

## Contents (~45 min)

Principles (communication, audience–message–evidence, perception hierarchy, choosing a chart) → grammar of graphics → epicurve · forest · Kaplan–Meier · choropleth → colour & the honesty checklist.

Slides badged **APPENDIX** (orange) — onset-vs-report, the latitude forest exercise — are skip-if-behind bonus material.

## Presenter notes

- `S` speaker view · `F` fullscreen · `O` overview · `B` chalkboard.
- Live charts (plotly, leaflet) are **hover / zoom / drag** — demo that on the first epicurve.
- Coloured boxes cue the room: **orange = Your turn**, **green = Predict**, **blue = key idea**.

## Data sources (all open / built-in)

- `outbreaks::ebola_sim_clean` — simulated Ebola line list
- `survival::lung` — NCCTG lung cancer survival
- BCG vaccine vs TB trials (Colditz 1994) — embedded inline
- `rnaturalearth` — Africa geometries (incidence simulated for illustration)

No downloads, no credentials, fully reproducible.
