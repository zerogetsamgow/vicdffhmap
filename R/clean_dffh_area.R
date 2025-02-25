#' Convert Victorian DFFH area names into a consistent format
#'
#' @param x a (character) vector containing Victorian DFFH area names or abbreviations.
#'
#' @param to what form should the state names be converted to? Options are
#' "dffh_name", "dffh_name" (the default), and "dffh_code".
#'
#' @param fuzzy_match logical; either TRUE (the default) which indicates that
#' approximate/fuzzy string matching should be used, or FALSE which indicates that
#' only exact matches should be used.
#'
#' @param max_dist numeric, sets the maximum acceptable distance between your
#' string and the matched string. Default is 0.4. Only relevant when fuzzy_match is TRUE.
#'
#' @param method the method used for approximate/fuzzy string matching. Default
#' is "jw", the Jaro-Winker distance; see `??stringdist-metrics` for more options.
#'#'
#' @return a character vector of state names, abbreviations, or codes.
#'
#' @rdname clean_dffh_area
#' @examples
#'
#' library(vicdffhmap)
#'
#' x <- c("Melburn", "Wang", "Donga")
#'
#' # Convert the above to area names
#' clean_dffh_area(x)
#'
#' # Disable fuzzy matching; you'll get NAs unless exact matches can be found
#'
#' clean_dffh_area(x, fuzzy_match = FALSE)
#'
#' # You can use clean_dffh_area in a dplyr mutate call
#'
#' x_df <- data.frame(area = x, stringsAsFactors = FALSE)
#'
#' \dontrun{x_df |> mutate(dffh_name = clean_dffh_area(area))}
#'
#' @importFrom stringdist amatch
#' @export

clean_dffh_area <- function(x, to = "dffh_name", fuzzy_match = TRUE, max_dist = 0.4, method = "jw"){

  if(!is.logical(fuzzy_match)){
    stop("`fuzzy_match` argument must be either `TRUE` or `FALSE`")
  }

  if(!is.numeric(x)) {
    x <- name_string_tidy(x)
  }

  if(fuzzy_match){
    matched_name <- names(dffh_dict[stringdist::amatch(x, tolower(dffh_dict),
                                                      method = method,
                                                      matchNA = FALSE,
                                                      maxDist = max_dist)])
  } else {
    matched_name <- names(dffh_dict[match(x, tolower(dffh_dict))])
  }

  ret <- dffh_tbl[[to]][match(matched_name, dffh_tbl$dffh_name)]

  ret <- as.character(ret)

  ret

}


#' Helper function used by clean_dffh_name
#'
#' @param string a character string.
#' @rdname name_string_tidy

name_string_tidy <- function(string){

  string <- stringr::str_to_lower(string)

  string <- stringr::str_trim(string, "both")

  string <- ifelse(string %in% c("na", "n.a", "n.a.", "n a",
                                 "not applicable"),
                   NA_character_,
                   string)

  string
}

