# deploy.R — one-shot prep for publishing this deck to Posit Connect Cloud.
#
# Connect Cloud rebuilds the R environment from a manifest.json (it does NOT
# read your local library or an renv.lock). This script installs every package
# the deck needs, then writes that manifest so plotly, leaflet, DT, sf, etc.
# are declared for the build.
#
# HOW TO RUN — once, in a FRESH R session:
#   1. Make THIS folder the working directory (open it as an RStudio project,
#      or:  setwd("<path to this 01_DataViz folder>")  ).
#   2. source("deploy.R")
#   3. Commit the whole folder — INCLUDING the new manifest.json — to GitHub.
#   4. In Posit Connect Cloud, publish from that repo.

source("setup.R")   # installs all deck packages + pins rlang 1.3.0

if (!requireNamespace("rsconnect", quietly = TRUE)) install.packages("rsconnect")

rsconnect::writeManifest(appDir = ".")

message("\nmanifest.json written in: ", normalizePath("."),
        "\nCommit this folder (with manifest.json) to GitHub, then deploy on Connect Cloud.")
