library(shiny)

ui <- fluidPage(
  titlePanel("Financial Risk Simulator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("investment", "Initial Investment:", value = 10000),
      sliderInput("returnRate", "Expected Return Rate (%):", min = 0, max = 20, value = 5),
      actionButton("simulate", "Run Simulation")
    ),
    mainPanel(
      plotOutput("simulationPlot")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$simulate, {
    simulations <- rnorm(1000, mean = input$returnRate / 100, sd = 0.02)
    portfolio <- input$investment * (1 + simulations)
    
    output$simulationPlot <- renderPlot({
      hist(portfolio, col = "lightgreen", main = "Simulated Portfolio Value")
    })
  })
}

shinyApp(ui = ui, server = server)
