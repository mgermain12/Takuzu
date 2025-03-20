#' Création de niveau de difficulté
#' @param niveau Un caractère indiquant le niveau de difficulté. Doit être l'un des suivants :
#'   - `"facile"` (30 cases supprimées)
#'   - `"moyen"` (35 cases supprimées)
#'   - `"difficile"` (40 cases supprimées)
#'   - `"jour"` (45 cases supprimées)
#'
#' @return Un entier correspondant au nombre de cases à préremplir.
#' @export
#'
niveau <- function(x) {

  niveaux <- list("facile" = 30, "moyen" = 35, "difficile" = 40, "jour" = 45)
  nb_cases <- niveaux[[x]]

  return(nb_cases)
}
