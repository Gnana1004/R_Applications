install.packages("shiny")
library(shiny)

library(shiny)

library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Student Details Form"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Name:", ""),
      numericInput("usn", "USN:", ""),
      textInput("email", "Email:", ""),
      actionButton("submit", "Submit")
    ),
    
    mainPanel(
      textOutput("result")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  observeEvent(input$submit, {
    name <- input$name
    usn<- input$usn
    email <- input$email
    
    output$result <- renderText({
      paste("Submitted Details:\n",
            "Name:", name, "\n",
            "USN:", usn, "\n",
            "Email:", email)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
rsconnect::deployApp('C://Users/Dudi//OneDrive//Documents//R applications//')


