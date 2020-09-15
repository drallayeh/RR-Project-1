# Abdou Allayeh
# 15 September 2020

# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
