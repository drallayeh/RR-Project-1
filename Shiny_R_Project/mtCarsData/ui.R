# App Project- Abdou Allayeh
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
library(htmlwidgets)

data(mtcars)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
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