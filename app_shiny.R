library(shiny)
library(bslib)

grille <- read.csv("grille1.csv", header = FALSE)
grille <- as.matrix(grille)

case_facile <- sample(length(grille), 30)
case_moyen <- sample(length(grille), 35)
case_difficile <- sample(length(grille), 40)
  
grille_facile <- grille
grille_facile[case_facile] <- ""
grille_moyen <- grille
grille_moyen[case_moyen] <- ""
grille_difficile <- grille
grille_difficile[case_difficile] <- ""

# Sauvegarder le data frame sans les noms de lignes et de colonnes
write.table(grille_facile, file = "grille_facile.csv", row.names =FALSE, col.names = FALSE, sep=",")


ui <- page_fillable(
  title = "Le Fou Takuzu",
  sidebar = NULL,  
  fillable = TRUE,
  card(
    h1("Bienvenue sur Le Fou Takuzu !"),
    p("Choisissez un niveau pour commencer."),
    navset_underline(
      id = "niveau",
      nav_panel("Facile", value= "Facile", icon = NULL),
      nav_panel("Moyen", value= "Moyen", icon = NULL),
      nav_panel("Difficile", value= "Difficile", icon = NULL)
    ),
    div(style = "width: 600px; margin: auto;",  # Spécifiez la largeur ici
        tableOutput("grille_affiche")
    )
  ),
  tags$style(HTML("
    paged_table {
      border-collapse: collapse;
      width: 100%;
    }
    th, td {
      border: 1px solid black;
      padding: 0;
      width: 60px;  /* Augmenter la largeur des cellules */
      height: 60px; /* Augmenter la hauteur des cellules */
      text-align: center;
    }
    tr {
      border-bottom: 1px solid black;  /* Bordure horizontale entre les lignes */
      border-top: 1px solid black;
    }
    th {
      background-color: #f2f2f2;
    }
  "))
)

server <- function(input, output, session) {
  output$grille_affiche <- renderTable({
  if (input$niveau == "Facile"){grille_facile}
  else if (input$niveau == "Moyen") {grille_moyen}
  else {grille_difficile}},colnames = FALSE, striped=TRUE,align = "c", bordered = TRUE)
}

shinyApp(ui, server)

