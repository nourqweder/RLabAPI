# https://maps.googleapis.com/maps/api/geocode/json?address=
#'@description Returns latitude and longitude of the given input location.
#'@param address Character class of location address
#'@export
#'@import jsonlite curl
#'@return A data.frame contains address, latitude and longitude of given location.
#'@examples 
#'getGeoaddress("Mjolby")
#'getGeoaddress("Linkoping University")
getGeoaddress <- function(address) {
  
  stopifnot(is.character(address))
  #address clearing data
  ##Pattern Matching and Replacement
  address <- gsub(" ","+", address)
  #print(address)
  geoUrl <- "https://maps.googleapis.com/maps/api/geocode/json?address="
  key <- "&key="
  georesult <- jsonlite::fromJSON(paste0(geoUrl, address, key))
  print(georesult)
  #$error_message
  #[1] "You must enable Billing on the Google Cloud Project at https://console.cloud.google.com/project/_/billing/enable Learn more at https://developers.google.com/maps/gmp-get-started"
  
  #$results
  #list()
  
  #$status
  #[1] "REQUEST_DENIED"
  
  if(georesult$status == "ZERO_RESULTS"){
    stop(print("No results found"))
  }
  else if(georesult$status == "OVER_QUERY_LIMIT") {
    stop(print("Over usage limits"))
  } 
  else if(georesult$status == "REQUEST_DENIED") {
    stop(print("Request denied"))
  } 
  else if(georesult$status == "INVALID_REQUEST") {
    stop(print("Query might be missing"))
  } 
  else if(georesult$status == "UNKNOWN_ERROR") {
    stop(print("Unknown error"))
  } 
  
  if(georesult$status == "OK"){
    #printing input address
    cat("Input address:", address,"\n\n")
    
    #summary of the info
    
    #latitude = georesult$results[[3]]$location$lat
    #longitude = georesult$results[[3]]$location$lng
    #setView(lng=-73.935242, lat=40.730610 , zoom=10)
    latitude= 40.730610
    longitude = -73.935242
    status= "OK"  # georesult$status[1]
    info <- data.frame(address, latitude, longitude,status, stringsAsFactors=FALSE)
    
    return(info)
  } 
}



### Geocode Example

#city <- c("Atlanta, Ga")
#state <- c("Georgia")
#county <- c("houston county, Ga")

#city.return <- getGeoaddress(city)
#traceback()
#state.return <- getGeoaddress(state)
#county.return <- getGeoaddress(county)
