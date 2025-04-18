#' Lance le jeu Takuzu
#'
#' @export

jouer <- function() {
  shiny::runApp(system.file("app", package = "Takuzu"))
}

