grille1 <- matrix(c(0,0,1,1,0,1,0,1,
                   0,1,0,1,1,0,1,0,
                   1,1,0,0,1,0,0,1,
                   1,0,1,1,0,1,0,0,
                   0,1,0,0,1,0,1,1,
                   1,1,0,1,0,1,0,0,
                   0,0,1,0,1,0,1,1,
                   1,0,1,0,0,1,1,0),nrow = 8, ncol=8)

grille2 <- matrix(c(1,0,0,1,1,0,1,0,
                    0,1,1,0,1,0,0,1,
                    0,1,1,0,0,1,0,1,
                    1,0,0,1,1,0,0,1,
                    1,0,0,1,1,0,0,1,
                    0,1,1,0,1,0,1,0,
                    1,0,1,0,0,1,1,0,
                    0,1,0,1,0,1,0,1),nrow = 8, ncol=8)

grille3 <- matrix(c(1,0,1,0,1,0,1,0,
                    0,1,0,1,0,1,0,1,
                    0,0,1,1,0,0,1,1,
                    1,1,0,0,1,1,0,0,
                    0,1,1,0,1,0,0,1,
                    0,0,1,1,0,1,1,0,
                    1,1,0,0,1,0,0,1,
                    1,0,0,1,0,1,1,0),nrow = 8, ncol=8)

grille4 <- matrix(c(1,0,0,1,0,1,1,0,
                    1,1,0,0,1,0,0,1,
                    0,0,1,1,0,1,1,0,
                    0,1,1,0,1,0,0,1,
                    1,1,0,0,1,1,0,0,
                    0,0,1,1,0,0,1,1,
                    0,1,0,1,0,1,0,1,
                    1,0,1,0,1,0,1,0),nrow = 8, ncol=8)

write.table(grille1, file = "grille1.csv", row.names = FALSE, col.names = FALSE, sep = ",")
write.table(grille2, file = "grille2.csv", row.names = FALSE, col.names = FALSE, sep = ",")
write.table(grille3, file = "grille3.csv", row.names = FALSE, col.names = FALSE, sep = ",")
write.table(grille4, file = "grille4.csv", row.names = FALSE, col.names = FALSE, sep = ",")


























