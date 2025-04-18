#' Génère une grille Takuzu 8x8 qui respecte les règles du Takuzu
#' @param n Niveau de difficulté entre 'facile', 'moyen', 'difficile', 'bonus'.
#' Le nombre de cases à supprimer dépend du niveau choisi.
#' @return Une matrice 8x8 contenant la grille Takuzu avec certaines cases vides.
#' @export


grille <- function(n) {
  cases_supp <- niveau(n)

  set.seed(as.numeric(Sys.time()) + sample(1:10000, 1))

  # Vérifie si une ligne ou une colonne respecte les règles
  valide_vecteur <- function(vec) {
    vec <- as.numeric(vec)
    vec <- as.vector(na.omit(vec))  # Supprime les valeurs NA

    # Vecteur invalide s'il est vide après suppression des NA
    if (length(vec) == 0) {
      return(FALSE)
    }

    # Vecteur invalide s'il y a plus de 4 zéros ou de 4 uns
    if (sum(vec == 0, na.rm = TRUE) > 4 || sum(vec == 1, na.rm = TRUE) > 4) {
      return(FALSE)
    }

    # Vecteur invalide s'il y a plus de 2 chiffres identiques consécutifs
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
    if (i > 8) {
      if (unique_lignes_colonnes(m)) {
        return(m)
      } else {
        return(NULL)
      }
    }

    next_i <- if (j == 8) { i + 1 } else { i }
    next_j <- if (j == 8) { 1 } else { j + 1 }

    for (val in sample(c(0, 1))) {
      m[i, j] <- val

      if (valide_vecteur(m[i, ]) && valide_vecteur(m[, j])) {
        res <- remplir(m, next_i, next_j)
        if (!is.null(res)) return(res)
      }
      m[i, j] <- NA
    }
    return(NULL)
  }

  # Création de la grille remplie
  m <- matrix(NA, nrow = 8, ncol = 8)
  solution <- remplir(m)

  if (is.null(solution)) {
    return(grille(n))
  }

  # Création de la grille à remplir
  grille_complete <- solution
  indices <- sample(1:(8^2), cases_supp)
  solution[indices] <- NA

  return(list(solution = solution, grille_complete = grille_complete))
}
