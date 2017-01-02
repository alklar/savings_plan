#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
# http://shiny.rstudio.com/
#
# Monthly Savings Plan
# Author: Alexander Klar
# Developing Data Products Assignment Week 4
# December 30, 2016

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Monthly Savings Plan"),
  
  # Sidebar with 3 sliders and a checkbox 
  sidebarLayout(
    sidebarPanel(
      sliderInput("savings",
                  "Monthly Savings (in €):",
                  min = 0,
                  max = 2000,
                  value = 100),
      sliderInput("years",
                  "Savings Plan duration in years:",
                  min = 1,
                  max = 50,
                  value = 30),
      sliderInput("annualReturns",
                  "Annual returns in %:",
                  min = 0,
                  max = 100,
                  value = 6),
      radioButtons("day", "On which day of the month do you want to pay into your savings plan?",
                   c("First Day" = "first",
                     "Last Day" = "last"))
    ),
    
    # Show a plot of the savings plan and some additional information
    mainPanel(
      h3("Choose your values from the sidebar to calculate your savings plan:"),
      plotOutput("savingsPlot", height = "300px"),
      strong(textOutput("finalBalance")),
      strong(textOutput("paidByYou")),
      br(),
      h6("Annual returns depend on the investment type."),
      h6("Typical annual long term returns by asset type are:"),
      h6("- under the Pillow: 0 %"),
      h6("- High Grade Bonds: 2-4 %"),
      h6("- REITs: 3-5 %"),
      h6("- Stocks (Large Cap): 6 %"),
      h6("- Stocks (Small Cap): 8 %"),
      h6("- Mixed Portfolio With Rebalancing: 8-10 %"),
      br(),
      h6("Find the source code on https://github.com/alklar/savings_plan")
    )
  )
))
