% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_evaluate_data_package.R
\name{api_evaluate_data_package}
\alias{api_evaluate_data_package}
\title{Evaluate data package}
\usage{
api_evaluate_data_package(path, package.id, environment, user.id, 
    user.pass, affiliation)
}
\arguments{
\item{path}{(character) Path to the data package EML file.}

\item{package.id}{(character) Package identifier composed of scope, identifier, and
revision (e.g. 'edi.101.4').}

\item{environment}{(character) Data repository environment to perform the evaluation in.
Can be: 'development', 'staging', 'production'.}

\item{user.id}{(character) Identification of user performing the evaluation.}

\item{user.pass}{(character) Password corresponding with the user.id argument supplied
above.}

\item{affiliation}{(character) Affiliation corresponding with the user.id argument supplied
above. Can be: 'LTER' or 'EDI'.}
}
\description{
Evaluate Data Package operation, specifying the EML document describing 
    the data package to be evaluated in the request message body, and 
    returning a transaction identifier in the response message body as plain 
    text; the transaction identifier may be used in a subsequent call to 
    Read Data Package Error to determine the operation status or to Read 
    Evaluate Report to obtain the evaluate quality report.
    
    An optional query parameter, “useChecksum”, can be appended to the URL. 
    When specified, the useChecksum query parameter directs the server to 
    determine whether it can use an existing copy of a data entity from a 
    previous revision of the data package based on matching a 
    metadata-documented checksum value (MD5 or SHA-1) to the checksum of 
    the existing copy. If a match is found, the server will skip the upload 
    of the data entity from the remote URL and instead use its matching 
    copy.
    
    Please Note: Specifying “useChecksum” can save time by eliminating data 
    uploads, but clients should take care to ensure that metadata-documented 
    checksum values are accurate and up to date.
}
\note{
Data described by the EML metadata record must be accessible through a
    URL supporting download by the EDI data repository. This URL must be
    supplied for each data entity in the "physical" node of the EML (i.e.
    //physical/distribution/online/url).
}
