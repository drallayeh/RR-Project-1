# App Project- Abdou Allayeh
# 15 September 2020

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
library(htmlwidgets)

# Define server logic required to draw a histogram
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