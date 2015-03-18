
# Coursera : Developing Data products
# Author : courserans

library(shiny)
library(ggplot2)
library(gridExtra)

shinyServer(
    function(input, output) {
        
        sample.mean.r <- reactive({
            set.seed(100)
            sample.mean <- NULL
            nosim <- input$sim
            for (i in 1:nosim) {
                sample.mean[i] <- mean(rexp(input$n,input$lambda)) 
            }
            sample.mean
        })      
        output$text1 <- renderText({
            paste("No. of Observations :", input$n)
        })
        output$text2 <- renderText({
            paste("Lambda :", input$lambda)
        })
        output$text3 <- renderText({
            paste("No of Simulations :", input$sim)
        })
        output$text4 <- renderText({
            Theoretical.mean <- round(1/input$lambda,2)
            paste("Theoretical Mean :", Theoretical.mean)
        })
        output$text5 <- renderText({
            Observed.mean <- round(mean(sample.mean.r()),2)
            paste("ObservedMean :", Observed.mean)
        })
        output$text6 <- renderText({
            Theoretical.variance <- round((1/input$lambda)^2/input$n,2)
            paste("Theoretical Variance :", Theoretical.variance)
        })
        output$text7 <- renderText({
            paste("Observed Variance :",round(var(sample.mean.r()),2))
        })

        
        output$newHist <- renderPlot({
            
            sample.mean <- sample.mean.r()
            Observed.mean <- mean(sample.mean)
            Observed.variance <- var(sample.mean)
            Theoretical.mean <- 1/input$lambda
            Theoretical.variance <- (1/input$lambda)^2/input$n
            dat <- as.data.frame(sample.mean)
            
            g1 <- ggplot(dat, aes(x = sample.mean)) + 
                geom_histogram(alpha = .20, binwidth=.1, colour = "black",aes(y = ..density..))
            g1 <- g1 + stat_function(fun = dnorm, colour = "red", arg = list(mean = Theoretical.mean, sd=sqrt(Theoretical.variance)))
            g1 <- g1 + geom_vline(xintercept = mean(sample.mean), color = "blue")
            g1 <- g1 + geom_vline(xintercept = Theoretical.mean, color = "red")
            g1 <- g1 + labs(x = "Sample Means", y = "Frequency")
            g1 <- g1 + theme_bw()
            g2 <- ggplot(dat, aes(sample = sample.mean)) + stat_qq()
            g2 <- g2 + labs(x = "Theoretical Quantiles", y = "Sample Means") 
            g2 <- g2 + theme_bw()
            grid.arrange(g1,g2,nrow=2)
        })
        
    }
)