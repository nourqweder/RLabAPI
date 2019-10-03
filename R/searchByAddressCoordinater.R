# Google Geocode API
# 
#
# Standard Usage Limits
# Users of the standard API:
# 2,500 free requests per day, calculated as the sum of client-side and server-side queries.
# 50 requests per second, calculated as the sum of client-side and server-side queries.
#
# https://maps.googleapis.com/maps/api/geocode/json?address=

#'@title searchByAddressCoord
#'@description Returns address of the given latitude and longitude.
#'@param coorXY Character class of latitude and longitude separated by ","
#'@export
#'@import jsonlite curl
#'@return Character class of the address of the given latitude and longitude.
#'@examples 
#'searchByAddressCoord("37.56654, 126.978")
#'searchByAddressCoord("37.55723, 127.0453")

searchByAddressCoord <- function(coorXY) {

  stopifnot(is.character(coorXY))
  
  #latitude, longitude transform
  coorXY <- gsub(" ","", coorXY)
  
  geoURL <- "https://maps.googleapis.com/maps/api/geocode/json?coorXY="
  key <- "&key="
  geoData <- jsonlite::fromJSON(paste0(geoURL, coorXY, key))
  
  if(geoData$status == "ZERO_RESULTS"){
    stop(print("No results found"))
  }
  else if(geoData$status == "OVER_QUERY_LIMIT") {
    stop(print("Over usage limits"))
  } 
  else if(geoData$status == "REQUEST_DENIED") {
    stop(print("Request denied"))
  } 
  else if(geoData$status == "INVALID_REQUEST") {
    stop(print("Query might be missing"))
  } 
  else if(geoData$status == "UNKNOWN_ERROR") {
    stop(print("Unknown error"))
  } 
  
  if(geoData$status == "OK"){
    #printing input latitude and longitude
    cat("Input latitude and longitude: ", coorXY,"\n\n")
    
    #summary of the info
    address <- geoData$results[[2]][1]
    
    return(address)
  } 
}
