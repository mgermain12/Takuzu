library(shiny)
library(bslib)

grille <- read.csv("grille1_takuzu.csv", header = FALSE)
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

ui <- fluidPage(
  tags$style(HTML("
    .navbar-nav {
      display: flex;
      justify-content: center;
      width: 100%;
    }
    .navbar-nav .nav-link {
      font-size: 50px;  /* Agrandir la taille des éléments de menu */
      text-align: center;
    }
    .table {
      margin: 0 auto;  /* Centrer la grille */
      width: auto;  /* Ajuster la largeur de la table */
    }
    .container {
      text-align: center;
    }
  ")),
  # Page d'accueil
  uiOutput("accueil_page"),
  
  # Conteneur pour la grille de jeu
  uiOutput("jeu_page")
)

# Serveur
server <- function(input, output, session) {
  
  # Affichage de la page d'accueil
  output$accueil_page <- renderUI({
    tagList(
      div(style = "text-align: center; margin-top: 50px;",
          h1("Le Fou Takuzu !"),
          p("Choisissez un niveau pour commencer votre aventure. Cliquez sur le bouton ci-dessous pour démarrer."),
          actionButton("start_game", "Commencer le jeu", class = "btn btn-primary")
      )
    )
  })
  
  # Affichage de la page de jeu après avoir cliqué sur "Commencer le jeu"
  observeEvent(input$start_game, {
    output$accueil_page <- renderUI({
      NULL  # Cache la page d'accueil
    })
    
    output$jeu_page <- renderUI({
      tagList(
        card(
          full_screen = TRUE,
          h2("Choisissez un niveau de difficulté :"),
          navset_underline(
            id = "niveau",
            nav_panel("Facile", value = "Facile"),
            nav_panel("Moyen", value = "Moyen"),
            nav_panel("Difficile", value = "Difficile")
          ),
          div(style = "width: 600px; margin: auto;",  # Spécifiez la largeur ici
              tableOutput("grille_affiche")
          )
        ),
        actionButton("back_to_home", "Retour à l'accueil", class = "btn btn-secondary"),
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
    })}
)
  
  # Rendu de la grille en fonction du niveau choisi
  output$grille_affiche <- renderTable({
    req(input$niveau)
    
    if (input$niveau == "Facile") {
      grille_facile
    } else if (input$niveau == "Moyen") {
      grille_moyen
    } else {
      grille_difficile
    }
  }, striped = TRUE, colnames = FALSE, align = "c", bordered = TRUE)

  observeEvent(input$back_to_home, {
  output$jeu_page <- renderUI({
    NULL  # Cache la page de jeu
  })
  
  output$accueil_page <- renderUI({
    tagList(
      div(style = "text-align: center; margin-top: 50px;",
          h1("Le Fou Takuzu !"),
          p("Choisissez un niveau pour commencer votre aventure. Cliquez sur le bouton ci-dessous pour démarrer."),
          actionButton("start_game", "Commencer le jeu", class = "btn btn-primary")
      )
    )
  })
})
}

# Lancer l'application
shinyApp(ui, server)

