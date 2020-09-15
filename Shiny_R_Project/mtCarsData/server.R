# App Project- Abdou Allayeh
# 15 September 2020

# Abdou Allayeh, App

# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(colourpicker)
library(htmlwidgets)
library(plotly)
library(shinycustomloader)
data(mtcars)

# Define server logic required to draw a histogram
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

