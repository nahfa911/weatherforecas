#' cityweather
#'
#' This object can connect to the openweathermap API and get the 7 days
#' forecasting of the desired city. For more information about this API
#' see the link bellow :
#' \url{https://openweathermap.org/}
#'
#' @field cityname A character shows the city name.
#' @field content A list contains the content of API response.
#' @field status_code An integer that shows the status code of API response.
#' @field has_error A boolean that shows TRUE if there is an error.
#'
#' @import methods
#' @exportClass cityweather
#' @export cityweather


cityweather <- setRefClass('cityweather'
               , fields = list(
                  cityname = "character"
                 ,content = "list"
                 ,status_code = "integer"
                 ,has_error = "logical"
               )
               , methods = list(
                 initialize = function(cityname, key = '3c656bd3014279a8f41b90522c014977'){
                   "Getting the data from API"
                   `%not_in%` <- purrr::negate(`%in%`)
                   if(tolower(cityname) %not_in% tolower(city_list$name)){stop('This city does not exist!', call. = FALSE)}
                   resp <- httr::GET(paste0('http://api.openweathermap.org/data/2.5/forecast?q=',cityname,
                                            '&cnt=7&units=metric&appid=', key))
                   if(http_type(resp) != 'application/json'){stop('Response is not in json format!', call. = FALSE)}
                   if(http_error(resp)){stop(
                     sprintf('The server responded with this error:\n[%s]\n%s\n<%s>'
                             ,status_code(resp)
                             ,content(resp)$message
                             ,content(resp)$documentation_url)
                     , call. = FALSE
                   )}
                   content <<- jsonlite::fromJSON(httr::content(resp,'text'))
                   cityname <<- cityname
                   status_code <<- httr::status_code(resp)
                   has_error <<- httr::http_error(resp)

                 }
                , print = function(){
                    "Print out the structure of response content"
                    cat('The structure of response content:\n')
                    str(content)

                }
               )
               )

#' @importFrom purrr negate
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom httr status_code
#' @importFrom httr http_error
#' @importFrom jsonlite fromJSON
NULL