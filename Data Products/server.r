library(shiny)
library(ggplot2)
library(plyr)

shinyServer(function(input, output) {
  diamonds <- rename(diamonds, c("carat" = "V1", "cut" = "V2", "color" = "V3", "clarity" = "V4", "depth" = "V5", "table" = "temperature"))
  dataset <- reactive(function() {
    diamonds[sample(nrow(diamonds), input$sampleSize),]
  })
  
  output$plot <- reactivePlot(function() {
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=700)
  
})
