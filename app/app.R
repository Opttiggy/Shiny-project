library(shiny)
library(shinydashboard)
library(sf)

# Define UI for app that draws a histogram ----
ui <- dashboardPage(
  dashboardHeader(title = "Shiny Project"),
  dashboardSidebar(
    sliderInput("slider", "Number of observations:", 1, 100, 50)
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      tabBox(
        title = "Content",
        id = "tabset1",
        height = 250,
        tabPanel("Map", plotOutput("plot", height=250)),
        tabPanel("Data", tableOutput("table"))
      ),
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  layers <- "../BCBoundary 2020.gpkg"
  
  ## you may have more than one layer
  BCB2020 <- st_read(layers)
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })

  output$table <- renderTable(BCB2020)
}

shinyApp(ui = ui, server = server)