#' validate_keywords
#'
#' @description  
#'     Check the validity of terms listed in keywords.txt against controlled 
#'     vocabularies, and receive suggestions for improving non-aligned terms.
#'
#' @usage 
#'     validate_keywords(path, cv, interactive.mode = FALSE)
#'
#' @param path
#'     (character) Path to the directory containing keywords.txt.
#' @param cv
#'     (character) A controlled vocabulary to search. Valid options are:
#'     \itemize{
#'         \item{lter} - The LTER Controlled Vocabulary (http://vocab.lternet.edu/vocab/vocab/index.php)
#'     }
#' @param interactive.mode
#'     (logical) Should a list of possible matches be returned to the user to 
#'     select from?
#'
#' @return 
#'     An updated version of keywords.txt with the controlled vocabulary name 
#'     listed along side keywords for which a direct match was found. For each
#'     keyword that could not be matched, a set of options are listed in the 
#'     RStudio Console Window that the user must manually select from. The 
#'     results of this selection process are written to keywords.txt.
#'
#' @export
#'


validate_keywords <- function(path, cv, interactive.mode = FALSE){
  
  # Check arguments -----------------------------------------------------------
  
  if (cv != 'lter'){
    stop('Input argument "cv" is not one of the allowed vocabularies!')
  }
  
  # Validate keywords.txt
  
  fname_keywords <- paste0(path, '/keywords.txt')
  if (!isTRUE(file.exists(fname_keywords))){
    stop('keywords.txt does not exist! Run import_templates.txt to create this template.')
  }
  
  # Read keywords.txt ---------------------------------------------------------
  
  message("Reading keywords.txt")
  
  keywords <- suppressWarnings(utils::read.table(
    paste(substr(fname_keywords, 1, nchar(fname_keywords) - 4),
          ".txt",
          sep = ""),
    header = T,
    sep="\t",
    quote="\"",
    as.is=TRUE,
    comment.char = "",
    fill = T,
    colClasses = rep("character", 2)))
  keywords <- keywords[ ,1:2]
  colnames(keywords) <- c("keyword", 
                          "keywordThesaurus")
  
  # Edit keywords: Remove blank keyword entries
  
  use_i <- keywords$keyword == ""
  if (sum(use_i) > 0){
    keywords <- keywords[!use_i, ]
  }
  
  # Resolve terms (automatically) ---------------------------------------------
  
  unresolved_terms <- keywords[keywords$keywordThesaurus == '', 'keyword']
  
  results <- vocab_resolve_terms(
    x = unresolved_terms,
    cv = cv
  )
  
  use_i <- results[ , 'controlled_vocabulary'] != ''
  use_i2 <- match(results[use_i, 'term'], keywords$keyword)
  keywords$keywordThesaurus[use_i2] <- results$controlled_vocabulary[use_i]
  
  # Resolve terms (manually) --------------------------------------------------
  
  if (isTRUE(interactive.mode)){
    
    unresolved_terms <- keywords[keywords$keywordThesaurus == '', 'keyword']
    
    results <- vocab_resolve_terms(
      x = unresolved_terms,
      cv = cv,
      interactive = T
    )
    
    use_i <- results[ , 'controlled_vocabulary'] != ''
    use_i2 <- match(unresolved_terms[use_i], keywords$keyword)
    keywords[use_i2, 'keywordThesaurus'] <- 'controlled_vocabulary'
    keywords[use_i2, 'keyword'] <- results$term[use_i]
    
  }
  
  # Write results to file -----------------------------------------------------
  
  # Write to file
  lib_path <- system.file('keywords.txt', package = 'EDIutils')
  lib_path <- substr(lib_path, 1, nchar(lib_path)-13)  
  if (path != lib_path){
    suppressWarnings(utils::write.table(keywords,
                                 paste(path,
                                       "/",
                                       "keywords.txt", sep = ""),
                                 sep = "\t",
                                 row.names = F,
                                 quote = F,
                                 fileEncoding = "UTF-8"))
  }
  
  # Return value
  
  keywords
  
}
