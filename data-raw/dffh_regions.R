## code to prepare `dffh_regions` dataset goes here

## code to prepare datasets
library(sf)

# Read table of regions, areas, and lgas from locally stored file
area_tbl =
  list.files("./inst/extdata", full.names = "TRUE") |>
  officer::read_docx() |>
  officer::docx_summary() |>
  # Need to have sf attached for next step to work.
  tibble::as_tibble() |>
  # clean data and extract names for divisions, areas and lgas
  dplyr::mutate(style_name = stringr::str_trim(style_name)) |>
  dplyr::filter(
    content_type == "paragraph",
    stringr::str_detect(
      stringr::str_to_lower(style_name),
      "^heading|bullet")) |>
  dplyr::mutate(division_name = stringr::str_extract(text,".*division"),
                area_name = stringr::str_extract(text, ".*local government areas") |> stringr::str_remove("\\s\\–\\sl.*"),
                lga_name = vpstheme::clean_vic_lga(text)) |>
  tidyr::fill(division_name) |>
  tidyr::fill(area_name) |>
  dplyr::select(contains("name")) |>
  dplyr::mutate(regional_lga = !stringr::str_detect(area_name,"Melbourne|Melton|Hume|Bayside")) |>
  dplyr::filter(
    stringr::str_detect(
        stringr::str_to_lower(style_name),
      "bullet")) |>
  dplyr::select(-style_name)

usethis::use_data(area_tbl, overwrite = TRUE)

# Get lga sf objects using read_absmap
lga_map =
  strayr::read_absmap(
    "lga2021",
    remove_year_suffix = TRUE) |>
  tibble::as_tibble() |>
  dplyr::filter(
    state_code == 2,
    !stringr::str_detect(lga_code,"^29")) |>
  dplyr::mutate(
    lga_name = vpstheme::clean_vic_lga(lga_name))

# Create area_map
division_map =
  area_tbl |>
  dplyr::right_join(lga_map) |>
  sf::st_as_sf() |>
  dplyr::group_by(division_name) |>
  dplyr::summarise() |>
  dplyr::group_by(division_name) |>
  dplyr::summarise()

# Add cent_lat and cent_long variables

division_map =
  dplyr::bind_cols(
    division_map,
    division_map |>
      dplyr::group_by(division_name) |>
      # Centroid
      sf::st_centroid() |>
      # Get coordinates
      sf::st_coordinates() |>
      tibble::as_tibble() |>
      dplyr::rename("cent_long"=X,"cent_lat"=Y))

# Save to data
usethis::use_data(division_map, overwrite = TRUE)

# Create area_map
area_map =
  area_tbl |>
  dplyr::left_join(lga_map) |>
  sf::st_as_sf()  |>
  dplyr::group_by(division_name, area_name) |>
  dplyr::summarise()

# Add cent_lat and cent_long variables

area_map =
  dplyr::bind_cols(
    area_map,
    area_map |>
      dplyr::group_by(area_name) |>
      # Centroid
      sf::st_centroid() |>
      # Get coordinates
      sf::st_coordinates() |>
      tibble::as_tibble() |>
      dplyr::rename("cent_long"=X,"cent_lat"=Y))

# Save to data
usethis::use_data(area_map, overwrite = TRUE)

