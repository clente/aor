# Scrub temp paths from the output so that snapshots work
scrub <- function(str) {

  rx_continue <- paste0(
    "(?<=day_continue\\([^0-9]{1,5}[0-9]{4}-[0-9]{2}-[0-9]{2}., [^/]{1,5})",
    ".*?",
    "(?=[0-9]{2}[a-z_]+/puzzle\\.R)"
  )

  rx_input <- paste0(
    "(?<=input <- [^/]{1,5})",
    ".*?",
    "(?=[0-9]{2}[a-z_]+/input\\.txt)"
  )

  str |>
    stringr::str_replace(rx_continue, "/") |>
    stringr::str_replace(rx_input, "/")
}

test_that("day_start() and day_continue() work", {

  # Fetch sample day
  vcr::use_cassette("start_2022-12-01", {
    dir <- day_start("2022-12-01", fs::path_temp(), verbose = FALSE)
  })

  puzzle <- fs::path(dir, "puzzle.R")
  input <- fs::path(dir, "input.txt")

  testthat::expect_snapshot_file(puzzle, transform = scrub, variant = "start_2022-12-01")
  testthat::expect_snapshot_file(input, transform = scrub, variant = "start_2022-12-01")

  # Continue sample day
  vcr::use_cassette("continue_2022-12-01", {
    day_continue("2022-12-01", puzzle, verbose = FALSE)
  })

  testthat::expect_snapshot_file(puzzle, transform = scrub, variant = "continue_2022-12-01")

  # Fetch sample day
  vcr::use_cassette("start_2022-12-12", {
    dir <- day_start("2022-12-12", fs::path_temp(), verbose = FALSE)
  })

  puzzle <- fs::path(dir, "puzzle.R")
  input <- fs::path(dir, "input.txt")

  testthat::expect_snapshot_file(puzzle, transform = scrub, variant = "start_2022-12-12")
  testthat::expect_snapshot_file(input, transform = scrub, variant = "start_2022-12-12")

  # Continue sample day
  vcr::use_cassette("continue_2022-12-12", {
    day_continue("2022-12-12", puzzle, verbose = FALSE)
  })

  testthat::expect_snapshot_file(puzzle, transform = scrub, variant = "continue_2022-12-12")

})
