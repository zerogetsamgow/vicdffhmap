#' Division Maps
#'
#' Simple feature collection with 4 features and 4 fields
#'
#' @format ## `division_map`

#' \describe{
#'   \item{division_name}{division name}
#'   \item{geometry}{geometry}
#'   \item{cent_long}{Longitude of centroid}
#'   \item{cent_lat}{Latitude of centroid}
#'   ...
#' }
#' @source <https://www.vic.gov.au/Divisional-model-department-education>
"division_map"

#' Area Maps
#'
#' Simple feature collection with 4 features and 4 fields
#'
#' @format ## `area_map`

#' \describe{
#'   \item{Division_name}{Division name}
#'   \item{area_name}{Area name}
#'   \item{geometry}{geometry}
#'   \item{cent_long}{Longitude of centroid}
#'   \item{cent_lat}{Latitude of centroid}
#'   ...
#' }
#' @source <https://www.vic.gov.au/Divisional-model-department-education>
"area_map"


#' Area Table
#'
#' A tibble of with 3 columns and 79 rows.
#'
#' @format ## `area_tbl`

#' \describe{
#'   \item{division_name}{Division name, with four values}
#'   \item{area_name}{Area name, with 17 values}
#'   \item{lga_name}{Local government area name, with 79 values}
#'   \item{cent_long}{Longitude of centroid}
#'   \item{cent_lat}{Latitude of centroid}
#'   ...
#' }
#' @source <https://www.dffh.vic.gov.au/our-structure>
"area_tbl"

