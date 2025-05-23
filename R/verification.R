#' Vérifie que la grille générée respecte les règles du Takuzu.
#' @param g Une matrice 8x8 représentant la grille Takuzu.
#' @return TRUE si la grille est valide, FALSE sinon.
#' @export

verifier <- function(g) {

  # Vérifie que toutes les cases sont remplies
  if (any(is.na(g))) {
    return(FALSE)
  }

  for (i in 1:8) {
    ligne <- g[i, ]
    colonne <- g[, i]

    # Vérifie qu'il n'y a pas plus de 4 zéros ou de 4 uns dans une ligne ou une colonne
    if (sum(ligne == 0, na.rm = TRUE) > 4 || sum(ligne == 1, na.rm = TRUE) > 4) {
      return(FALSE)
    }
    if (sum(colonne == 0, na.rm = TRUE) > 4 || sum(colonne == 1, na.rm = TRUE) > 4) {
      return(FALSE)
    }

    # Vérifie qu'il n'y a pas plus de 2 chiffres identiques consécutifs dans une ligne ou une colonne
    if (any(rle(ligne[!is.na(ligne)])$lengths > 2)) {
      return(FALSE)
    }
    if (any(rle(colonne[!is.na(colonne)])$lengths > 2)) {
      return(FALSE)
    }
  }

  # Vérifie que toutes les lignes et colonnes sont uniques
  lignes <- apply(g, 1, paste, collapse = "")
  colonnes <- apply(g, 2, paste, collapse = "")

  if (length(unique(lignes)) != nrow(g) || length(unique(colonnes)) != ncol(g)) {
    return(FALSE)
  }

  return(TRUE)
}
