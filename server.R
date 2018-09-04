library(shiny)

# Define server logic required to predict the value of a suburban house in Boston in 1978
shinyServer(function(input, output) {
   
    # Reading data from the web and cleaning it
    link <- c("https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data")
    housing <- read.table(link, quote="\"", comment.char="")
    data <- housing[,c(1,5,6,8,14)]
    colnames(data) <- c("CRIM","NOX","RM","DIS","MEDV")
    
    # Correcting for inflation from 1978 to 2018
    data$MEDV <- data$MEDV*3.97*1000
    
    # Creating linear model
    fit <- lm(data = data, MEDV ~ .)
    
    # Calculating prediction based on the values inputed by the user
    fitpred <- reactive({
        CRIM <- input$CRIM
        NOX <- input$NOX
        RM <- input$RM
        DIS <- input$DIS
        predict(fit, newdata = data.frame(CRIM = CRIM, NOX = NOX, RM = RM, DIS = DIS))
    })
    
    # Exporting the predicted value to the UI
    output$pred <- renderUI({
        HTML(paste("Predicted value: R$", round(fitpred(), 2)))
    })
    
    # Exporting the 4 graphs (one for each predictor) to the UI
    output$plot <- renderPlot({
        par(mfrow=c(2,2))
        plot(data$CRIM, data$MEDV, xlab = "Per capita crime rate", 
             ylab = "House value in 2018 US$", col = "#80777777", pch = 16)
        points(y = fitpred(), x = input$CRIM, col = "dodgerblue", pch = 16, cex = 2)
        plot(data$NOX, data$MEDV, xlab = "Nitric oxides concentration (parts per 10 million)", 
             ylab = "House value in 2018 US$", col = "#80777777", pch = 16)
        points(y = fitpred(), x = input$NOX, col = "dodgerblue", pch = 16, cex = 2)
        plot(data$RM, data$MEDV, xlab = "Number of rooms per dwelling", 
             ylab = "House value in 2018 US$", col = "#80777777", pch = 16)
        points(y = fitpred(), x = input$RM, col = "dodgerblue", pch = 16, cex = 2)
        plot(data$DIS, data$MEDV, xlab = "Weighted distances to five Boston employment centres", 
             ylab = "House value in 2018 US$", col = "#80777777", pch = 16)
        points(y = fitpred(), x = input$DIS, col = "dodgerblue", pch = 16, cex = 2)
    })
  
})
