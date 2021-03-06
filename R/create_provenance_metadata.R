#' Create provenance metadata for an external data source
#'
#' @description
#'     Create provenance metadata for a data source external to PASTA+.
#'
#' @usage create_provenance_metadata(title, creator, online.description, url, 
#'     contact, path, file.name)
#'
#' @param title
#'     (character) Title of external data source.
#' @param creator
#'     (list) Named list of EML creator elements and values. Supprted elements 
#'     are: givenName, surName, organizationName, electronicMailAddress
#' @param online.description
#'     (character) Description of online resource.
#' @param url
#'     (character) URL of online resource.
#' @param contact
#'     (list) Named list of EML contact elements and values. Supprted elements 
#'     are: givenName, surName, organizationName, electronicMailAddress
#' @param path
#'     (character) Where the XML will be written.
#' @param file.name
#'     (character) Name of file to be written.
#'     
#' @return
#'     ('xml_document' 'xml_node') EML provenance metadata
#'     
#' @examples
#'     # Define arguments
#'     
#'     ds_title <- 'Some dataset title'
#'     ds_online_description <- 'Description of online resourceURL'
#'     ds_url <- 'https://url.of.data.resource'
#'     
#'     ds_creator = list(
#'       list(givenName = 'Jane', 
#'            surName = 'Scientist',
#'            organizationName = 'Some organization name',
#'            electronicMailAddress = 'jsci@@email.edu'
#'       ), 
#'       list(givenName = 'Bill', 
#'            surName = 'Sciguy',
#'            electronicMailAddress = 'bsg@@email.edu'
#'        )
#'      )
#'      
#'      ds_contact = list(
#'        list(givenName = 'Jane', 
#'            surName = 'Scientist',
#'            organizationName = 'Some organization name',
#'            electronicMailAddress = 'jsci@@email.edu'
#'         )
#'      )
#'      
#'      # Run function
#'      
#'      create_provenance_metadata(
#'        title = ds_title,
#'        creator = ds_creator,
#'        online.description = ds_online_description,
#'        url = ds_url,
#'        contact = ds_contact
#'      )
#'
#' @export
#'

create_provenance_metadata <- function(title, creator, online.description, url, contact, path = NULL, file.name = NULL){
  
  message('Creating provenance metadata')

  # Handle NULL values.
  
  for (i in 1:length(creator)){
    creator[[i]]$givenName <- if (is.null(creator[[i]]$givenName)){''} else {creator[[i]]$givenName}
    creator[[i]]$surName <- if (is.null(creator[[i]]$surName)){''} else {creator[[i]]$surName}
    creator[[i]]$organizationName <- if (is.null(creator[[i]]$organizationName)){''} else {creator[[i]]$organizationName}
    creator[[i]]$electronicMailAddress <- if (is.null(creator[[i]]$electronicMailAddress)){''} else {creator[[i]]$electronicMailAddress}
  }
  
  for (i in 1:length(contact)){
    contact[[i]]$givenName <- if (is.null(contact[[i]]$givenName)){''} else {contact[[i]]$givenName}
    contact[[i]]$surName <- if (is.null(contact[[i]]$surName)){''} else {contact[[i]]$surName}
    contact[[i]]$organizationName <- if (is.null(contact[[i]]$organizationName)){''} else {contact[[i]]$organizationName}
    contact[[i]]$electronicMailAddress <- if (is.null(contact[[i]]$electronicMailAddress)){''} else {contact[[i]]$electronicMailAddress}
  }
    
  # Create provenance methodStep for EML
  
  method_step <- xml2::xml_new_root(.value = 'methodStep')
  
  xml2::xml_add_child(.x = method_step, .value = 'description')
  data_source <- xml2::xml_add_child(.x = method_step, .value = 'dataSource')
  tag <- xml2::xml_add_child(.x = data_source, .value = 'title')
  xml2::xml_set_text(x = tag, value = title)
  
  for (i in 1:length(creator)){
    cr <- xml2::xml_add_child(.x = data_source, .value = 'creator')
    individualname <- xml2::xml_add_child(.x = cr, .value = 'individualName')
    tag <- xml2::xml_add_child(.x = individualname, .value = 'givenName')
    xml2::xml_set_text(x = tag, value = creator[[i]]$givenName)
    tag <- xml2::xml_add_child(.x = individualname, .value = 'surName')
    xml2::xml_set_text(x = tag, value = creator[[i]]$surName)
    tag <- xml2::xml_add_child(.x = cr, .value = 'organizationName')
    xml2::xml_set_text(x = tag, value = creator[[i]]$organizationName)
    tag <- xml2::xml_add_child(.x = cr, .value = 'electronicMailAddress')
    xml2::xml_set_text(x = tag, value = creator[[i]]$electronicMailAddress)
  }
  
  distr <- xml2::xml_add_child(.x = data_source, .value = 'distribution')
  onl <- xml2::xml_add_child(.x = distr, .value =  'online')
  tag <- xml2::xml_add_child(.x = onl, .value = 'onlineDescription')
  xml2::xml_set_text(x = tag, value = online.description)
  tag <- xml2::xml_add_child(.x = onl, .value = 'url')
  xml2::xml_set_text(x = tag, value = url)
  
  for (i in 1:length(contact)){
    cr <- xml2::xml_add_child(.x = data_source, .value = 'contact')
    individualname <- xml2::xml_add_child(.x = cr, .value = 'individualName')
    tag <- xml2::xml_add_child(.x = individualname, .value = 'givenName')
    xml2::xml_set_text(x = tag, value = contact[[i]]$givenName)
    tag <- xml2::xml_add_child(.x = individualname, .value = 'surName')
    xml2::xml_set_text(x = tag, value = contact[[i]]$surName)
    tag <- xml2::xml_add_child(.x = cr, .value = 'organizationName')
    xml2::xml_set_text(x = tag, value = contact[[i]]$organizationName)
    tag <- xml2::xml_add_child(.x = cr, .value = 'electronicMailAddress')
    xml2::xml_set_text(x = tag, value = contact[[i]]$electronicMailAddress)
  }

  # Write to file
  
  if (!is.null(path) & !is.null(file.name)){
    xml2::write_xml(method_step, paste0(path, '/', file.name))
  }
  

  # Return
  
  method_step

}
