source("R/grille.R")

#' Vérifie que la grille générée respecte les règles du Takuzu.
#' @param grille.
#' @return TRUE si la grille est valide, FALSE sinon.
#' @export

verifier <- function(grille) {

  # Vérifier que la grille est bien 8x8
  if (nrow(grille) != 8 || ncol(grille) != 8) {
    return(FALSE)
  }

  # Fonction pour vérifier qu'une ligne/colonne respecte les règles du Takuzu
  valide_vecteur <- function(vec) {
    vec <- na.omit(vec)  # Supprime les valeurs NA

    # Vérifie qu'il y a au plus 4 zéros et 4 uns
    if (sum(vec == 0) > 4 || sum(vec == 1) > 4) {
      return(FALSE)
    }

    # Vérifie qu'il n'y a pas plus de 2 chiffres identiques consécutifs
    if (any(rle(vec)$lengths > 2)) {
      return(FALSE)
    }

    return(TRUE)
  }

  # Vérifier toutes les lignes et colonnes
  for (i in 1:8) {
    if (!valide_vecteur(grille[i, ]) || !valide_vecteur(grille[, i])) {
      return(FALSE)
    }
  }

  # Vérifier unicité des lignes et colonnes
  lignes <- apply(grille, 1, paste, collapse = "")
  colonnes <- apply(grille, 2, paste, collapse = "")

  if (length(unique(lignes)) != 8 || length(unique(colonnes)) != 8) {
    return(FALSE)
  }

  return(TRUE)  # Si toutes les conditions sont respectées
}

# Exemple d'utilisation
print(verifier(grille("facile")))
