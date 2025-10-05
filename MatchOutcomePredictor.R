library(shiny)
library(plotly)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Match Outcome Predictor"),
  
  # Main tabs
  tabsetPanel(
    tabPanel("Results by Team", 
             sidebarLayout(
               sidebarPanel(
                 h3("Instructions:"),
                 p("Select the results of the last 5 matches played by two teams seperately."),
                 hr(),
                 h3("Results of Last 5 Matches - Team 1"),
                 selectInput("team1_result1", "Match 1 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team1_result2", "Match 2 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team1_result3", "Match 3 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team1_result4", "Match 4 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team1_result5", "Match 5 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 
                 hr(),
                 h3("Results of Last 5 Matches - Team 2"),
                 selectInput("team2_result1", "Match 1 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team2_result2", "Match 2 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team2_result3", "Match 3 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team2_result4", "Match 4 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 selectInput("team2_result5", "Match 5 Result:", choices = c("Win", "Loss", "Draw"), selected = "Win"),
                 
                 actionButton("predict_button_team", "Calculate")
               ),
               mainPanel(
                 h3("Prediction Probabilities:"),
                 verbatimTextOutput("prediction_output_team"),
                 plotlyOutput("pie_chart_team")
               )
             )
    ),
    tabPanel("Results Together",
             sidebarLayout(
               sidebarPanel(
                 h3("Instructions:"),
                 p("Select the results of the last 5 matches played by two teams together; either Team 1 or Team 2 won."),
                 hr(),
                 h3("Results of Last 5 Matches"),
                 selectInput("team1_result1_together", "Match 1 Result:", choices = c("Team 1", "Team 2"), selected = "Team 1"),
                 selectInput("team1_result2_together", "Match 2 Result:", choices = c("Team 1", "Team 2"), selected = "Team 1"),
                 selectInput("team1_result3_together", "Match 3 Result:", choices = c("Team 1", "Team 2"), selected = "Team 1"),
                 selectInput("team1_result4_together", "Match 4 Result:", choices = c("Team 1", "Team 2"), selected = "Team 1"),
                 selectInput("team1_result5_together", "Match 5 Result:", choices = c("Team 1", "Team 2"), selected = "Team 1"),
                 
                 actionButton("predict_button_together", "Calculate")
               ),
               mainPanel(
                 h3("Prediction Probabilities:"),
                 verbatimTextOutput("prediction_output_together"),
                 plotlyOutput("pie_chart_together")
               )
             )
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Prediction logic for team results
  observeEvent(input$predict_button_team, {
    # Extract user inputs
    team1_results <- c(input$team1_result1, input$team1_result2, input$team1_result3,
                       input$team1_result4, input$team1_result5)
    team2_results <- c(input$team2_result1, input$team2_result2, input$team2_result3,
                       input$team2_result4, input$team2_result5)
    
    # Calculate winning probabilities
    team1_wins <- sum(team1_results == "Win")
    team2_wins <- sum(team2_results == "Win")
    total_wins <- length(team1_results)
    team1_win_prob <- max(team1_wins / total_wins, 0)
    team2_win_prob <- max(team2_wins / total_wins, 0)
    draw_prob <- max(1 - (team1_win_prob + team2_win_prob), 0)
    
    # Normalize probabilities to sum up to 100%
    total_prob <- team1_win_prob + team2_win_prob + draw_prob
    if(total_prob != 0) {
      team1_win_prob <- team1_win_prob / total_prob * 100
      team2_win_prob <- team2_win_prob / total_prob * 100
      draw_prob <- draw_prob / total_prob * 100
    }
    
    # Display prediction probabilities
    output$prediction_output_team <- renderPrint({
      paste("Probability of Team 1 Winning:", round(team1_win_prob, 2), "%\n",
            "Probability of Team 2 Winning:", round(team2_win_prob, 2), "%\n",
            "Probability of Draw:", round(draw_prob, 2), "%")
    })
    
    # Create pie chart for team prediction
    output$pie_chart_team <- renderPlotly({
      labels <- c("Team 1 Win", "Team 2 Win", "Draw")
      values <- c(team1_win_prob, team2_win_prob, draw_prob)
      plot_ly(labels = labels, values = values, type = "pie") %>%
        layout(title = "Prediction Probabilities for Team Results")
    })
  })
  
  # Prediction logic for combined results
  observeEvent(input$predict_button_together, {
    # Extract user inputs
    team1_results <- c(input$team1_result1_together, input$team1_result2_together, input$team1_result3_together,
                       input$team1_result4_together, input$team1_result5_together)
    team2_results <- c(input$team2_result1_together, input$team2_result2_together, input$team2_result3_together,
                       input$team2_result4_together, input$team2_result5_together)
    
    # Calculate winning probabilities
    team1_wins <- sum(team1_results == "Team 1")
    team2_wins <- sum(team1_results == "Team 2")
    total_wins <- length(team1_results)
    team1_win_prob <- max(team1_wins / total_wins, 0)
    team2_win_prob <- max(team2_wins / total_wins, 0)
    draw_prob <- max(1 - (team1_win_prob + team2_win_prob), 0)
    
    # Normalize probabilities to sum up to 100%
    total_prob <- team1_win_prob + team2_win_prob + draw_prob
    if(total_prob != 0) {
      team1_win_prob <- team1_win_prob / total_prob * 100
      team2_win_prob <- team2_win_prob / total_prob * 100
      draw_prob <- draw_prob / total_prob * 100
    }
    
    # Display prediction probabilities
    output$prediction_output_together <- renderPrint({
      paste("Probability of Team 1 Winning:", round(team1_win_prob, 2), "%\n",
            "Probability of Team 2 Winning:", round(team2_win_prob, 2), "%\n",
            "Probability of Draw:", round(draw_prob, 2), "%")
    })
    
    # Create pie chart for combined prediction
    output$pie_chart_together <- renderPlotly({
      labels <- c("Team 1 Win", "Team 2 Win", "Draw")
      values <- c(team1_win_prob, team2_win_prob, draw_prob)
      plot_ly(labels = labels, values = values, type = "pie") %>%
        layout(title = "Prediction Probabilities for Combined Results")
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
