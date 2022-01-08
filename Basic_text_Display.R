library(shiny)
library(shinythemes)

ui <- fluidPage(
  title="Display Name",
  navbarPage(
    title="NAV BAR TITLE",
    tabPanel(
      title="FIRST",
      sidebarPanel(
        tags$h3("Hello World"),
        textInput("firstName","FIRST NAME",""),
        textInput("lastName","LAST NAME","")
      ),# SIDE BAR PANEL ENDS HERE
      mainPanel(
        h2("Whats my NAME"),
        verbatimTextOutput("fullName")
      ) # MAIN PANEL ENDS HERE
      ), # FIRST TAB ENDS HERE
    tabPanel(
      title="SECOND","LEAVING IT FOR FUTURE",

      mainPanel(
        h2("Whats my Name2"),
        verbatimTextOutput("fullName1")
      )
    ), # SECOND TAB ENDS HERE
    tabPanel(
      title="THIRD","LEAVING IT FOR FUTURE"
    ) # THIRD TAB ENDS HERE
    ) # NAV BAR Ends Here
                ) # Fluid Page ends Here


# SERVER DEFINITION
server <- function(input,output){
  output$fullName <- renderText({
    paste(input$firstName,input$lastName,sep=" ")
    
  })
  output$fullName1 <- renderText({
    paste(input$firstName,input$lastName,sep=" ")
    
  })
} # SERVER PART ENDS HERE 


#CREATING SHINY OBJECT
shinyApp(ui=ui,server=server)