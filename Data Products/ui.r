library(shiny)
library(ggplot2)
library(plyr)

diamonds <- rename(diamonds, c("carat" = "V1", "cut" = "V2", "color" = "V3", "clarity" = "V4", "depth" = "V5", "table" = "temperature"))
dataset <- diamonds



shinyUI(pageWithSidebar(
  
  headerPanel("Solar Panel Explorer"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(1000, nrow(dataset)), step=500, round=0),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
    
    selectInput('facet_row', 'Quality Row', c(None='.', names(dataset))),
    selectInput('facet_col', 'Quality Column', c(None='.', names(dataset)))
  ),
  
  mainPanel(
    plotOutput('plot')
  )
))
