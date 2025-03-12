grille1 <- matrix(c(0,0,1,1,0,1,0,1,
                   0,1,0,1,1,0,1,0,
                   1,1,0,0,1,0,0,1,
                   1,0,1,1,0,1,0,0,
                   0,1,0,0,1,0,1,1,
                   1,1,0,1,0,1,0,0,
                   0,0,1,0,1,0,1,1,
                   1,0,1,0,0,1,1,0),nrow = 8, ncol=8)


case <- sample(length(grille1), 20)

grille_facile <- grille1
grille_facile[case] <- ""

write.csv(grille_facile, file = "grille_facile.csv")