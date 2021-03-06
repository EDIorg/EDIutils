% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_read_data_package_resource_metadata.R
\name{api_read_data_package_resource_metadata}
\alias{api_read_data_package_resource_metadata}
\title{Read data package resource metadata}
\usage{
api_read_data_package_resource_metadata(package.id, environment = 'production')
}
\arguments{
\item{package.id}{(character) Package identifier composed of scope, identifier, and
revision (e.g. 'edi.101.1').}

\item{environment}{(character) Data repository environment to create the package in.
Can be: 'development', 'staging', 'production'.}
}
\value{
('xml_document' 'xml_node') The resource metadata for 
    the data package.
}
\description{
Read Data Package Resource Metadata operation, specifying the scope, 
    identifier, and revision of the data package whose resource metadata is 
    to be read in the URI.
}
