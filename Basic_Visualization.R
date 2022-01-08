library(shiny)
library(shinythemes)


ui <- fluidPage(
  titlePanel("Random Visualization"),
  sidebarLayout(
      sidebarPanel(
          sliderInput(
          inputId = "bins",
          label = "Number of Bins",
          min=1,
          max=80,
          value=50
        )
      ), 
      mainPanel(
        h3("Show histogram"),
        plotOutput(outputId = "histo"),
        plotOutput(outputId = "boxpl")
      ) 
      
  )
    )
  

server <- function(input,output){
  
  output$histo <- renderPlot({
    data(mtcars)
    x <- mtcars$mpg
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "MPG",
         main = "Histogram of MILEAGE")
  }) # First visualization ends here 
  
 output$boxpl <- renderPlot({
   data(mtcars)
   x <- mtcars$mpg
   boxplot(x,main="Boxplot of MILEAGE")
 })
}

shinyApp(ui=ui,server=server)