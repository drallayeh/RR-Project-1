# Shiny Application and Reproducible Pitch Course project

### Abdou Allayeh
### 15-09-2020

## Instructions

This project consists of two parts. First, we will create a Shiny application and deploy it on Rstudio's servers. Second, we will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about the application.

## Shiny Application

- Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.

- Deploy the application on Rstudio's shiny server

- Share the application link by pasting it into the provided text box

- Share your server.R and ui.R code on github

- The application must include the following:

- Some form of input (widget: textbox, radio button, checkbox, ...)

- Some operation on the ui input in sever.R

- Some reactive output displayed as a result of server calculations

- You must also include enough documentation so that a novice user could use your application.

- The documentation should be at the Shiny website itself. Do not post to an external link.


## Reproducible Pitch Presentation

what you need

- 5 slides to pitch our idea done in Slidify or Rstudio Presenter
- Your presentation pushed to github or Rpubs
- A link to your github or Rpubs presentation pasted into the provided text box

#...................................................................................

## Links

### Presentation URL https://rpubs.com/drallayeh/661026
### Github URL https://github.com/drallayeh/RR-Project-1/tree/master/Shiny_R_Project
### https://drallayeh.shinyapps.io/RmtCarApp/
### https://drallayeh.shinyapps.io/mtCarApp/
### https://drallayeh.shinyapps.io/RmtCarApp/?_ga=2.79008084.1356174629.1600166585-833304616.1600166585

#...................................................................................

## Codes
```{r}
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
```