library(shiny)
library(ggplot2)
library(scales)

# Load your game function
source("R/game.R")

# Define UI
ui <- fluidPage(
  titlePanel("Simulation of Gambling for The Night"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("num_games", "Number of Games Played", min = 100, max = 100000, value = 1000),
      sliderInput("win_probability", "Probability of Winning a Game", min = 0, max = 1, value = 0.5),
      sliderInput("money_per_game", "Cost to Play a Game", min = 1, max = 100, value = 10)
    ),
    mainPanel(
      plotOutput("game_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Reactive expression for the game plot
  output$game_plot <- renderPlot({
    num_games <- input$num_games
    win_probability <- input$win_probability
    money_per_game <- input$money_per_game
    
    # Call the game function
    game_plot <- game(
      num_games = num_games,
      win_probability = win_probability,
      money_per_game = money_per_game
    )
    
    # Display the ggplot
    print(game_plot)
  })
}

# Run the Shiny app
shinyApp(ui, server)
