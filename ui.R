
# Coursera : Developing Data products
# Author : courserans


library(shiny)
library(markdown)

shinyUI(
    navbarPage("Central Limit Theorem : Exponential Distribution",
               tabPanel("Plot",
                        sidebarPanel(
                            sliderInput("n",
                                        "No. of Observations :",
                                        min = 10,
                                        max = 50,
                                        value = 40),
                            sliderInput("lambda",
                                        "Lambda:",
                                        min = 0.1,
                                        max = 0.3,
                                        value = 0.2),
                            
                            selectInput("sim", 
                                        label = "No of Simulations : ", 
                                        choices = c("50","250","500","1000","10000"),
                                        selected = c("1000")
                                        )
                        ),
                        mainPanel(
                            h3("Input Parameters"),
                            textOutput("text1"),
                            textOutput("text2"),
                            textOutput("text3"),
                            h3("Simulation Results"),
                            textOutput("text4"),
                            textOutput("text5"),
                            textOutput("text6"),
                            textOutput("text7"),
                            plotOutput("newHist"),
                            includeMarkdown("conclusion.md")
                        )
                    ),
               tabPanel("About",
                        mainPanel(
                            includeMarkdown("about.md")
                            )
                        )
               )
)