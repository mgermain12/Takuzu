#' Création de niveau de difficulté
#' @param x Un caractère indiquant le niveau de difficulté. Doit être l'un des suivants :
#'   - `"facile"` (20 cases supprimées)
#'   - `"moyen"` (35 cases supprimées)
#'   - `"difficile"` (40 cases supprimées)
#'   - `"bonus"` (45 cases supprimées)
#'
#' @return Un entier correspondant au nombre de cases à supprimer.
#' @export
#'
niveau <- function(x) {

  niveaux <- list("Facile" = 20, "Moyen" = 35, "Difficile" = 40, "Bonus" = 45)
  nb_cases <- niveaux[[x]]

  return(nb_cases)
}
