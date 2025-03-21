#' Génère une grille Takuzu 8x8 qui respecte les règles du Takuzu
#' @param n Niveau de difficulté entre 'facile', 'moyen', 'difficile', 'jour'.
#' Le nombre de cases à supprimer dépend du niveau choisi.
#' @return Une matrice 8x8 contenant la grille Takuzu avec certaines cases vides.
#' @export


grille <- function(n) {
  taille <- 8
  cases_supp <- niveau(n)

  set.seed(as.numeric(Sys.time()) + sample(1:10000, 1))

  # Fonction qui vérifie si une ligne ou colonne respecte les règles
  valide_vecteur <- function(vec) {
    vec <- as.numeric(vec)
    vec <- as.vector(na.omit(vec))  # Supprime les valeurs NA

    # Si le vecteur est vide après suppression des NA, il est invalide
    if (length(vec) == 0) {
      return(FALSE)
    }

    # Vérifie qu'il y a au plus 4 zéros et 4 uns
    if (sum(vec == 0, na.rm = TRUE) > 4 || sum(vec == 1, na.rm = TRUE) > 4) {
      return(FALSE)
    }
    # Vérifie qu'il n'y a pas plus de 2 chiffres identiques consécutifs
    if (any(rle(vec)$lengths > 2, na.rm = TRUE)) {
      return(FALSE)
    }

    return(TRUE)
  }

  # Vérifie qu'aucune ligne ou colonne n'est identique à une autre
  unique_lignes_colonnes <- function(m) {
    lignes <- apply(m, 1, paste, collapse = "")
    colonnes <- apply(m, 2, paste, collapse = "")
    return(length(unique(lignes)) == nrow(m) && length(unique(colonnes)) == ncol(m))
  }

  remplir <- function(m, i = 1, j = 1) {
    if (i > taille) {
      # Vérifier unicité des lignes et colonnes avant d'accepter la solution
      if (unique_lignes_colonnes(m)) {
        return(m)
      } else {
        return(NULL)
      }
    }

    next_i <- if (j == taille) { i + 1 } else { i }
    next_j <- if (j == taille) { 1 } else { j + 1 }

    for (val in sample(c(0, 1))) {  # Mélange des valeurs pour varier les solutions
      m[i, j] <- val

      if (valide_vecteur(m[i, ]) && valide_vecteur(m[, j])) {
        res <- remplir(m, next_i, next_j)
        if (!is.null(res)) return(res)
      }
      m[i, j] <- NA  # Backtrack
    }
    return(NULL)  # Aucun choix possible ici
  }

  # Initialisation de la matrice vide
  m <- matrix(NA, nrow = taille, ncol = taille)
  solution <- remplir(m)

  # Si pas de solution, on relance proprement la fonction grille
  if (is.null(solution)) {
    return(grille(n))  # Appel récursif sur grille complète
  }

  # Suppression des cases selon le niveau
  indices <- sample(1:(taille^2), cases_supp)
  solution[indices] <- NA

  return(solution)
}

# Exemple
print(grille("facile"))

