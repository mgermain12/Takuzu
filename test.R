library(shiny)
library(bslib)

grilles <- c("grille1.csv", "grille2.csv", "grille3.csv", "grille4.csv")
grille_choisie <- sample(grilles, 1)

grille <- read.csv(grille_choisie, header = FALSE)
grille <- as.matrix(grille)

case_facile <- sample(length(grille), 30)
case_moyen <- sample(length(grille), 35)
case_difficile <- sample(length(grille), 40)
case_jour <- sample(length(grille), 45)

grille_facile <- grille
grille_facile[case_facile] <- ""
grille_moyen <- grille
grille_moyen[case_moyen] <- ""
grille_difficile <- grille
grille_difficile[case_difficile] <- ""
grille_jour <- grille
grille_jour[case_jour] <- ""


ui <- fluidPage(
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Gloria+Hallelujah&display=swap"),
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap"),
  
  tags$style(HTML("
    .title-text {
      font-size: 100px;
      font-family: 'Gloria Hallelujah', cursive; 
      
      /* VT323 (monospace) ou papyrus(fantasy) ou Patrick Hand(fan..)  */
      
      font-weight: bold;
      color: skyblue; 
      text-shadow: 3px 3px 5px gray; /* Ajouter une ombre */
      
    }
    
    .center-button {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
    
    .big-button {
        background-color: skyblue;  
        color: white;  
        font-size: 40px;  
        border-radius: 10px;  /* Coins arrondis */
        padding: 20px 30px;
        margin: 5px;
    }
    
    .back-button {
    background-color: #d3d3d3;
    position: absolute;
    bottom: 20px;
    left: 20px;
    font-size: 20px;
    padding: 10px 30px;
    }
    
    .button-container {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    height: 100vh; 
    }
    
    .button-row {
    display: flex;
    gap: 50px; /* Ajoute de l'espace entre les boutons */
    justify-content: center;
    margin-top: 20px;
    }
    
    .centre {
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 40px;
    }
    
    .centre1 {
      display: flex;
      flex-direction: column; /* Permet d'empiler les éléments */
      align-items: center; /* Centre horizontalement */
      justify-content: center; /* Centre verticalement */
      text-align: center;
      width: 100%;
    }
    
    .titre {
      font-size: 50px; 
      font-family: 'Patrick Hand', fantasy;
      font-weight: bold;
      color: skyblue;
      text-align: center;
      margin-bottom: 30px; 
    }
    
    .abandon {
  background-color: red;
  color: white;
  font-size: 30px;
  padding: 10px 30px; 
  border-radius: 10px;
  display: block; /* S'assure que le bouton prend toute la largeur possible */
  margin-top: 20px; /* Espace entre la grille et le bouton */
  margin-left: auto;
  margin-right: auto;
    }
    
    table {
      border-collapse: collapse;
      width: 100%;
      margin: auto;
    }
    th, td {
      border: 1px solid black;
      padding: 0;
      width: 70px;
      height: 70px;
      text-align: center;
      font-size: 30px;
      vertical-align: middle;
    }
    tr {
      border-bottom: 1px solid black;
      border-top: 1px solid black;
    }
    th {
      background-color: #f2f2f2;
    }
  ")),
  uiOutput("accueil_page"),
  uiOutput("niveau_page"),
  uiOutput("jeu_page")
)


server <- function(input, output, session) {
  output$accueil_page <- renderUI({
    tagList(
      div(style = "text-align: center; margin-top: 150px;",
          h1("Le Fou Takuzu !", class ="title-text"),
          tags$div(
            class = "center-button",actionButton("start_game", "Commencer le jeu", class = "big-button"))
      )
    )
  })
  
  observeEvent(input$start_game, {
  output$accueil_page <- renderUI({ NULL })
    
  output$niveau_page <- renderUI({
      div(class="centre1",h2("Choisissez un niveau de difficulté :",class="titre"),
              div(
        class = "button-row",
                actionButton("niveau_facile", "Facile", class = "big-button"),
                actionButton("niveau_moyen", "Moyen", class = "big-button"),
                actionButton("niveau_difficile", "Difficile", class = "big-button")),
        h2("...ou testez la grille du jour :", class="titre"),
        actionButton("grille_jour", "Grille du Jour", class = "big-button"),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
)})})
  
  observeEvent(input$niveau_facile, {
    output$niveau_page <- renderUI({ NULL })
    
    output$niveau_page <- renderUI({
      tagList(
        h2("Facile",class="centre"),
        div(class="centre",tableOutput("grille_affiche")),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  })
  
  observeEvent(input$niveau_moyen, {
    output$niveau_page <- renderUI({ NULL })
    
    output$niveau_page <- renderUI({
      tagList(
        h2("Moyen",class="centre"),
        div(class="centre",tableOutput("grille_affiche")),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  })
  
  observeEvent(input$niveau_difficile, {
    output$niveau_page <- renderUI({ NULL })
    
    output$niveau_page <- renderUI({
      tagList(
        h2("Difficile",class="centre"),
        div(class="centre",tableOutput("grille_affiche")),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  })
  
  observeEvent(input$grille_jour, {
    output$niveau_page <- renderUI({ NULL })
    
    output$niveau_page <- renderUI({
      tagList(
        h2("Grille du Jour",class="centre"),
        div(class="centre",tableOutput("grille_affiche")),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  })
  
  # Afficher la grille selon le niveau choisi
  output$grille_affiche <- renderTable({
    if (input$niveau_facile == 1) {
      grille_facile
    } else if (input$niveau_moyen == 1) {
      grille_moyen
    } else if (input$niveau_difficile == 1) {
      grille_difficile
    } else {
      grille_jour
    }
  }, striped = TRUE, colnames = FALSE, align = "c", bordered = TRUE)
  
  observeEvent(input$back_to_home, {
    output$niveau_page <- renderUI({ NULL })
    output$jeu_page <- renderUI({ NULL })
  
  output$accueil_page <- renderUI({
    tagList(
      div(style = "text-align: center; margin-top: 50px;",
          h1("Le Fou Takuzu !", class ="title-text"),
          tags$div(
            class = "center-button",actionButton("start_game", "Commencer le jeu", class = "big-button"))
      )
    )
  })
})
  observeEvent(input$abandon, {
    output$niveau_page <- renderUI({
      div(class="centre1",h2("Choisissez un niveau de difficulté :",class="titre"),
          div(
            class = "button-row",
            actionButton("niveau_facile", "Facile", class = "big-button"),
            actionButton("niveau_moyen", "Moyen", class = "big-button"),
            actionButton("niveau_difficile", "Difficile", class = "big-button")),
          h2("...ou testez la grille du jour :", class="titre"),
          actionButton("grille_jour", "Grille du Jour", class = "big-button"),
          actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
      )})})
}

shinyApp(ui, server)

