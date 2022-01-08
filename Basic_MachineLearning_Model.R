library(shiny)
library(shinythemes)
library(randomForest)
data(mtcars)

mtcars <- mtcars
mpg_model <- lm(mpg~.,data=mtcars)

ui <- fluidPage(
  theme = shinytheme(theme="united"),
  headerPanel(title="Mileage KYAAA!!!"),
  sidebarPanel(
    HTML("<h3>Input vehicle details-1</h3>"),
    selectInput("cyl",
                label="Cylinder:",
                choices=list("4"=4,"6"=6,"8"=8),selected="4"), # Cylinder
    selectInput("vs",label="VS:",choice=list("0"=0,"1"=1),selected="0"), # vs
    selectInput("am",label="AM:",choice=list("0"=0,"1"=1),selected="0"), # am
    selectInput("gear",
                label="Gear:",
                choices=list("3"=3,"4"=4,"5"=5),selected="4"), # gear
    selectInput("carb",
                label="Carb:",
                choices=list("1"=1,"2"=2,"3"=3,"4"=4,"6"=6,"8"=8),selected="4"), # carb
  ),
  sidebarPanel(
    sliderInput("disp","Displacement:",min=70,max=500,value=430),#disp
    sliderInput("hp","Horse Power:",min=50,max=350,value=230),#hp
    sliderInput("drat","DRAT:",min=2,max=5,value=3),#drat
    sliderInput("wt","Weight:",min=1.4,max=5.5,value=2.5),#wt
    sliderInput("qsec","Displacement:",min=14.1,max=23.1,value=18),#qsec
    actionButton("submitbutton", "Submit", class = "btn btn-primary")
  ),
  mainPanel(
    tags$label(h3("MPG/Output:")),
    verbatimTextOutput("vehicle_details"),
    tableOutput("vehicle_mileage")
  )
  )

server <- function(input,output){
  
  datasetInput <- reactive({
    df_input <- list()
    
    
    df_input$cyl <- input$cyl
    df_input$vs <- input$vs
    df_input$am <- input$am
    df_input$gear <- input$gear
    df_input$carb <- input$carb
    df_input$disp <- input$disp
    df_input$hp <- input$hp
    df_input$drat <- input$drat
    df_input$wt <- input$wt
    df_input$qsec <- input$qsec
    df_input$mpg <- 0
    df_input <- data.frame(df_input,stringsAsFactors = F)
    df_input <- data.frame(lapply(df_input,as.numeric),stringsAsFactors = F)
    mpg_out <- data.frame(round(predict(mpg_model,newdata=df_input),2))
    colnames(mpg_out) <- "MPG"
    print (mpg_out)
  })
  
  output$vehicle_details <- renderPrint({
    if(input$submitbutton>0){
      isolate("Vehicles MPG Calculation done...!")
    }else{
      return ("About to calculate vehicles MPG...!")
    }
  })
  
  output$vehicle_mileage <- renderTable({
    if(input$submitbutton>0){
      isolate(datasetInput())
    }
  })
  print ("Pass")
}
shinyApp(ui = ui, server = server)