library(shiny)

# Define UI for application that predicts the value of a suburban house in Boston in 1978
shinyUI(fluidPage(
    
  # Changing main font
  tags$head(tags$style(HTML(
      "body{font-family: Roboto;}"
  ))),
  
  # Application title
  titlePanel("Predict Boston Housing price in 1978"),
  p("Author: Thiago Melo"),
  p("Boston Housing Data | Origin: This dataset was taken from the StatLib library 
    which is maintained at Carnegie Mellon University | Available at: 
    https://archive.ics.uci.edu/ml/machine-learning-databases/housing/"),
  br(),
  h4("Supporting documentation:"),
  p("This app is designed to predict the value of a 
    typical suburban house in Boston in 1978, adjusted for inflation. 
    In order to use it, simply move the slides on the left to your desired value
    and observe how the predicted price changes both in value and in the provided graphs."),
  br(),
  
  # Sidebars with sliders for selecting the value of predictors
  sidebarLayout(
    sidebarPanel(
       p("Select the values for each variable:"),
       sliderInput("CRIM","Per capita crime rate",0,60,0),
       sliderInput("NOX","Nitric oxides concentration (parts per 10 million)",0.4,0.6,0.4),
       sliderInput("RM","Number of rooms per dwelling",4,9,4),
       sliderInput("DIS","Weighted distances to five Boston employment centres",1,9,1,step = 0.1)
    ),
    
    # Main panel where the predicted value and graphs are displayed
    mainPanel(
        h4("Predicted house price in 2018 dollars:*"),
        p("*Negative values can be expected due to the nature of the linear model used."),
        br(),
        htmlOutput("pred", container = tags$mark),
        plotOutput("plot")
    )
  )
))
