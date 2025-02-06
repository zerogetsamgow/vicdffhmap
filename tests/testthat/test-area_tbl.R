
test_that("Area table has all LGAs", {
  # Area table should have 79 rows
  expect_equal(nrow(area_tbl), 79L)
})

test_that("Area table has all areas", {
  # Area table should have 79 rows
  expect_equal(nrow(area_tbl |>
                      dplyr::select(area_name) |>
                      unique()), 17L)
})

test_that("Regional LGAs identified correctly", {
  # Area table should have 79 rows
  testthat::expect_equal(
    nrow(area_tbl |>
           dplyr::filter(regional_lga==TRUE)), 48L)

  testthat::expect_contains(
    area_tbl |>
      dplyr::filter(regional_lga) |>
      dplyr::pull(lga_name),
    c("Greater Geelong","Hepburn","Corangamite")
  )
})
