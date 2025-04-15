#' Lance le jeu Takuzu
#'
#' @export
jouer <- function() {
  library(shiny)
  library(shinyjs)
  library(bslib)

  source(system.file("R", "niveau.R", package = "Takuzu"), local = TRUE)
  source(system.file("R", "grille.R", package = "Takuzu"), local = TRUE)
  source(system.file("R", "verification.R", package = "Takuzu"), local = TRUE)

  runApp(system.file("R", "code.R", package = "Takuzu"))
}
