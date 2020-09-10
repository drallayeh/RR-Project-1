# Developing Data Products Week 2 Assignment
## Abdou Allayeh


date()

### Install required packages 

library(knitr)
library(dplyr)
library(leaflet)

### Data collected from 
##  https://www.worldatlas.com/webimage/countrys/europe/pt.htm

### Read the Data
A <- read.csv("~/RR-Project-1/Map Project/Locations in Portugal.csv")
A <- leaflet() %>%
  addTiles() %>%  
  addMarkers(lat=38.5244,lng=-8.8882, popup="Setubal", df$population) %>%
  addMarkers(lat=41.55032,lng=-8.42005, popup="Braga", df$population) %>%
  addMarkers(lat=41.14961,lng=-8.61099, popup="Porto", df$population) %>%
  addMarkers(lat=38.71667,lng=-9.13333, popup="Lisbon", df$population) %>%
  addMarkers(lat=38.64502,lng=-9.14843, popup="Corroios", df$population) %>%
  setView (lat=41.55032, lng=-8.42005, zoom=16) 
A


