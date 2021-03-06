% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_create_data_package.R
\name{api_create_data_package}
\alias{api_create_data_package}
\title{Create data package}
\usage{
api_create_data_package(path, package.id, environment, user.id, user.pass,
    affiliation)
}
\arguments{
\item{path}{(character) Path to the data package EML file.}

\item{package.id}{(character) Package identifier composed of scope, identifier, and
revision (e.g. 'edi.101.1').}

\item{environment}{(character) Data repository environment to create the package in.
Can be: 'development', 'staging', 'production'.}

\item{user.id}{(character) Identification of user creating the data package.}

\item{user.pass}{(character) Password corresponding with the user.id argument supplied
above.}

\item{affiliation}{(character) Affiliation corresponding with the user.id argument supplied
above. Can be: 'LTER' or 'EDI'.}
}
\description{
Create a data package in the Environmental Data Initiative repository.
    Use this function to create the first version of a data package. Use
    `pkg_update` to update a data package.
}
\note{
Data described by the EML metadata record must be accessible through a
    URL supporting download by the EDI data repository. This URL must be
    supplied for each data entity in the "physical" node of the EML (i.e.
    //physical/distribution/online/url).
}
