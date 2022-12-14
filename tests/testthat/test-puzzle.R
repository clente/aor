test_that("puzzle_fetch() works", {

  vcr::use_cassette("part1_2022-12-01", {
    puzzle <- puzzle_fetch(1, "2022-12-01", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part1_2022-12-12", {
    puzzle <- puzzle_fetch(1, "2022-12-12", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part1_2021-12-01", {
    puzzle <- puzzle_fetch(1, "2021-12-01", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part1_2021-12-12", {
    puzzle <- puzzle_fetch(1, "2021-12-12", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part2_2022-12-01", {
    puzzle <- puzzle_fetch(2, "2022-12-01", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part2_2022-12-12", {
    puzzle <- puzzle_fetch(2, "2022-12-12", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part2_2021-12-01", {
    puzzle <- puzzle_fetch(2, "2021-12-01", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

  vcr::use_cassette("part2_2021-12-12", {
    puzzle <- puzzle_fetch(2, "2021-12-12", verbose = FALSE)
  })

  expect_snapshot_value(puzzle, "deparse")

})
