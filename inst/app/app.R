library(shiny)
library(bslib)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),

  # Polices d'écriture
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Gloria+Hallelujah&display=swap"),
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap"),

  # Confettis (victoire)
  tags$head(tags$script(src = "https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js")),
  tags$script(HTML("
      Shiny.addCustomMessageHandler('confetti', function(message) {
        confetti({
          spread: 5000,
          particleCount: 7000,
          origin: {  x: 0.5, y: 1.45  },
          startVelocity: 100,
          ticks: 200,
          colors: ['#FF5733', '#FF33FF', '#33FFF3', '#FFD700', '#FF0000', '#00FF00', '#1E90FF'],
          shapes: ['circle', 'square', 'triangle'],
          angle: 90,
          angleVariation: 5000,
          decay: 0.9,
          drift: 0,
          gravity: 0.5
        });
      });
    ")),

  # Shake (défaite)
  tags$script(HTML("
  Shiny.addCustomMessageHandler('shake', function(message) {
    $('body').addClass('shake');
    setTimeout(function() {
      $('body').removeClass('shake');
    }, 1000);
  });
")),

  # Sons de victoire et de défaite
  tags$script(HTML("
function playSound(soundFile) {
    var audio = new Audio(soundFile);

    audio.onloadedmetadata = function() {
        audio.currentTime = 1;
        audio.play().catch(error => console.log('Erreur de lecture audio :', error));

        setTimeout(function() {
            audio.pause();
        }, 3000); // 3000 ms = 3 secondes
    };
}

Shiny.addCustomMessageHandler('win', function(message) {
    playSound('victoire.mp3');
});

Shiny.addCustomMessageHandler('lose', function(message) {
    playSound('defaite.mp3');
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

    .responsive-accueil {
      width: 100vw;
      height: 100vh;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      text-align: center;
    }

    .responsive-accueil h1, .responsive-accueil h2, .responsive-accueil p {
      font-size: calc(10vw + 1vh); /* Ajuste dynamiquement la taille du texte */
    }

    .background {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url('fond_takuzu.png');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      opacity: 0.4; /* Ajuste la transparence de l'image */
      z-index: -1;
    }

    .titre {
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 70px ;
      font-family: 'Patrick Hand', fantasy;
      font-weight: bold;
      color: skyblue;
      text-align: center;
    }

    .title-text {
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 150px;
      font-family: 'Gloria Hallelujah', cursive;
      font-weight: bold;
      color: skyblue;
      text-shadow: 3px 3px 5px gray;
    }

    .case {
      width: 100%;
      height: 100%;
      font-size: 25px;
      background-color: #90b4d2;
      cursor: not-allowed;
      border-radius: 0;
    }

    .case-button {
      width: 100%;
      height: 100%;
      font-size: 25px;
      background-color: white;
      border: none;
    }

    .gold-case {
      width: 100%;
      height: 100%;
      font-size: 25px;
      background-color: #e0c260;
      cursor: not-allowed;
      border-radius: 0;
    }

    .classic-button {
      background: linear-gradient(135deg, #add8e6, #4682b4);
      color: white;
      font-size: 40px;
      border-radius: 10px;
      padding: 20px 30px;
      border: 1px solid #b09763;
      -shadow: 3px 3px 5px rgba(0, 0, 0, 0.1); /* Ombre */
      font-family: 'Patrick Hand', fantasy;
      text-align: center;
    }

    .solution-button {
      background: linear-gradient(135deg, #a8e6cf, #56ab2f);
      color: white;
      font-size: 30px;
      font-family: 'Patrick Hand', fantasy;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1); /* Ombre */
      padding: 10px 30px;
      border-radius: 10px;
      margin: 80px;
      position: absolute;
      top: 40%;
      left: 75%;
    }

    .abandon {
      background: linear-gradient(135deg, #ff9999, #cc0000);
      color: white;
      font-size: 30px;
      font-family: 'Patrick Hand', fantasy;
      padding: 5px 20px;
      border-radius: 10px;
      position: absolute; /* Positionnement indépendant */
      top: 70%;
      left: 80%;
    }

    .back-button {
      background-color: #d3d3d3;
      font-family: 'Patrick Hand', fantasy;
      position: absolute;
      bottom: 20px;
      left: 20px;
      font-size: 20px;
      padding: 10px 30px;
    }

    .new-button {
      display: flex;
      flex-direction: column; /* Dispose les éléments verticalement */
      align-items: center; /* Centre les éléments horizontalement */
      gap: 10px; /* Espace entre les boutons */
      background: linear-gradient(135deg, #add8e6, #4682b4);
      color: white;
      font-size: 30px;
      font-family: 'Patrick Hand', fantasy;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1); /* Ombre légère */
      padding: 10px 30px;
      border-radius: 10px;
      margin: 80px;
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

    .button-row {
      display: flex;
      gap: 50px;
      justify-content: center;
      margin-top: 0px;
    }

    .gold-button {
      background: linear-gradient(135deg, #fced9f, #d4ae33);
      color: white;
      font-size: 40px;
      border-radius: 10px;
      padding: 20px 30px;
      border: 1px solid #b09763;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1); /* Ombre légère */
      font-family: 'Patrick Hand', fantasy;
      text-align: center;
    }

    .new-gold-button {
      display: flex;
      flex-direction: column; /* Dispose les éléments verticalement */
      align-items: center; /* Centre les éléments horizontalement */
      gap: 10px; /* Espace entre les boutons */
      background: linear-gradient(135deg, #fced9f, #d4ae33);
      color: white;
      font-size: 30px;
      font-family: 'Patrick Hand', fantasy;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1); /* Ombre légère */
      padding: 10px 30px;
      border-radius: 10px;
      margin: 80px;
      position: relative;
      top: -500px;
      left: 70px;
    }

    .centre {
      display: flex;
      font-family: 'Patrick Hand', fantasy;
      text-align: center;
      justify-content: center;  /* Centre horizontalement */
      align-items: center;      /* Centre verticalement */
      font-size: 60px;
      flex-direction: column;
      gap: 50px;
    }

    .centre1 {
      font-size: 60px;
      font-family: 'Patrick Hand', fantasy;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      width =100%;
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
  uiOutput("regles_page"),
  uiOutput("niveau_page"),
  uiOutput("jeu_page")
)


server <- function(input, output, session) {
  niveau_select <- reactiveVal(NULL)
  grille_val <- reactiveVal(NULL)
  user_grille <- reactiveValues(grid = NULL)
  complete_grille <- reactiveValues(grid = NULL)
  debut_temps <- reactiveVal(NULL)
  depart_chrono <- reactiveVal(FALSE)
  timer_actif <- reactiveVal(TRUE)

  output$accueil_page <- renderUI({
    runjs("document.body.style.background = 'none';")
    tagList(
      div(class="responsive-accueil",
      div(class = "background"),
      div(style = "text-align: center; margin-top: 50px;",
      h1("Le Fou Takuzu !", class ="title-text"),
      tags$div(
        class = "center-button",actionButton("start_game", "Commencer le jeu", class = "classic-button"),
        tags$br(), tags$br(),
        actionButton("regles", "Règles du jeu", class = "classic-button"))
    )))})

  observeEvent(input$start_game, {
    runjs("document.body.style.background = 'white';")
    output$accueil_page <- renderUI({ NULL })

    output$niveau_page <- renderUI({
      div(class="centre",h2("Choisissez un niveau de difficulté :",class="titre"),
      div(
        class = "button-row",
        actionButton("niveau_facile", "Facile", class = "classic-button"),
        actionButton("niveau_moyen", "Moyen", class = "classic-button"),
        actionButton("niveau_difficile", "Difficile", class = "classic-button")),
      h2("...ou testez la grille bonus :", class="titre"),
      actionButton("grille_bonus", "Grille Bonus", class = "gold-button"),
      actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
    )})})

  observeEvent(input$regles, {
    runjs("document.body.style.background = 'white';")
    output$accueil_page <- renderUI({ NULL })

    output$niveau_page <- renderUI({
      div(class="centre", div(style = "margin-bottom: 10px;",h2("Qu'est ce que le Takuzu ?",class="titre")),
          h1("Il s'agit d'un jeu de logique japonais qui se joue sur une grille remplie de 0 et de 1. Il est très proche du Sudoku
             mais repose sur des règles plus simples et une réflexion binaire. Il porte également le nom Binario."),
          div(style = "margin-bottom: -15px;",h2("Comment jouer au Takuzu ?",class="titre")),
          div(style = "margin-top: 20px;",
          h1("1. Chaque ligne et chaque colonne doivent contenir autant de 0 que de 1."),
          h1("2. Il ne faut pas avoir plus de deux 0 ou de 1 consécutifs."),
          h1("3. Aucune ligne ou colonne ne doit être identique à une autre.")),
          h2("Bonne partie !",class="titre"),
      actionButton("back_to_home", "Retour à l'accueil", class = "back-button"))
      })})

  init_game <- function(niv) {
    g <- grille(niv)
    grille_val(g$solution)
    user_grille$grid <- g$solution
    complete_grille$grid <- g$grille_complete
  }

  observeEvent(input$niveau_facile, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })

    output$timer <- renderText({
      req(debut_temps(), depart_chrono())
      if (timer_actif()) {
        invalidateLater(1000, session)  # Actualiser toutes les secondes seulement si le timer est actif
        temps_ecoule <- as.integer(difftime(Sys.time(), debut_temps(), units = "secs"))
        sprintf("%02d:%02d:%02d", temps_ecoule %/% 3600, (temps_ecoule %% 3600) %/% 60, temps_ecoule %% 60)
      } else {
        return("00:00:00")  # Si le timer est inactif, afficher 00:00:00
      }
    })

    niveau_select("Facile")
    init_game("Facile")
    show_game_page("Facile")
  })

  observeEvent(input$niveau_moyen, {
    debut_temps(Sys.time())  # Initialiser le temps de début
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })

    output$timer <- renderText({
      req(debut_temps(), depart_chrono())
      if (timer_actif()) {
        invalidateLater(1000, session)
        temps_ecoule <- as.integer(difftime(Sys.time(), debut_temps(), units = "secs"))
        sprintf("%02d:%02d:%02d", temps_ecoule %/% 3600, (temps_ecoule %% 3600) %/% 60, temps_ecoule %% 60)
      } else {
        return("00:00:00")
      }
    })

    niveau_select("Moyen")
    init_game("Moyen")
    show_game_page("Moyen")
  })

  observeEvent(input$niveau_difficile, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })

    output$timer <- renderText({
      req(debut_temps(), depart_chrono())
      if (timer_actif()) {
        invalidateLater(1000, session)
        temps_ecoule <- as.integer(difftime(Sys.time(), debut_temps(), units = "secs"))
        sprintf("%02d:%02d:%02d", temps_ecoule %/% 3600, (temps_ecoule %% 3600) %/% 60, temps_ecoule %% 60)
      } else {
        return("00:00:00")
      }
    })

    niveau_select("Difficile")
    init_game("Difficile")
    show_game_page("Difficile")
  })

  observeEvent(input$grille_bonus, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })

    output$timer <- renderText({
      req(debut_temps(), depart_chrono())
      if (timer_actif()) {
        invalidateLater(1000, session)
        temps_ecoule <- as.integer(difftime(Sys.time(), debut_temps(), units = "secs"))
        sprintf("%02d:%02d:%02d", temps_ecoule %/% 3600, (temps_ecoule %% 3600) %/% 60, temps_ecoule %% 60)
      } else {
        return("00:00:00")
      }
    })

    niveau_select("Bonus")
    init_game("Bonus")
    output$niveau_page <- renderUI({
      tagList(div(id = "timer_container", style = "font-size: 30px; font-family: 'Patrick Hand', fantasy; text-align: center; margin-top: 20px;",
            textOutput("timer")),
        h2("Grille Bonus", class = "centre1"),
        div(class = "centre1", uiOutput("grille_affiche")),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("recommencer", "Recommencer", class = "new-gold-button"),
        actionButton("solution", "Solution", class="solution-button"),
        actionButton("verifier", "Vérifier", class = "new-gold-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  })

  show_game_page <- function(title) {
    output$niveau_page <- renderUI({
      tagList(
        div(id = "timer_container", style = "font-size: 30px; font-family: 'Patrick Hand', fantasy; text-align: center; margin-top: 20px;",
            textOutput("timer")),
        h2(title, class = "centre1"),
        div(class = "centre1", uiOutput("grille_affiche")),
        actionButton("verifier", "Vérifier", class = "new-button"),
        actionButton("solution", "Solution", class="solution-button"),
        actionButton("recommencer", "Recommencer", class = "new-button"),
        actionButton("nouvelle_partie", "Nouvelle partie", class = "new-button"),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
        actionButton("abandon", "Abandonner", class = "abandon")
      )
    })
  }

  observeEvent(input$solution, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    timer_actif(FALSE)
    user_grille$grid <- complete_grille$grid
  })


  observeEvent(input$verifier, {
    if (!is.null(grille_val()) && !is.null(user_grille$grid) && verifier(user_grille$grid)) {
      session$sendCustomMessage("win", list())
      session$sendCustomMessage("confetti", list())
      timer_actif(FALSE)
    } else {
      session$sendCustomMessage("lose", list())
      session$sendCustomMessage("shake", list())
    }
  })


  # Afficher la grille selon le niveau choisi
  output$grille_affiche <- renderUI({
    req(user_grille$grid)
    grid <- user_grille$grid
    niveau <- niveau_select()
    tagList(div(class="centre",
      tags$table(lapply(1:nrow(grid), function(i) {
        tags$tr(lapply(1:ncol(grid), function(j) {
          val <- grid[i, j]
          btn_id <- paste0("cell_", i, "_", j)
          if (is.na(grille_val()[i, j])) {
            label_text <- ifelse(is.na(val), " ", as.character(val))
            tags$td(actionButton(btn_id, label = label_text, class = "case-button"))
          }
          else {
            case_class <- if (niveau == "Bonus") {"gold-case"} else {"case" }
            tags$td(actionButton(btn_id, label = as.character(val), class = case_class))
  }}))}))))})

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
  })}}})

  observeEvent(input$nouvelle_partie, {
    niveau = niveau_select()
    debut_temps(Sys.time())  # Initialiser le temps de début
    depart_chrono(TRUE)
    timer_actif(TRUE)
    req(niveau_select())
    init_game(niveau)
    show_game_page(niveau)
  })

  observeEvent(input$back_to_home, {
    runjs("document.body.style.background = 'none';")
    grille_val(NULL)
    niveau_select(NULL)
    output$niveau_page <- renderUI({ NULL })
    output$jeu_page <- renderUI({ NULL })

    output$accueil_page <- renderUI({
      tagList(
        div(class="responsive-accueil",
        div(class = "background"),
        div(style = "text-align: center; margin-top: 50px;",
            h1("Le Fou Takuzu !", class ="title-text"),
            tags$div(
              class = "center-button",actionButton("start_game", "Commencer le jeu", class = "classic-button"),
              tags$br(), tags$br(),
              actionButton("regles", "Règles du jeu", class = "classic-button"))
        ))
      )
    })
    output$timer <- renderText({NULL})
  })

  observeEvent(input$abandon, {
    grille_val(NULL)
    niveau_select(NULL)
    output$timer <- renderText({NULL})
    output$niveau_page <- renderUI({
      div(class="centre",h2("Choisissez un niveau de difficulté :",class="titre"),
          div(
            class = "button-row",
            actionButton("niveau_facile", "Facile", class = "classic-button"),
            actionButton("niveau_moyen", "Moyen", class = "classic-button"),
            actionButton("niveau_difficile", "Difficile", class = "classic-button")),
          h2("...ou testez la grille bonus :", class="titre"),
          actionButton("grille_bonus", "Grille Bonus", class = "gold-button"),
          actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
  )})})

  observeEvent(input$recommencer, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    timer_actif(TRUE)
    req(user_grille$grid, grille_val())
    # Réinitialiser seulement les cases modifiables
    new_grid <- user_grille$grid  # Copie de la grille actuelle
    for (i in 1:nrow(new_grid)) {
      for (j in 1:ncol(new_grid)) {
        if (is.na(grille_val()[i, j])) {  # Si la case est modifiable
          new_grid[i, j] <- NA  # On la remet vide
        }
      }
    }

    user_grille$grid <- new_grid
  })

}

shinyApp(ui, server)
