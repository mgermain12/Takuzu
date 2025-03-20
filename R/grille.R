source("R/niveau.R")

#' Génère une grille Takuzu 8x8 qui respecte les règles du Takuzu
#' @param n Niveau de difficulté entre 'facile', 'moyen', 'difficile', 'jour'.
#' Le nombre de cases à supprimer dépend du niveau choisi.
#' @return Une matrice 8x8 contenant la grille Takuzu avec certaines cases vides.
#' @export


grille <- function(n) {
  taille <- 8
  cases_supp <- niveau(n)

  # Fonction qui vérifie si une ligne ou colonne respecte les règles
  valide_vecteur <- function(vec) {
    vec <- na.omit(vec)
    if (length(vec) > 8) {
      return(FALSE)
    }
    if (sum(vec == 0) > 4 || sum(vec == 1) > 4) {
      return(FALSE)
    }
    if (any(rle(vec[!is.na(vec)])$lengths > 2)) {
      return(FALSE)
    }
    else {
      return(TRUE)
    }
  }

  remplir <- function(m, i = 1, j = 1) {
    if (i > taille) {return(m)}

    next_i <- if (j == taille) {i + 1} else {i}
    next_j <- if (j == taille) {1} else {j + 1}

    for (val in c(0, 1)) {
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
print(grille("jour"))

