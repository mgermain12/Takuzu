library(shiny)
library(bslib)

ui <- fluidPage(
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Gloria+Hallelujah&display=swap"),
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap"),
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js")
  ),

  tags$script(HTML("
      Shiny.addCustomMessageHandler('confetti', function(message) {
        confetti({
        spread: 5000,
          particleCount: 10000,  // Augmentation du nombre de confettis pour un effet plus intense
      origin: {  x: 0.5, y: 1.45  },   // Position de départ (milieu de l'écran)
      gravity: 0.5,         // Gravité plus forte pour faire tomber les confettis rapidement
      startVelocity: 100,    // Vitesse plus élevée pour que l'explosion soit encore plus massive
      ticks: 200,           // Durée de vie des confettis (plus longtemps avant de disparaître)
      colors: ['#FF5733', '#FF33FF', '#33FFF3', '#FFD700', '#FF0000', '#00FF00', '#1E90FF'],
      shapes: ['circle', 'square', 'triangle'],  // Formes variées pour plus de diversité visuelle
      angle: 90,            // Direction verticale pour que les confettis tombent droit
      angleVariation: 5000,
      decay: 0.9,           // Réduction progressive de la vitesse pour simuler une chute naturelle
      drift: 0,             // Pas de dérive horizontale
      gravity: 0.4            // Ajuste la chute pour une gravité plus naturelle
        });
      });
    ")),
  tags$script(HTML("
  Shiny.addCustomMessageHandler('shake', function(message) {
    $('body').addClass('shake');
    setTimeout(function() {
      $('body').removeClass('shake');
    }, 1000);
  });
")),

  tags$style(HTML("
   @keyframes shake {
      0% { transform: translate(10px, 10px) rotate(0deg); }
      10% { transform: translate(-10px, -10px) rotate(-5deg); }
      20% { transform: translate(-20px, 0px) rotate(5deg); }
      30% { transform: translate(20px, 10px) rotate(-5deg); }
      40% { transform: translate(-15px, 10px) rotate(5deg); }
      50% { transform: translate(15px, -10px) rotate(-5deg); }
      60% { transform: translate(-20px, 10px) rotate(5deg); }
      70% { transform: translate(20px, -10px) rotate(-5deg); }
      80% { transform: translate(-10px, 15px) rotate(5deg); }
      90% { transform: translate(10px, -15px) rotate(-5deg); }
      100% { transform: translate(0, 0) rotate(0deg); }
    }

    .shake {
      animation: shake 1s;
      animation-iteration-count: 3;
    }
  .parchment-button {
  background: linear-gradient(135deg, #add8e6, #4682b4);
  color: white;
  font-size: 40px;
  border-radius: 10px;
  padding: 20px 30px;
  border: 1px solid #b09763;
  box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1); /* Ombre légère */
  font-family: 'Patrick Hand', fantasy;
  text-align: center;
}
    .case {
      width: 100%;
      height: 100%;
      font-size: 25px;
      background-color: #ADD8E6;
      cursor: not-allowed;
      border-radius: 0;
    }

    .title-text {
      font-size: 100px;
      font-family: 'Gloria Hallelujah', cursive;
      font-weight: bold;
      color: skyblue;
      text-shadow: 3px 3px 5px gray;
    }

    .case-button {
      width: 100%;
      height: 100%;
      font-size: 25px;
      background-color: white;
      border: none;
    }

    .new-button {
      display: flex;
  flex-direction: column; /* Dispose les éléments verticalement */
  align-items: center; /* Centre les éléments horizontalement */
  gap: 10px; /* Espace entre les boutons */
      background-color: skyblue;
      color: white;
      font-size: 30px;
      padding: 10px 30px;
      border-radius: 10px;
      margin: 5px;
      position: relative;
      top: -500px;
      left: 70px;
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
      border-radius: 10px;
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
      gap: 50px;
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
      flex-direction: column;
      align-items: center;
      justify-content: center;
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
      padding: 5px 20px;
      border-radius: 10px;
      position: absolute; /* Positionnement indépendant */
  top: 80%; /* Ajuste la hauteur, peut être 50%, 70%, etc. selon tes besoins */
  left: 50%; /* Centre horizontalement */
  transform: translate(-50%, -50%); /* Recentre parfaitement */
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
  niveau_select <- reactiveVal(NULL)
  grille_val <- reactiveVal(NULL)
  user_grille <- reactiveValues(grid = NULL)

  output$accueil_page <- renderUI({
    tagList(
      div(style = "text-align: center; margin-top: 150px;",
          h1("Le Fou Takuzu !", class ="title-text"),
          tags$div(
            class = "center-button",actionButton("start_game", "Commencer le jeu", class = "parchment-button"))
      )
    )
  })

  observeEvent(input$start_game, {
    output$accueil_page <- renderUI({ NULL })

    output$niveau_page <- renderUI({
      div(class="centre1",h2("Choisissez un niveau de difficulté :",class="titre"),
          div(
            class = "button-row",
            actionButton("niveau_facile", "Facile", class = "parchment-button"),
            actionButton("niveau_moyen", "Moyen", class = "parchment-button"),
            actionButton("niveau_difficile", "Difficile", class = "parchment-button")),
          h2("...ou testez la grille du jour :", class="titre"),
          actionButton("grille_jour", "Grille du Jour", class = "parchment-button"),
          actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
      )})})

  observeEvent(input$niveau_facile, {
    output$niveau_page <- renderUI({ NULL })
    niveau_select("facile")
    init_game("facile")
    show_game_page("Facile")
  })

  observeEvent(input$niveau_moyen, {
    output$niveau_page <- renderUI({ NULL })
    niveau_select("moyen")
    init_game("moyen")
    show_game_page("Moyen")
  })

  observeEvent(input$niveau_difficile, {
    output$niveau_page <- renderUI({ NULL })
    niveau_select("difficile")
    init_game("difficile")
    show_game_page("Difficile")
  })

  observeEvent(input$grille_jour, {
    output$niveau_page <- renderUI({ NULL })
    niveau_select("jour")
    init_game("jour")
    output$niveau_page <- renderUI({
      tagList(
        h2("Grille du jour", class = "centre"),
        div(class = "centre", uiOutput("grille_affiche")),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("recommencer", "Recommencer", class = "new-button"),
        actionButton("verifier", "Vérifier", class = "new-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  })

  show_game_page <- function(title) {
    output$niveau_page <- renderUI({
      tagList(
        h2(title, class = "centre"),
        div(class = "centre", uiOutput("grille_affiche")),
        actionButton("verifier", "Vérifier", class = "new-button"),
        actionButton("recommencer", "Recommencer", class = "new-button"),
        actionButton("nouvelle_partie", "Nouvelle partie", class = "new-button"),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  }

  observeEvent(input$verifier, {
    # Vérifiez si la grille est bien définie avant de l'utiliser
    if (!is.null(grille_val()) && !is.null(user_grille$grid) && verifier(user_grille$grid)) {
      session$sendCustomMessage("confetti", list())
    } else {
      session$sendCustomMessage("shake", list())
    }
  })

  # Afficher la grille selon le niveau choisi
  output$grille_affiche <- renderUI({
    req(user_grille$grid)
    grid <- user_grille$grid
    tagList(
      tags$table(
        lapply(1:nrow(grid), function(i) {
          tags$tr(
            lapply(1:ncol(grid), function(j) {
              val <- grid[i, j]
              btn_id <- paste0("cell_", i, "_", j)
              if (is.na(grille_val()[i, j])) {
                label_text <- ifelse(is.na(val), " ", as.character(val))
                tags$td(actionButton(btn_id, label = label_text, class = "case-button"))
              } else {
                tags$td(actionButton(btn_id, label = as.character(val), class = "case"))
              }
            })
          )
        })
      )
    )
  })

  # Dynamique : observer tous les boutons cliquables (cases vides)
  observe({
    for (i in 1:8) {
      for (j in 1:8) {
        local({
          ii <- i
          jj <- j
          btn_id <- paste0("cell_", ii, "_", jj)
          observeEvent(input[[btn_id]], {
            if (is.null(user_grille$grid)) return()
            if (is.na(grille_val()[ii, jj])) {  # Case modifiable
              current <- user_grille$grid
              if (is.na(current[ii, jj])) {
                current[ii, jj] <- 0
              } else if (current[ii, jj] == 0) {
                current[ii, jj] <- 1
              } else {
                current[ii, jj] <- NA
              }
              user_grille$grid <- current
            }
          }, ignoreNULL = TRUE)
        })
      }
    }
  })

  init_game <- function(niv) {
    g <- grille(niv)
    grille_val(g)
    user_grille$grid <- g
  }

  observeEvent(input$nouvelle_partie, {
    req(niveau_select())
    g <- grille(niveau_select())
    grille_val(g)
    user_grille$grid <- g
  })

  observeEvent(input$back_to_home, {
    grille_val(NULL)
    niveau_select(NULL)
    output$niveau_page <- renderUI({ NULL })
    output$jeu_page <- renderUI({ NULL })

    output$accueil_page <- renderUI({
      tagList(
        div(style = "text-align: center; margin-top: 50px;",
            h1("Le Fou Takuzu !", class ="title-text"),
            tags$div(
              class = "center-button",actionButton("start_game", "Commencer le jeu", class = "parchment-button"))
        )
      )
    })
  })

  observeEvent(input$abandon, {
    grille_val(NULL)
    niveau_select(NULL)
    output$niveau_page <- renderUI({
      div(class="centre1",h2("Choisissez un niveau de difficulté :",class="titre"),
          div(
            class = "button-row",
            actionButton("niveau_facile", "Facile", class = "parchment-button"),
            actionButton("niveau_moyen", "Moyen", class = "parchment-button"),
            actionButton("niveau_difficile", "Difficile", class = "parchment-button")),
          h2("...ou testez la grille du jour :", class="titre"),
          actionButton("grille_jour", "Grille du Jour", class = "parchment-button"),
          actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
      )})})

}

shinyApp(ui, server)
