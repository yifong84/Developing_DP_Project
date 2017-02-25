#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
require(RCurl)
library(plotly) 


shinyServer(function(input, output) {
   
  output$Plot_Company <- renderPlotly({
          
          dat<-subset(VCINV, VCINV$Funding.Year %in% input$Year & VCINV$Investment.Level %in% input$Series)
          dat<-data.frame(dat$Company,dat$Amount...M.,stringsAsFactors = FALSE)
          
          dat$Company <- factor(dat$dat.Company, levels = unique(dat$dat.Company)[order(dat$dat.Amount...M., decreasing = TRUE)])
          p_title<-paste( "Investment on ", input$Year,"for", input$Series, sep=" ", collapse = NULL)
          p_x<-list(title="Company")
          p_y<-list(title="Amount(M)")
          p <- plot_ly(dat, x = dat$Company, y = dat$dat.Amount...M., type = 'bar', name = 'Company',color = dat$Company) %>%
                  layout( title =p_title,
                          xaxis=p_x,
                          yaxis=p_y
                         )
                 
    
  })
  output$Plot_Category <- renderPlotly({
          
          dat_b<-subset(VCINV, VCINV$Funding.Year %in% input$Year & VCINV$Investment.Level %in% input$Series)
          dat_b<-data.frame(dat_b$Category,dat_b$Amount...M.,stringsAsFactors = FALSE)
          
          dat_b$Category <- factor(dat_b$dat_b.Category, levels = unique(dat_b$dat_b.Category)[order(dat_b$dat_b.Amount...M., decreasing = TRUE)])
          p_title_b<-paste( "Investment on ", input$Year,"for", input$Series, sep=" ", collapse = NULL)
          p_x_b<-list(title="Category")
          p_y_b<-list(title="Amount(M)")
          p <- plot_ly(dat_b, x = dat_b$Category, y = dat_b$dat_b.Amount...M., type = 'bar', name = 'Category',color = dat_b$Category) %>%
                  layout( title =p_title_b,
                          xaxis=p_x_b,
                          yaxis=p_y_b
                  )
          
          
  })
  
  output$dataTable<-renderDataTable({
          dat_d<-subset(VCINV, VCINV$Funding.Year %in% input$Year & VCINV$Investment.Level %in% input$Series)
          names(dat_d)<-c("Funding Date","Company","Amount(M)","Investment Level","Category","Company Website","Funding Year","Funding Month")
          dat_d
          
  })
  
  output$dataTable2<-renderDataTable({
          dat_d2<-subset(VCINV, VCINV$Funding.Year %in% input$Year & VCINV$Investment.Level %in% input$Series)
          names(dat_d2)<-c("Funding Date","Company","Amount(M)","Investment Level","Category","Company Website","Funding Year","Funding Month")
          dat_d2
          
  })
})
