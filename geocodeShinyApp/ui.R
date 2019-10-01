#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(jsonlite)
library(googleAuthR)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("A package connecting to a Geocode API"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
         sidebarPanel (
            selectInput(
                "googleMethodInput","Select Geocoding request and response method according to:",
                c("latitude/longitude lookup"="latiAndlong" ,
                  "address lookup"="address" 
                )),
            
            # Only show this panel if the google method is a address
            conditionalPanel(
                condition = "input.googleMethodInput == 'address'",
                textInput("address_t", "Type an address:", placeholder = "Smålandsvägen 42D, Mjölby")
            ),
            # Only show this panel if the google method is a latiAndlong
            conditionalPanel(
                condition = "input.googleMethodInput == 'latiAndlong'",
                textInput("latiText", "Enter a latitude value:", placeholder = "58.4290005"),
                textInput("longText", "Enter a longitude value:", placeholder = "15.5799367")
            ),
            selectInput("googleMethodInput", "Select the display mode:", 
                        c("Classic" = "classic",
                          "Satellite" = "satellite",
                          "Night" = "night"))
            ),
        # Show a plot of the generated distribution
        mainPanel(leafletOutput("distPlot", height = "800px")),
        
    )
))
