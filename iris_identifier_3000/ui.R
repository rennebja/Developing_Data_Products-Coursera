#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel(strong("Iris Identifier 3000", style="color:purple")),
  
  # Sidebar for inputs 
  sidebarLayout(
    sidebarPanel(
       selectInput("sel1","What species do you think you have?",
                   c("Select Species" = "null",
                     "Setosa" = "setosa",
                     "Versicolor" = "versicolor",
                     "Virginica" = "virginica")),
       sliderInput("petal_length",
                   "How long are the petals?",
                   min = 1.0,
                   max = 6.9,
                   step = 0.1,
                   value = 1.0),
       sliderInput("petal_width",
                   "How wide are the petals?",
                   min = 0.1,
                   max = 2.5,
                   step = 0.1,
                   value = 0.1),
       sliderInput("sepal_length",
                   "How long are the sepals?",
                   min = 4.3,
                   max = 7.9,
                   step = 0.1,
                   value = 4.3),
       sliderInput("sepal_width",
                   "How wide are the sepals?",
                   min = 2.0,
                   max = 4.4,
                   step = 0.1,
                   value = 2.0),
       selectInput("feat_len","Plot length by:",
                   c("Petal" = "Petal",
                     "Sepal" = "Sepal")),
       selectInput("feat_wid","Plot width by:",
                   c("Petal" = "Petal",
                     "Sepal" = "Sepal"))
    ),
    
    # Define main panel for instructions and results
    mainPanel(
         tabsetPanel(
              tabPanel("Instructions",
                       br(),
                       p(h2("Welcome to the ",
                         strong(em("Iris Identifier 3000!!"), 
                                style = "color:purple"))
                         ),
                       p("Simply enter the petal and sepal length and width 
                         (in cm) of a sample iris from your boquet using the 
                         sliders to the left, and the ",
                         strong("Iris Identifier 3000", style = "color:purple"),
                         " will show you where your flowers fall in the 
                         species field!"),
                       p("If you're hoping you have a particular species, 
                         just enter it using the optional selection box, 
                         and the ",
                         strong("Iris Identifier 3000", style = "color:purple"),
                         " will confirm whether you need to take another run to
                         the flower shop for that special someone!")
                       ),
              tabPanel("The Identifier",
                       htmlOutput("message1"),
                       br(),
                       plotlyOutput("plot1")
                       )
         )
    )
  )
))
