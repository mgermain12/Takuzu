source("R/niveau.R")

#' Génère une grille Takuzu 8x8 qui respecte les règles du Takuzu
#' @param niveau Niveau de difficulté entre 'facile', 'moyen', 'difficile', 'jour'.
#' Le nombre de cases à supprimer dépend du niveau choisi.
#' @return Une matrice 8x8 contenant la grille Takuzu avec certaines cases vides.
#' @export

grille <- function(n) {
  taille <- 8
  cases_supp <- niveau(n)
  m <- matrix(NA, nrow = taille, ncol = taille)

  # Vérifie si un vecteur suit les règles du Takuzu
  valide <- function(vec) {
    vec <- na.omit(vec)  # Supprime les NA pour éviter les erreurs
    if (length(vec) > 8) return(FALSE)  # Évite d'avoir plus de 8 éléments

    # Vérifie l'équilibre entre 0 et 1
    if (sum(vec == 0) > length(vec) / 2 || sum(vec == 1) > length(vec) / 2) {
      return(FALSE)
    }
    # Vérifie qu'il n'y a pas plus de deux 0 ou 1 consécutifs
    if (any(rle(vec)$lengths > 2)) {
      return(FALSE)
    }
    return(TRUE)
  }

  # Génération de la grille valide
  for (i in 1:taille) {
    for (j in 1:taille) {
      valeurs_possibles <- c(0, 1)
      repeat {
        val <- sample(valeurs_possibles, 1)  # Choix aléatoire
        m[i, j] <- val

        if (valide(m[i, ]) && valide(m[, j])) {
          break  # On garde la valeur si la ligne et la colonne restent valides
        }
        m[i, j] <- NA  # Sinon, on réessaie
      }
    }
  }

  # Vérifie l'unicité des lignes et colonnes
  unique_lignes <- nrow(unique(m, MARGIN = 1)) == taille
  unique_colonnes <- nrow(unique(t(m), MARGIN = 1)) == taille

  if (!(unique_lignes && unique_colonnes)) {
    return(grille(n))  # Relance la génération si la grille n'est pas correcte
  }

  # Suppression de certaines cases selon le niveau
  indices <- sample(1:(taille^2), cases_supp)
  m[indices] <- NA

  return(m)
}

print(grille("facile"))
