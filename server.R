library(shiny)
library(ggplot2)
library(reshape2)

norm2skew <- function(x, epsilon, delta){
  res <- dnorm(sinh(delta * asinh(x) - epsilon)) * 
    delta * 
    cosh(delta * asinh(x) - epsilon)/
    sqrt(1 + x^2)
  return(res)
} 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  data.quantiles <- seq(-7, 7, 0.01)
  data.original <- dnorm(data.quantiles)
  output$distPlot <- renderPlot({
  data.transform <- norm2skew(data.quantiles, input$epsilon, input$delta)
  df <- data.frame(quantiles = data.quantiles, 
                     original = data.original, 
                     transformed = data.transform)
  df.melt <- melt(df, id.vars = "quantiles")
  ggplot(df.melt, aes(quantiles, value, color = variable)) + geom_point() +
    scale_color_manual(values = c("blue", "red"), name = "data") +
    scale_y_continuous(breaks = seq(0, 2, 0.1)) +
    scale_x_continuous(breaks = seq(-7, 7, 1)) +
    ylab("") + 
    xlab("quantiles")
    })
})