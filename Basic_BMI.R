library(shiny)
library(shinythemes)

ui <- fluidPage(
  
  navbarPage(
    title = "BMI Calculator",
    tabPanel(
      title="Home",
      sidebarPanel(
        
        sliderInput("weight",
                    label = "WEIGHT",
                    min=10,
                    max=250,
                    value = 50
                    ),
        sliderInput("height",
                    label="HEIGHT",
                    min=20,
                    max=200,
                    value=50),
        actionButton(inputId = "click_me",
                     label = "BMI",
                     class="btn btn-primary")
      ), 
      mainPanel(
        HTML("<h3>BMI DISPLAY</h3>"),
        verbatimTextOutput("bmi_message"),
        tableOutput("bmi_table")
      )
      
    ),
    tabPanel(
      title = "NEXT",
      mainPanel(
        HTML("<h2>FILL ME UP</h2>")
      )
    )
  )
)

server <- function(input,output,session){
  
  bmi_input <- reactive({
    
    bmi_value <- input$weight/((input$height/100) * (input$height/100))
    bmi_value <- data.frame(bmi_value)
    names(bmi_value) <- "BMI"
    print (bmi_value)
    
   
  })
  
  output$bmi_message <- renderPrint({
    if(input$click_me>0){
      isolate("BMI is Calculated!!")
    }else{
      isolate("BMI is about to calculate!")
    }
  })
  
  output$bmi_table <- renderTable({
    if(input$click_me>0){
      isolate(bmi_input())
    }
  })
}

shinyApp(ui = ui, server = server)