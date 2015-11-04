library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Sinh-arcsinh transformation"),
  fluidRow(column(width = 12, 
p('Sinh-arcsinh transformation generates a 
                  family of transformation based on the normal density function. This family
                  of transformation allows to model skewness and kurtosis. The method is
                  based on', span(tags$a(href = "http://biomet.oxfordjournals.org/content/96/4/761.short", "Jones, M. C. and Pewsey A. Sinh-arcsinh distributions. Biometrika 96: 761–780")), 'The code is based on the
                  answer provided on', span(tags$a(href = "http://stats.stackexchange.com/questions/43482/transformation-to-increase-kurtosis-and-skewness-of-normal-r-v", "Stack Overflow")), "."))), 
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("epsilon",
                  "Epsilon:",
                  min = -2,
                  max = 2,
                  value = 0, 
                  step = 0.1),
      sliderInput("delta",
                  "Delta:",
                  min = 0,
                  max = 4,
                  value = 0, 
                  step = 0.1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      fluidRow(column(width = 3, offset = 1, tableOutput("summaryTab") ))
    )
  )
))