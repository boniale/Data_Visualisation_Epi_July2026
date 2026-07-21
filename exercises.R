# exercises.R — companion hands-on tasks for the Data Visualisation session
# Open in RStudio. Each block is a self-contained exercise; solutions are folded
# at the bottom (don't peek too early).

library(tidyverse)
library(plotly)

# =====================================================================
# EX 1 — Geometry swap (grammar of graphics)
# =====================================================================
set.seed(1)
d <- tibble(
  arm = rep(c("Intervention", "Control"), each = 60),
  outcome = c(rnorm(60, 4.2, 1.1), rnorm(60, 4.8, 1.2))
)
# TODO: keep the SAME aes mapping, swap geom_boxplot() -> geom_violin().
# What does the violin reveal? What does it still hide?
ggplot(d, aes(arm, outcome, fill = arm)) +
  geom_boxplot()      # <- change me


# =====================================================================
# EX 2 — Forest plot heterogeneity by latitude
# =====================================================================
# BCG vaccine vs TB trials (Colditz 1994). Latitude added.
bcg <- tribble(
  ~trial,                 ~lat, ~tpos, ~tneg,  ~cpos, ~cneg,
  "Stein & Aronson",       44,  180,  1361,  372,  1079,
  "Ferguson & Simes",      55,   17,  1699,   65,  1600,
  "Rosenthal et al",       42,    3,   227,   11,   228,
  "Hart & Sutherland",     52,   62, 13536,  248, 12619,
  "Frimodt-Moller et al",  13,   33,  5036,   47,  5761,
  "Coetzee & Berjak",      27,   28,  7470,   45,  7232,
  "Rosenthal et al (2)",   42,    8,  2537,   29,  2243,
  "Comstock et al",        18,  186, 88391,  141, 88401
) |>
  mutate(
    rr = (tpos/(tpos+tneg)) / (cpos/(cpos+cneg)),
    se = sqrt(1/tpos - 1/(tpos+tneg) + 1/cpos - 1/(cpos+cneg)),
    lo = exp(log(rr) - 1.96*se),
    hi = exp(log(rr) + 1.96*se)
  )
# TODO: forest plot with point COLOUR mapped to lat. Do high-latitude
# trials show stronger protection (RR further below 1)?


# =====================================================================
# EX 3 — Fix the misleading chart (honesty checklist)
# =====================================================================
flu <- tibble(
  region = c("North", "South", "East", "West"),
  cases  = c(980, 1020, 1005, 1040),     # raw COUNTS
  pop    = c(1.2e6, 3.0e6, 2.1e6, 0.6e6) # very different denominators
)
# A deliberately misleading version: counts, truncated y-axis, rainbow.
ggplot(flu, aes(region, cases, fill = region)) +
  geom_col() +
  scale_fill_manual(values = rainbow(4)) +
  coord_cartesian(ylim = c(950, 1050)) +   # truncated!
  labs(title = "Cases by region")
# TODO: (a) plot the RATE per 100k, (b) start y at 0,
#       (c) use a colour-blind-safe scale. How does the conclusion change?


# =====================================================================
# SOLUTIONS (scroll down only when ready)
# =====================================================================
if (FALSE) {

  ## EX 1
  ggplot(d, aes(arm, outcome, fill = arm)) + geom_violin(alpha = .7)
  # Violin shows the full distribution shape; still hides individual n
  # unless you add geom_jitter().

  ## EX 2
  library(forcats)
  bcg |>
    mutate(trial = fct_reorder(trial, rr)) |>
    ggplot(aes(rr, trial, colour = lat)) +
    geom_vline(xintercept = 1, linetype = 2) +
    geom_pointrange(aes(xmin = lo, xmax = hi)) +
    scale_x_log10() + scale_colour_viridis_c(name = "Latitude") +
    labs(x = "Risk ratio (log scale)", y = NULL)
  # Yes: higher-latitude trials cluster at lower RR (stronger protection).

  ## EX 3
  flu |>
    mutate(rate = cases / pop * 1e5) |>
    ggplot(aes(reorder(region, rate), rate, fill = rate)) +
    geom_col() + scale_fill_viridis_c() +
    expand_limits(y = 0) +
    labs(x = NULL, y = "Cases per 100,000")
  # West flips from "lowest" to BY FAR the highest once you use rates.
}
