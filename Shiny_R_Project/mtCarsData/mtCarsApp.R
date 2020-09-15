library(shiny)
library(ggplot2)
library(dplyr)
library(colourpicker)
library(htmlwidgets)
library(plotly)
library(shinycustomloader)
data(mtcars)

ui <- fluidPage(
  titlePanel("Car Data App"),
  sidebarLayout(
    sidebarPanel(
      textInput("title", "Title"),
      numericInput("size", "Point size", 1, 1),
      colourInput("color", "Point color", value = "red"),
      uiOutput("mtcars2"),
          ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  
                  tabPanel("Plot", withLoader(plotlyOutput("plot"))))
                )
  )
)

server <- function(input, output) {
  output$mtcars2 <- renderUI({
    selectInput("cars", "cyl", 
                sort(unique(mtcars$cyl)), selected = "4")
    })  
  
  filtered <- reactive({
    if (is.null(input$cars)) {
      return(NULL)
    }    
        mtcars %>%
      filter(cyl == input$cars)
      })
  
  output$plot <- renderPlotly({
      if (is.null(filtered())) {
        return()
      }
      
      ggplotly({
        data <- filtered()
        
        p <- ggplot(data, aes(disp, cyl)) +
          geom_point(size = input$size, col = input$color) +
          scale_x_log10() +
          ggtitle(input$title) 
        p
        })
  })
}

shinyApp(ui=ui,server=server)

