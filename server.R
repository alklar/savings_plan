#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
# http://shiny.rstudio.com/
#
# Monthly Savings Plan
# Author: Alexander Klar
# Developing Data Products Assignment Week 4
# December 30, 2016

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # create a data frame that contains the paiments and balance for each year  
  calcSavingsDF <- reactive({
    
    # read in input values
    years <- input$years
    savings <- input$savings
    anReturns <- input$annualReturns
    oneYear <- 0
    paid <- 12*savings
    # calculate balance for the first year
    if (input$day == "first"){
      oneYear <- 12*savings + 6.5 * anReturns * savings / 100
    }
    if (input$day == "last"){
      oneYear <- 12*savings + 5.5 * anReturns * savings / 100
    }
    
    totalBalance <- oneYear
    savingsDF <- data.frame(year = 1, ammountPaid = paid, totalBalance = totalBalance )
    
    if(years > 1){
      for(i in 2:years){
        paid <- paid + 12*savings
        totalBalance <- totalBalance * (1 + anReturns/100) + oneYear
        savingsDF[i,] <- c(i, paid, totalBalance)
      }
    }
    savingsDF
  })
  
  # create the output plot  
  output$savingsPlot <- renderPlot({
    
    savingsDF <- calcSavingsDF()
    totalBalance <- calcSavingsDF()[input$years,3]
    
    r <- barplot(savingsDF$totalBalance/1000, names.arg = savingsDF$year, main = "Total Balance in 1000 €", xlab = "Years",
                 ylim = c(0, totalBalance/800), col = "blue")
    lines(r, savingsDF$ammountPaid/1000, type = "h", col = "red", lwd = 4)
    
  })

  # also show final balance and amount paid  
  output$finalBalance <-  renderText({paste("Your final balance is: ", round(calcSavingsDF()[input$years,3],2), " Euro.")
  }) 
  output$paidByYou <- renderText({paste("You paid: ", calcSavingsDF()[input$years,2], " Euro.")
  }) 
  
})
