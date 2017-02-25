

library(shiny)
require(RCurl)
library(plotly)

source("LoadData.R")


shinyUI(fluidPage(
  

  titlePanel("Venture Capital Investment"),
  
 
  sidebarLayout(
    sidebarPanel(
        selectInput("Year",
                    "Select Year",
                    choices = VCINV$Funding.Year,
                    selected = TRUE
                
                
        ),
        selectInput("Series",
                    "Select Investment Level",
                    choices = VCINV$Investment.Level,
                    selected = TRUE
        ),
        width = 2
    ),
    

    mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel(
                                "Investment By Company", 
                                br(),
                                htmltools::div(style = "display:inline-block", plotlyOutput("Plot_Company", width = 800, height = 400)),
                                dataTableOutput('dataTable')
                                ),
                        tabPanel(
                                "Investment By Category", 
                                br(), 
                                htmltools::div(style = "display:inline-block", plotlyOutput("Plot_Category", width = 800, height = 400)),
                                dataTableOutput('dataTable2')
                                 )
 
            
            
    )
  )
)))
