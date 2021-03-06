% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compare_eml.R
\name{compare_node_as_string}
\alias{compare_node_as_string}
\title{Collapse EML node to string then compare}
\usage{
compare_node_as_string(newest, previous, xpath)
}
\arguments{
\item{newest}{(xml_document, xml_node) Newest version of an EML document}

\item{previous}{(xml_document, xml_node) Previous version of an EML document}

\item{xpath}{(character) xpath of node to compare}
}
\value{
(character) xpath of node if \code{newest} and \code{previous} differ, otherwise NULL
}
\description{
Collapse EML node to string then compare
}
