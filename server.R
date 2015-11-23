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

dataSummary <- function(x){
  summary.stats <- round(c(mean(x), median(x), sd(x)), digits = 7)
  names(summary.stats) <- c("mean", "median", "sd")
  return(summary.stats)
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  set.seed(123)
  data.quantiles <- reactive({seq(as.numeric(input$quantiles[1]), 
                                  as.numeric(input$quantiles[2]), 
                                  by = 0.01)})
  data.original <- reactive({dnorm(seq(as.numeric(input$quantiles[1]), 
                                       as.numeric(input$quantiles[2]), 
                                       by = 0.01))})
  data.transform <- reactive({
    data.quantiles <- seq(as.numeric(input$quantiles[1]), 
                          as.numeric(input$quantiles[2]), 
                          by = 0.01)
    norm2skew(data.quantiles, input$epsilon, input$delta)
  })
  output$distPlot <- renderPlot({
  df <- data.frame(quantiles = data.quantiles(), 
                     original = data.original(), 
                     transformed = data.transform())
  df.melt <- melt(df, id.vars = "quantiles")
  ggplot(df.melt, aes(quantiles, value, color = variable)) + geom_point() +
    scale_color_manual(values = c("blue", "red"), name = "data") +
    scale_y_continuous(breaks = seq(0, 2, 0.1)) +
    scale_x_continuous(breaks = seq(-20, 20, 1))+
    ylab("") + 
    xlab("quantiles")
    })
  output$summaryTab <- renderTable({
    df <- data.frame(quantiles = data.quantiles(), 
                     original = data.original(), 
                     transformed = data.transform())
    df.melt <- melt(df, id.vars = "quantiles")
    as.data.frame(sapply(df[,-1], dataSummary))
  })
})