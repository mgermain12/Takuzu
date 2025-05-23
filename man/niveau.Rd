% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/niveau.R
\name{niveau}
\alias{niveau}
\title{Création de niveau de difficulté}
\usage{
niveau(x)
}
\arguments{
\item{x}{Un caractère indiquant le niveau de difficulté. Doit être l'un des suivants :
\itemize{
\item \code{"facile"} (20 cases supprimées)
\item \code{"moyen"} (35 cases supprimées)
\item \code{"difficile"} (40 cases supprimées)
\item \code{"bonus"} (45 cases supprimées)
}}
}
\value{
Un entier correspondant au nombre de cases à supprimer.
}
\description{
Création de niveau de difficulté
}
