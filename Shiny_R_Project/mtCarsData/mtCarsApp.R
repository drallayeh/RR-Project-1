library(shiny)
library(ggplot2)
library(dplyr)
library(htmlwidgets)
data(mtcars)

ui <- fluidPage(
  titlePanel("Car Data App"),
  sidebarLayout(
    sidebarPanel(
      uiOutput("mtcars2"),
      downloadButton("download_data")
    ),
    mainPanel(
      plotOutput("hist"),
      br(), br()
    )
  )
)


server <- function(input, output) {
  output$mtcars2 <- renderUI({
    selectInput("cars", "cyl",
                sort(unique(mtcars$cyl)),
                selected = "4")
  })  
  
  filtered <- reactive({
    if (is.null(input$cars)) {
      return(NULL)
    }    
    
    mtcars %>%
      filter(cyl == input$cars
      )
  })
  
  output$download_data <- downloadHandler(
    filename = function() {
      paste(mtcars2)
    },
    content = function(file) {
      write.csv(filtered(), file)
    }
  )
  
  output$hist <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(disp)) +
      geom_histogram()
  })
  
}

shinyApp(ui=ui,server=server)