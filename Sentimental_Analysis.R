library(shiny)

ui <- fluidPage(
  titlePanel("Sentiment Analysis"),
  sidebarLayout(
    sidebarPanel(
      textAreaInput("text", "Enter Text:", rows = 5),
      actionButton("analyze", "Analyze Sentiment")
    ),
    mainPanel(
      textOutput("sentiment")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$analyze, {
    text <- input$text
    sentiment <- ifelse(grepl("good|happy|great", text, ignore.case = TRUE), "Positive", "Negative")
    
    output$sentiment <- renderText({
      paste("Sentiment:", sentiment)
    })
  })
}

shinyApp(ui = ui, server = server)

