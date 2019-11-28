#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
belts <- as.data.frame(Seatbelts)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Seatbelts' impact on GB driving accidents"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("year",
                      "Select a annee:",
                      choices = c(1968:1984)),
          submitButton("Submit"),
            textOutput("outyear", inline = FALSE),
          DT::dataTableOutput("yearPlot"),
          
        ),
        
        

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("petPlot",click = "plot_click"),
           plotOutput("driversPlot",click = "plot_click")
        )
    ),
  
    DT::dataTableOutput("yearTabPlot"),
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
   
    
  output$outyear <- renderText({
    paste("Number of records is:", nrow(belts))
  })
    output$testPlot <-  DT::renderDataTable({
      belts[1:3,]
    })
    
    output$yearPlot <-  DT::renderDataTable({
      belts[as.integer(input$year)-1967,]
    })
    
    output$yearTabPlot <-  DT::renderDataTable({
      #belts[as.integer(input$inyearbeg)-1967:as.integer(input$inyearend)-1967,]
      belts[]
      
    })
    
    output$petPlot <- renderPlot({
        
        plot(1:192, belts$PetrolPrice)
    })
    
    output$driversPlot <- renderPlot({
      
      plot(1:192, belts$drivers)
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
