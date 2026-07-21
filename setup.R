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

# Pin rlang to 1.3.0 (Posit Connect Cloud publishing requires rlang >= 1.3.0).
# IMPORTANT: rlang cannot be upgraded while it is loaded in a session. If rlang
# is already attached, RESTART R (Session > Restart R) and run this FIRST, before
# loading tidyverse / rsconnect, then publish.
rlang_target <- "1.3.0"
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
if (!requireNamespace("rlang", quietly = TRUE) ||
    as.character(packageVersion("rlang")) != rlang_target) {
  remotes::install_version("rlang", version = rlang_target, upgrade = "never")
}

invisible(lapply(c(pkgs, "rlang"), require, character.only = TRUE))
message("Data Visualisation deck — all packages ready (rlang ",
        as.character(packageVersion("rlang")), ").")
