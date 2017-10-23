#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
## Author: Matt Lineback
## Shiny web application showing City of Asheville's overdose offenses from COA database
#install.packages('rsconnect')
#install.packages("devtools")
#devtools::install_github("r-lib/httr")
#devtools::install_github("dkahle/ggmap")
#library('rjson')
library(rsconnect)
library(shiny)
library('jsonlite')
library('devtools')
library('dplyr')
library('ggmap')
library('ggplot2')

## getting data from City of Asheville 
data <- fromJSON("https://arcgis.ashevillenc.gov/arcgis/rest/services/PublicSafety/APDIncidents/MapServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json")
## selecting rows that have OVERDOSE as offense description
overdose = data$features[grep('OVERDOSE', data$features$attributes$offense_short_description),]

## getting map of city of Asheville 
avl <- get_map("ASHEVILLE", maptype = c("roadmap"))
## mapping city of Asheville and layering location of offenses on map
avl_map <-ggmap(avl)
avl_overdose <- avl_map + geom_point(data=overdose, aes(x = geometry$x, y = geometry$y), color = "blue", size = 1)+ 
  coord_fixed (xlim = c(-82.4, -82.7),  ylim = c(35.4, 35.7), ratio=1.2)
## Shiny code below
## Define UI for application that draws a histogram
ui <- fluidPage( theme = "bootstrap.css",
  
  tags$style(HTML("

  div.container-fluid{
    
    background-color: #FFFAFA 
  }

  h1{
    text-align: center;
  }

  body{
    background-color: #4682B4;
  }

  p{
    text-align:center;
  }

  div.shiny-plot-output{
    display:inline-block;
  }
                ")),
    h1("City of Asheville Map"),
      p("Below is a plot of overdoses reported by Asheville Police Department"),
          plotOutput("plot")
  )

# Define server logic 
server <- function(input,output) {
  
  
  
  output$plot <- renderPlot({
    avl_overdose
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
