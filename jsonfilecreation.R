install.packages("rsconnect")

rsconnect::writeManifest(
  appPrimaryDoc = "Data_Viz_Epi.qmd",
  appMode = "quarto-static"
)
