% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_provenance_metadata.R
\name{create_provenance_metadata}
\alias{create_provenance_metadata}
\title{Create provenance metadata for an external data source}
\usage{
create_provenance_metadata(title, creator, online.description, url, 
    contact, path, file.name)
}
\arguments{
\item{title}{(character) Title of external data source.}

\item{creator}{(list) Named list of EML creator elements and values. Supprted elements 
are: givenName, surName, organizationName, electronicMailAddress}

\item{online.description}{(character) Description of online resource.}

\item{url}{(character) URL of online resource.}

\item{contact}{(list) Named list of EML contact elements and values. Supprted elements 
are: givenName, surName, organizationName, electronicMailAddress}

\item{path}{(character) Where the XML will be written.}

\item{file.name}{(character) Name of file to be written.}
}
\value{
('xml_document' 'xml_node') EML provenance metadata
}
\description{
Create provenance metadata for a data source external to PASTA+.
}
\examples{
    # Define arguments
    
    ds_title <- 'Some dataset title'
    ds_online_description <- 'Description of online resourceURL'
    ds_url <- 'https://url.of.data.resource'
    
    ds_creator = list(
      list(givenName = 'Jane', 
           surName = 'Scientist',
           organizationName = 'Some organization name',
           electronicMailAddress = 'jsci@email.edu'
      ), 
      list(givenName = 'Bill', 
           surName = 'Sciguy',
           electronicMailAddress = 'bsg@email.edu'
       )
     )
     
     ds_contact = list(
       list(givenName = 'Jane', 
           surName = 'Scientist',
           organizationName = 'Some organization name',
           electronicMailAddress = 'jsci@email.edu'
        )
     )
     
     # Run function
     
     create_provenance_metadata(
       title = ds_title,
       creator = ds_creator,
       online.description = ds_online_description,
       url = ds_url,
       contact = ds_contact
     )

}
