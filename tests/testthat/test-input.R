test_that("input_fetch() works", {

  vcr::use_cassette("input_2022-12-01", {
    puzzle <- input_fetch("2022-12-01", verbose = FALSE)
  })

  testthat::expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("input_2022-12-12", {
    puzzle <- input_fetch("2022-12-12", verbose = FALSE)
  })

  testthat::expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("input_2021-12-01", {
    puzzle <- input_fetch("2021-12-01", verbose = FALSE)
  })

  testthat::expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("input_2021-12-12", {
    puzzle <- input_fetch("2021-12-12", verbose = FALSE)
  })

  testthat::expect_snapshot_value(puzzle, "deparse")

})
