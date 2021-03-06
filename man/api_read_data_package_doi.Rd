% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_read_data_package_doi.R
\name{api_read_data_package_doi}
\alias{api_read_data_package_doi}
\title{Read data package DOI}
\usage{
api_read_data_package_doi(package.id, environment = 'production')
}
\arguments{
\item{package.id}{(character) Package identifier composed of scope, identifier, and
revision (e.g. 'edi.101.1').}

\item{environment}{(character) Data repository environment to create the package in.
Can be: 'development', 'staging', 'production'.}
}
\value{
(character) The canonical Digital Object Identifier.
}
\description{
Read Data Package DOI operation, specifying the scope, identifier, 
    and revision of the data package DOI to be read in the URI.
}
