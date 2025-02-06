## code to prepare `create_dffh_dict` dataset goes here
# Create lookup tables of state names and abbreviations
library(tidyverse)

# Get data saved locally
dict_tbl =
  vicdffhmap::area_tbl |>
  dplyr::select("dffh_name" = area_name) |>
  dplyr::mutate(
    dffh_abbr =
      dffh_name |>
      stringr::str_replace("(East|West|North|South)ern","\\1") |>
      stringr::str_replace("Melbourne","Melb") |>
      stringr::str_replace("Gippsland","Gipps") |>
      stringr::str_replace("Peninsula","Penin") |>
      stringr::str_replace("Central","Cent") |>
      stringr::str_replace("South West","SW") |>
      stringr::str_trim()
  )


# Create dictionary tibble
dffh_dict_tbl =
  dict_tbl |>
  tidyr::pivot_longer(
    -dffh_name,
    names_to = "type",
    values_to = "alias")

# lga_abbr type to above
dffh_dict_tbl =
  dplyr::bind_rows(
    dffh_dict_tbl,
    dict_tbl |>
      dplyr::select(dffh_name) |>
      dplyr::mutate(
        alias = dffh_name,
        type = "dffh_name")
  )

# create dictionary as character vector
dffh_dict <- dffh_dict_tbl$alias
names(dffh_dict) <- dffh_dict_tbl$dffh_name

# Add known missing cases
dffh_dict <- c(dffh_dict,
              "Hume Merri-bek" = "Hume Moreland",
              "North Eastern Melbourne" = "NE Melbourne"
)

# Add no spaced versions
nospaces <- stringr::str_remove_all(dffh_dict_tbl$dffh_name, " ")
names(nospaces) <- dffh_dict_tbl$dffh_name

dffh_dict <- c(dffh_dict, nospaces)

# remove duplicates
dffh_dict <- dffh_dict[!duplicated(dffh_dict)]

dffh_dict <- tolower(dffh_dict)

usethis::use_data(dffh_dict, dffh_dict_tbl, overwrite = TRUE, internal = TRUE)

