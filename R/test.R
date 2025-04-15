ui <- fluidPage(
  useShinyjs(),
  tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"), # Important pour la responsivité
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Gloria+Hallelujah&display=swap"),
  tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap"),
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/npm/canvas-confetti@1.5.1/dist/confetti.browser.min.js")
  ),

  tags$script(HTML("
  function playSound(soundFile) {
  var audio = new Audio(soundFile);

  audio.onloadedmetadata = function() {
    audio.currentTime = 1; // Démarre à 2 secondes
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

  tags$script(HTML("
    Shiny.addCustomMessageHandler('confetti', function(message) {
      confetti({
        spread: 5000,
        particleCount: 7000,  // Augmentation du nombre de confettis pour un effet plus intense
        origin: {  x: 0.5, y: 1.45  },   // Position de départ (milieu de lécran)
        gravity: 0.5,         // Gravité plus forte pour faire tomber les confettis rapidement
        startVelocity: 100,    // Vitesse plus élevée pour que lexplosion soit encore plus massive
        ticks: 200,           // Durée de vie des confettis (plus longtemps avant de disparaître)
        colors: ['#FF5733', '#FF33FF', '#33FFF3', '#FFD700', '#FF0000', '#00FF00', '#1E90FF'],
        shapes: ['circle', 'square', 'triangle'],  // Formes variées pour plus de diversité visuelle
        angle: 90,            // Direction verticale pour que les confettis tombent droit
        angleVariation: 5000,
        decay: 0.9,           // Réduction progressive de la vitesse pour simuler une chute naturelle
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

    .responsive-accueil {
      width: 100%;
      height: 100vh;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      text-align: center;
      padding: 20px;
    }

    .responsive-accueil h1 { font-size: calc(6vw + 1.5vh); }
    .responsive-accueil h2 { font-size: calc(5vw + 1vh); }
    .responsive-accueil p { font-size: calc(3vw + 0.5vh); }

    .responsive-jeu {
      width: 100%;
      height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      overflow-x: hidden;
      overflow-y: auto;
      padding: 10px;
    }

    .homepage {
      background-image: url('fond_takuzu.png');
      background-size: cover;
      background-position: -500px;
      background-attachment: fixed;
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }

    .background-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;

    background-image: url('fond_takuzu.png');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    opacity: 0.6; /* Ajuste ici la transparence de l'image */
    z-index: -1;
  }

    .parchment-button {
      background: linear-gradient(135deg, #add8e6, #4682b4);
      color: white;
      font-size: clamp(20px, 4vw, 40px); /* Taille responsive entre 20px et 40px */
      border-radius: 10px;
      padding: clamp(10px, 2vw, 20px) clamp(15px, 3vw, 30px);
      border: 1px solid #b09763;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
      font-family: 'Patrick Hand', fantasy;
      text-align: center;
      margin: 10px;
      max-width: 90%;
    }

   .case {
    width: 100%;
    height: 100%;
    font-size: 25px;
    background-color: #90b4d2;
    cursor: not-allowed;
    border-radius: 0;
   }

    .title-text {
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: clamp(50px, 10vw, 150px); /* Taille responsive */
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

    .solution-button {
      background: linear-gradient(135deg, #a8e6cf, #56ab2f);
      color: white;
      font-size: clamp(18px, 3vw, 30px);
      font-family: 'Patrick Hand', fantasy;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
      padding: clamp(5px, 1vw, 10px) clamp(15px, 2vw, 30px);
      border-radius: 10px;
      position: fixed; /* Changed from absolute */
      top: 40%;
      left: 75%;
      z-index: 100;
    }

    .new-button {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 10px;
      background: linear-gradient(135deg, #add8e6, #4682b4);
      color: white;
      font-size: clamp(18px, 3vw, 30px);
      font-family: 'Patrick Hand', fantasy;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
      padding: clamp(5px, 1vw, 10px) clamp(15px, 2vw, 30px);
      border-radius: 10px;
      position: fixed; /* Changed from relative */
      top: 20px;
      left: 20px;
      z-index: 100;
    }

    .center-button {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

    .back-button {
      background-color: #d3d3d3;
      font-family: 'Patrick Hand', fantasy;
      position: fixed; /* Changed from absolute */
      bottom: 20px;
      left: 20px;
      font-size: clamp(14px, 2vw, 20px);
      padding: clamp(5px, 1vw, 10px) clamp(15px, 2vw, 30px);
      z-index: 100;
    }

    .button-row {
      display: flex;
      flex-wrap: wrap; /* Permettre aux boutons de passer à la ligne */
      gap: clamp(10px, 3vw, 50px);
      justify-content: center;
      margin-top: 20px;
      width: 100%;
    }

    .gold-button {
      background: linear-gradient(135deg, #fced9f, #d4ae33);
      color: white;
      font-size: clamp(20px, 4vw, 40px);
      border-radius: 10px;
      padding: clamp(10px, 2vw, 20px) clamp(15px, 3vw, 30px);
      border: 1px solid #b09763;
      box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.1);
      font-family: 'Patrick Hand', fantasy;
      text-align: center;
      margin: 10px;
      max-width: 90%;
    }

    .centre, .centre1 {
      display: flex;
      font-family: 'Patrick Hand', fantasy;
      text-align: center;
      justify-content: center;
      align-items: center;
      font-size: clamp(30px, 5vw, 60px);
      flex-direction: column;
      gap: clamp(20px, 3vw, 50px);
      width: 100%;
      padding: 10px;
    }
    .gold-case {
    width: 100%;
    height: 100%;
    font-size: 25px;
    background-color: #e0c260;
    cursor: not-allowed;
    border-radius: 0;
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
      justify-content: center;
      align-items: center;
      font-size: clamp(30px, 5vw, 60px);
      flex-direction: column;
      gap: clamp(20px, 3vw, 50px);
      width: 100%;
      padding: 10px;
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

    .titre {
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: clamp(35px, 6vw, 70px);
      font-family: 'Patrick Hand', fantasy;
      font-weight: bold;
      color: skyblue;
      text-align: center;
      width: 100%;
      padding: 10px;
    }

    .abandon {
      background: linear-gradient(135deg, #ff9999, #cc0000);
      color: white;
      font-size: clamp(18px, 3vw, 30px);
      font-family: 'Patrick Hand', fantasy;
      padding: clamp(3px, 0.7vw, 5px) clamp(10px, 1.5vw, 20px);
      border-radius: 10px;
      position: fixed; /* Changed from absolute */
      bottom: 20px;
      right: 150px; /* Ajusté pour ne pas chevaucher le bouton solution */
      z-index: 100;
    }

    /* Table responsive */
    table {
      border-collapse: collapse;
      width: auto; /* Changed from 100% */
      margin: auto;
      max-width: 95vw; /* Limite la largeur à 95% de la largeur de la fenêtre */
    }

    th, td {
      border: 1px solid black;
      padding: 0;
      width: clamp(30px, 6vw, 70px); /* Taille responsive */
      height: clamp(30px, 6vw, 70px); /* Taille responsive */
      text-align: center;
      font-size: clamp(16px, 3vw, 30px);
      vertical-align: middle;
    }

    /* Media queries pour différentes tailles décran */
    @media (max-width: 768px) {
      /* Tablettes et petits écrans */
      .solution-button, .new-button {
        position: static;
        margin: 10px auto;
      }

      .button-row {
        flex-direction: column;
        align-items: center;
      }

      .abandon {
        position: static;
        margin: 10px auto;
      }

      .back-button {
        position: static;
        margin: 20px auto 10px;
      }
    }

    @media (min-width: 769px) and (max-width: 1200px) {
      /* Écrans moyens */
      .solution-button {
        top: auto;
        left: auto;
        bottom: 20px;
        right: 20px;
      }

      .abandon {
        top: auto;
        left: auto;
        bottom: 20px;
        right: 150px;
      }
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
  complete_grille <- reactiveValues(grid = NULL)
  debut_temps <- reactiveVal(NULL)
  depart_chrono <- reactiveVal(FALSE)
  timer_actif <- reactiveVal(TRUE)

  # Réactif pour ajuster la taille de la grille en fonction de la fenêtre
  grille_size <- reactive({
    # Obtenir la largeur de la fenêtre
    width <- session$clientData$url_hostname # Juste pour forcer la réactivité
    taille_min <- 30 # Taille minimale des cellules
    taille_max <- 70 # Taille maximale des cellules
    # Ajuster dynamiquement la taille
    return(list(
      cell_width = paste0(min(max(30, session$clientData$output_grille_affiche_width / 10), 70), "px"),
      cell_height = paste0(min(max(30, session$clientData$output_grille_affiche_width / 10), 70), "px"),
      font_size = paste0(min(max(16, session$clientData$output_grille_affiche_width / 20), 30), "px")
    ))
  })

  output$accueil_page <- renderUI({
    runjs("document.body.style.background = 'none';")
    tagList(
      div(class="responsive-accueil",
          div(class = "background-container"),
          div(style = "text-align: center; margin-top: 5vh;", # Utiliser vh au lieu de px
              h1("Le Fou Takuzu !", class ="title-text"),
              tags$div(
                class = "center-button",actionButton("start_game", "Commencer le jeu", class = "parchment-button"))
          ))
    )
  })

  observeEvent(input$start_game, {
    runjs("document.body.style.background = 'white';")
    output$accueil_page <- renderUI({ NULL })
    output$niveau_page <- renderUI({
      div(class="responsive-jeu", # Utiliser la classe responsive
          div(class="centre",
              h2("Choisissez un niveau de difficulté :", class="titre"),
              div(
                class = "button-row",
                actionButton("niveau_facile", "Facile", class = "parchment-button"),
                actionButton("niveau_moyen", "Moyen", class = "parchment-button"),
                actionButton("niveau_difficile", "Difficile", class = "parchment-button")),
              h2("...ou testez la grille bonus :", class="titre"),
              actionButton("grille_bonus", "Grille Bonus", class = "gold-button"),
              actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
          ))
    })
  })

  # Fonction init_game inchangée
  init_game <- function(niv) {
    g <- grille(niv)
    grille_val(g$solution)
    user_grille$grid <- g$solution
    complete_grille$grid <- g$grille_complete
  }

  # Création d'une fonction pour le rendu du timer (pour éviter la répétition)
  render_timer <- function() {
    renderText({
      req(debut_temps(), depart_chrono())
      if (timer_actif()) {
        invalidateLater(1000, session)
        temps_ecoule <- as.integer(difftime(Sys.time(), debut_temps(), units = "secs"))
        sprintf("%02d:%02d:%02d", temps_ecoule %/% 3600, (temps_ecoule %% 3600) %/% 60, temps_ecoule %% 60)
      } else {
        return("00:00:00")
      }
    })
  }

  # Observer pour le niveau facile - simplifié
  observeEvent(input$niveau_facile, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })
    output$timer <- render_timer()
    niveau_select("Facile")
    init_game("Facile")
    show_game_page("Facile")
  })

  # Observer pour le niveau moyen - simplifié
  observeEvent(input$niveau_moyen, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })
    output$timer <- render_timer()
    niveau_select("Moyen")
    init_game("Moyen")
    show_game_page("Moyen")
  })

  # Observer pour le niveau difficile - simplifié
  observeEvent(input$niveau_difficile, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })
    output$timer <- render_timer()
    niveau_select("Difficile")
    init_game("Difficile")
    show_game_page("Difficile")
  })

  # Observer pour la grille bonus - mise à jour pour la responsivité
  observeEvent(input$grille_bonus, {
    debut_temps(Sys.time())
    depart_chrono(TRUE)
    output$niveau_page <- renderUI({ NULL })
    output$timer <- render_timer()
    niveau_select("Bonus")
    init_game("Bonus")

    output$niveau_page <- renderUI({
      tagList(div(class ="responsive-jeu",
                  div(id = "timer_container",
                      class = "timer-display", # Nouvelle classe CSS
                      textOutput("timer")),
                  h2("Grille Bonus", class = "centre1"), # Utiliser la classe titre pour la cohérence
                  div(class = "centre1", # Nouvelle classe pour le conteneur de jeu
                      uiOutput("grille_affiche")),
                  div(class = "button-container", # Conteneur flexbox pour les boutons
                      actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
                      actionButton("recommencer", "Recommencer", class = "new-gold-button"),
                      actionButton("solution", "Solution", class="solution-button"),
                      actionButton("verifier", "Vérifier", class = "new-gold-button"),
                      actionButton("abandon", "Abandonner", class = "abandon")
                  )
      ))
    })
  })

  # Fonction show_game_page mise à jour pour le responsive
  show_game_page <- function(title) {
    output$niveau_page <- renderUI({
      tagList(div(class ="responsive-jeu",
                  div(id = "timer_container",
                      class = "timer-display", # Nouvelle classe CSS
                      textOutput("timer")),
                  h2(title, class = "centre1"), # Utiliser la classe titre pour la cohérence
                  div(class = "centre1", # Nouvelle classe pour le conteneur de jeu
                      uiOutput("grille_affiche")),
                      actionButton("verifier", "Vérifier", class = "new-button"),
                      actionButton("solution", "Solution", class="solution-button"),
                      actionButton("recommencer", "Recommencer", class = "new-button"),
                      actionButton("nouvelle_partie", "Nouvelle partie", class = "new-button"),
                      actionButton("back_to_home", "Retour à l'accueil", class = "back-button"),
                      actionButton("abandon", "Abandonner", class = "abandon")
                  )
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
  # Vérifiez si la grille est bien définie avant de l"utiliser
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

  # Utiliser une classe conteneur pour centrer la table
  tagList(
    div(class="centre",
        tags$table(
          lapply(1:nrow(grid), function(i) {
            tags$tr(
              lapply(1:ncol(grid), function(j) {
                val <- grid[i, j]
                btn_id <- paste0("cell_", i, "_", j)
                if (is.na(grille_val()[i, j])) {
                  label_text <- ifelse(is.na(val), " ", as.character(val))
                  tags$td(actionButton(btn_id, label = label_text, class = "case-button"))
                }
                else {
                  case_class <- if (niveau == "Bonus") {"gold-case"} else {"case"}
                  tags$td(actionButton(btn_id, label = as.character(val), class = case_class))
                }
              })
            )
          })
        )
    ))
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
          div(class = "background-container"),
          div(style = "text-align: center; margin-top: 5vh;", # vh au lieu de px
              h1("Le Fou Takuzu !", class ="title-text"),
              tags$div(
                class = "center-button",actionButton("start_game", "Commencer le jeu", class = "parchment-button"))
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
          actionButton("niveau_facile", "Facile", class = "parchment-button"),
          actionButton("niveau_moyen", "Moyen", class = "parchment-button"),
          actionButton("niveau_difficile", "Difficile", class = "parchment-button")),
        h2("...ou testez la grille bonus :", class="titre"),
        actionButton("grille_bonus", "Grille Bonus", class = "gold-button"),
        actionButton("back_to_home", "Retour à l'accueil", class = "back-button")
    )})})

observeEvent(input$recommencer, {
  debut_temps(Sys.time())  # Initialiser le temps de début
  depart_chrono(TRUE)
  timer_actif(TRUE)
  req(user_grille$grid, grille_val())  # Vérifier que les données existent
  # Réinitialiser seulement les cases modifiables
  new_grid <- user_grille$grid  # Copie de la grille actuelle
  for (i in 1:nrow(new_grid)) {
    for (j in 1:ncol(new_grid)) {
      if (is.na(grille_val()[i, j])) {  # Si la case est modifiable
        new_grid[i, j] <- NA  # On la remet vide
      }
    }
  }

  user_grille$grid <- new_grid  # Mise à bonus de la grille affichée
})

}

shinyApp(ui, server)
