# Load libraries
library(shiny)
library(caret)
library(MASS)  # For Boston dataset
library(ggplot2)

# Load and preprocess data
data("Boston")
boston_data <- Boston
boston_data$medv <- boston_data$medv * 1000  # Convert prices to dollars

# Train model
set.seed(123)
model <- train(medv ~ lstat + rm + crim, data = boston_data, method = "lm")

# UI
ui <- fluidPage(
  titlePanel("House Price Prediction"),
  sidebarLayout(
    sidebarPanel(
      numericInput("lstat", "Lower Status Population (%):", value = 10, min = 1, max = 40),
      numericInput("rm", "Number of Rooms:", value = 6, min = 3, max = 10),
      numericInput("crim", "Crime Rate (per capita):", value = 0.2, min = 0, max = 1),
      actionButton("predict", "Predict Price")
    ),
    mainPanel(
      h3("Prediction Result"),
      verbatimTextOutput("result"),
      plotOutput("predictionPlot")
    )
  )
)

# Server
server <- function(input, output) {
  observeEvent(input$predict, {
    # Input data
    new_data <- data.frame(
      lstat = input$lstat,
      rm = input$rm,
      crim = input$crim
    )
    
    # Predict house price
    prediction <- predict(model, new_data)
    
    # Display result
    output$result <- renderText({
      paste("Predicted House Price: $", round(prediction, 2))
    })
    
    # Plot input vs prediction
    output$predictionPlot <- renderPlot({
      ggplot(new_data, aes(x = lstat, y = prediction)) +
        geom_point(color = "blue") +
        theme_minimal() +
        labs(title = "Predicted House Price", x = "Lower Status Population (%)", y = "Price ($)")
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)
