library(shiny)

ui <- fluidPage(
  titlePanel("Predictive Analytics Dashboard"),
  sidebarLayout(
    sidebarPanel(
      fileInput("datafile", "Upload CSV File"),
      actionButton("analyze", "Analyze Data")
    ),
    mainPanel(
      tableOutput("dataSummary"),
      plotOutput("dataPlot")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$analyze, {
    req(input$datafile)
    data <- read.csv(input$datafile$datapath)
    
    output$dataSummary <- renderTable({
      summary(data)
    })
    
    output$dataPlot <- renderPlot({
      plot(data[[1]], data[[2]], main = "Simple Data Plot", xlab = "X", ylab = "Y")
    })
  })
}

shinyApp(ui = ui, server = server)
