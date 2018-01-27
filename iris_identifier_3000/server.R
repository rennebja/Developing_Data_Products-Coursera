#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(e1071)
library(tidyverse)
library(plotly)
data("iris")

shinyServer(function(input, output) {
     
     set.seed(12345)
     modFitlda <- train(Species ~ ., method = "lda", data = iris)
     
     user_flowers <- reactive({
          data.frame(Sepal.Length = input$sepal_length,
                               Sepal.Width = input$sepal_width,
                               Petal.Length = input$petal_length,
                               Petal.Width = input$petal_width,
                               Species = "Your Entry")
     })
     
     levels(iris$Species) <- c(levels(iris$Species), "Your Entry")
     
     irises <- reactive({
          rbind(iris,user_flowers()) %>%
               mutate(point_size = c(rep(2, 150), 4))
          })
     
     predicted_species <- reactive({
          predict(modFitlda, newdata = user_flowers()[,-5])
     })
     
     feat_length <- reactive({
          paste0(input$feat_len,".Length")
          })
     feat_width <- reactive({
          paste0(input$feat_wid,".Width")
          })
     
  output$plot1 <- renderPlotly({
       
       g <- ggplot(irises(), aes_string(x = feat_length(), y = feat_width(), 
                       colour = "Species")) +
            geom_point(aes(size = point_size), show.legend = FALSE) +
            geom_point(alpha = .5)
       
       ggplotly(p = g)
  })
  
  output$message1 <- renderText({
       
       if(predicted_species() == input$sel1){
            paste("<h2><b style=\"color:green\">CONGRATULATIONS</b></h2>
                  <p><h4>Your flower recipient will be very happy.</h4></p>")
       } else if(input$sel1 == "null"){
            paste("<p><h4>Thank you for using the <h2><em>
                  <strong style=\"color:purple\">Iris Identifier 3000!!
                  </strong></em></h2></h4></p>")
       } else {
            paste("<h1><strong style=\"color:red\">OH, NO!</strong></h1>
                  <p><h4>Your flowers aren't the right ones. You'd better
                  <a href=https://www.google.com/search?q=flower+shops+near+me>
                  Find a Florist</a></h4></p>")
       }
  })
})
