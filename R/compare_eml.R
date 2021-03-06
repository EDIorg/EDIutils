#' Are there meaningful differences between EML documents?
#' 
#' @description For discovering changes within a dataset that may have affect downstream processes relying on consistent dataset structure and meaning. This is useful in workflow automation where reporting such changes can expedite trouble shooting and manual intervention.
#'
#' @param newest (xml_document, xml_node) EML of the newest version of a data package, where inputs are returned from \code{api_read_metadata()}.
#' @param previous (xml_document, xml_node) EML of the previous version of a data package, where inputs are returned from \code{api_read_metadata()}.
#' @param return.all (logical) Return all differences? Default is FALSE, i.e. only return meaningful differences. Meaningful differences do not include elements expected to change between versions (e.g. number of rows, file size, temporal coverage).
#'
#' @return (character) XPaths of nodes that differ between versions
#' 
#' @details 
#' XPaths of checked nodes (and whether "meaningful"):
#' \itemize{
#'   \item{.//dataset/abstract (TRUE)}
#'   \item{.//dataset/coverage/geographicCoverage (FALSE)}
#'   \item{.//dataset/coverage/temporalCoverage (FALSE)}
#'   \item{.//dataset/coverage/taxonomicCoverage (FALSE)}
#'   \item{.//dataset/keywordSet (FALSE)}
#'   \item{.//dataTable/physical/objectName (TRUE)}
#'   \item{.//dataTable/physical/size (FALSE)}
#'   \item{.//dataTable/physical/authentication (FALSE)}
#'   \item{.//dataTable/physical/dataFormat/textFormat/numHeaderLines (TRUE)}
#'   \item{.//dataTable/physical/dataFormat/textFormat/recordDelimiter (FALSE)}
#'   \item{.//dataTable/physical/dataFormat/textFormat/attributeOrientation (TRUE)}
#'   \item{.//dataTable/physical/dataFormat/textFormat/simpleDelimited/fieldDelimiter (TRUE)}
#'   \item{.//dataTable/attributeList (TRUE)}
#'   \item{.//dataTable/numberOfRecords (FALSE)}
#'   \item{.//otherEntity/physical/objectName (TRUE)}
#'   \item{.//otherEntity/physical/size (FALSE)}
#'   \item{.//otherEntity/physical/authentication (FALSE)}
#'   \item{.//otherEntity/physical/dataFormat/textFormat/numHeaderLines (TRUE)}
#'   \item{.//otherEntity/physical/dataFormat/textFormat/recordDelimiter (TRUE)}
#'   \item{.//otherEntity/physical/dataFormat/textFormat/attributeOrientation (TRUE)}
#'   \item{.//otherEntity/physical/dataFormat/textFormat/simpleDelimited/fieldDelimiter (TRUE)}
#'   \item{.//otherEntity/attributeList (TRUE)}
#' }
#' 
#' @export
#'
#' @examples
#' 
#' # Return only "meaningful" differences (default behavior)
#' compare_eml(
#'   newest = api_read_metadata("knb-lter-hfr.118.32"),
#'   previous = api_read_metadata("knb-lter-hfr.118.31"))
#'   
#' # Return all differences
#' compare_eml(
#'   newest = api_read_metadata("knb-lter-hfr.118.32"),
#'   previous = api_read_metadata("knb-lter-hfr.118.31"),
#'   return.all = TRUE)
#' 
compare_eml <- function(newest, 
                        previous,
                        return.all = FALSE) {
  
  # Parameterize --------------------------------------------------------------
  
  # Nodes to test and whether "meaningful"
  nodes <- c(
    `.//dataset/abstract` = TRUE,
    `.//dataset/coverage/geographicCoverage` = FALSE,
    `.//dataset/coverage/temporalCoverage` = FALSE,
    `.//dataset/coverage/taxonomicCoverage` = FALSE,
    `.//dataset/keywordSet` = FALSE,
    `.//dataTable/physical/objectName` = TRUE,
    `.//dataTable/physical/size` = FALSE,
    `.//dataTable/physical/authentication` = FALSE,
    `.//dataTable/physical/dataFormat/textFormat/numHeaderLines` = TRUE,
    `.//dataTable/physical/dataFormat/textFormat/recordDelimiter` = FALSE,
    `.//dataTable/physical/dataFormat/textFormat/attributeOrientation` = TRUE,
    `.//dataTable/physical/dataFormat/textFormat/simpleDelimited/fieldDelimiter` = TRUE,
    `.//dataTable/attributeList` = TRUE,
    `.//dataTable/numberOfRecords` = FALSE,
    `.//otherEntity/physical/objectName` = TRUE,
    `.//otherEntity/physical/size` = FALSE,
    `.//otherEntity/physical/authentication` = FALSE,
    `.//otherEntity/physical/dataFormat/textFormat/numHeaderLines` = TRUE,
    `.//otherEntity/physical/dataFormat/textFormat/recordDelimiter` = TRUE,
    `.//otherEntity/physical/dataFormat/textFormat/attributeOrientation` = TRUE,
    `.//otherEntity/physical/dataFormat/textFormat/simpleDelimited/fieldDelimiter` = TRUE,
    `.//otherEntity/attributeList` = TRUE)
  
  # Filter --------------------------------------------------------------------
  
  if (return.all) {
    nodes <- names(nodes)
  } else {
    nodes <- names(nodes[nodes])
  }
  
  # Compare -------------------------------------------------------------------
  
  res <- sapply(
    nodes,
    function(x) {
      compare_node_as_string(newest, previous, x)
    }, 
    USE.NAMES = FALSE)
  
  return(unlist(res))
  
}








#' Collapse EML node to string then compare
#'
#' @param newest (xml_document, xml_node) Newest version of an EML document
#' @param previous (xml_document, xml_node) Previous version of an EML document
#' @param xpath (character) xpath of node to compare
#'
#' @return (character) xpath of node if \code{newest} and \code{previous} differ, otherwise NULL
#' 
compare_node_as_string <- function(newest, previous, xpath) {
  
  # Collapse to string
  newest <- xml2::xml_text(xml2::xml_find_all(newest, xpath))
  previous <- xml2::xml_text(xml2::xml_find_all(previous, xpath))
  
  # Only return dissimilar nodes. Add node number to xpath for exact reference.
  if (!all(newest == previous)) {
    nodes <- which(!(newest == previous))
    if (stringr::str_detect(xpath, "dataTable")) {
      parts <- stringr::str_split(xpath, "(?<=dataTable)")
      res <- paste0(parts[[1]][1], "[", nodes, "]", parts[[1]][2])
      return(res)
    } else if (stringr::str_detect(xpath, "otherEntity")) {
      parts <- stringr::str_split(xpath, "(?<=otherEntity)")
      res <- paste0(parts[[1]][1], "[", nodes, "]", parts[[1]][2])
      return(res)
    } else {
      res <- xpath
      return(res)
    }
  }
  
}




