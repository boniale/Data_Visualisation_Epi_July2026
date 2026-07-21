# setup.R — install every package used by the Data Visualisation deck.
# Run ONCE before rendering:  source("setup.R")

pkgs <- c(
  "tidyverse", "plotly", "DT", "leaflet", "sf",
  "viridis", "scales", "patchwork", "broom", "lubridate", "forcats",
  "outbreaks", "survival", "rnaturalearth", "rnaturalearthdata"
)

to_install <- setdiff(pkgs, rownames(installed.packages()))
if (length(to_install)) {
  message("Installing: ", paste(to_install, collapse = ", "))
  install.packages(to_install)
}
invisible(lapply(pkgs, require, character.only = TRUE))
message("Data Visualisation deck — all packages ready.")
