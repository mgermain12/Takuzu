library(shiny)

grille <- read.csv("grille1_takuzu.csv", header = FALSE)
grille <- as.matrix(grille)

case <- sample(length(grille), 20)

grille_facile <- grille
grille_facile[case] <- ""

# Convertir la matrice en data frame
grille_facile_df <- as.data.frame(grille_facile)

# Sauvegarder le data frame sans les noms de lignes et de colonnes
write.csv(grille_facile_df, file = "grille_facile.csv", row.names = FALSE, col.names = FALSE)


ui <- fluidPage(
  titlePanel("Le fou Takuzu"),
  
  tableOutput("grille_facile"),  # Affichage de la grille
  actionButton("Facile", "Facile"),
  actionButton("Moyen", "Moyen"),
  actionButton("Difficile", "Difficile")
)

server <- function(input, output, session) {
  output$grille_facile <- renderTable({
    grille  # Affiche la grille actuelle
  })
  
  observeEvent(input$Facile, {
    grille <<- read.csv("grille_facile.csv", header = FALSE, stringsAsFactors = FALSE)
    grille <<- as.matrix(grille)
    output$grille_facile <- renderTable({ grille })  # Met à jour l'affichage
  })
}

shinyApp(ui, server)
