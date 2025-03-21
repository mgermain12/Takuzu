source("R/grille.R")

#' Vérifie que la grille générée respecte les règles du Takuzu.
#' @param grille.
#' @return TRUE si la grille est valide, FALSE sinon.
#' @export

verifier <- function(grille) {


  if (length(grille) > 8) {
    return(FALSE)
  }

  if (sum(vec == 0) > 4 || sum(vec == 1) > 4) {
    return(FALSE)
  }

  if (any(rle(vec[!is.na(vec)])$lengths > 2)) {
    return(FALSE)
  }

  lignes <- apply(m, 1, paste, collapse = "")
  colonnes <- apply(m, 2, paste, collapse = "")
  if (length(unique(lignes)) == nrow(m) && length(unique(colonnes)) == ncol(m)) {
    return(FALSE)
  }

  return(TRUE)
}

verifier(grille("facile"))
