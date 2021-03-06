#' List data package scopes
#'
#' @description
#'     List data package scopes
#'
#' @usage api_list_data_package_scopes(environment = 'production')
#'
#' @param environment
#'     (character) Data repository environment to create the package in.
#'     Can be: 'development', 'staging', 'production'.
#'
#' @return
#'     (character) All scope values extant in the data package registry.
#'
#' @export
#'

api_list_data_package_scopes <- function(environment = 'production'){
  
  message(paste('Listing data package scopes in the', environment, 'environment'))
  
  validate_arguments(x = as.list(environment()))
  
  r <- httr::GET(
    url = paste0(
      url_env(environment),
      '.lternet.edu/package/eml'
    )
  )
  
  r <- httr::content(
    r,
    as = 'text',
    encoding = 'UTF-8'
  )
  
  output <- as.character(
    read.csv(
      text = c(
        'identifier',
        r
      ),
      as.is = T
    )$identifier
  )
  
  output
  
}