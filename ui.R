library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Sinh-arcsinh transformation"),
  fluidRow(column(width = 12, 'Sinh-arcsinh transformation to generate a 
                  family of transformation based on the normal CDF. This family
                  of transformation allows to model skewness and kurtosis. The method is
                  based on Jones, M. C. and Pewsey A. (2009). Sinh-arcsinh 
                  distributions. Biometrika 96: 761–780. The code is based on the
                  answer provided on Stack Overflow.')), 
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
      plotOutput("distPlot")
    )
  )
))