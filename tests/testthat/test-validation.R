test_that("validate_part() works", {

  expect_error(puzzle_fetch(0, "2022-12-01"), "part is invalid")
  expect_error(puzzle_fetch(3, "2022-12-01"), "part is invalid")

})

test_that("validate_date() works", {

  expect_error(day_start("2022-12-26"), "date is invalid")
  expect_error(day_start("2022-11-30"), "date is invalid")
  expect_error(day_start("2014-12-01"), "date is invalid")

  expect_error(day_continue("2022-12-26", ""), "date is invalid")
  expect_error(day_continue("2022-11-30", ""), "date is invalid")
  expect_error(day_continue("2014-12-01", ""), "date is invalid")

  expect_error(input_fetch("2022-12-26"), "date is invalid")
  expect_error(input_fetch("2022-11-30"), "date is invalid")
  expect_error(input_fetch("2014-12-01"), "date is invalid")

  expect_error(puzzle_fetch(1, "2022-12-26"), "date is invalid")
  expect_error(puzzle_fetch(1, "2022-11-30"), "date is invalid")
  expect_error(puzzle_fetch(1, "2014-12-01"), "date is invalid")

})

test_that("validate_token() works", {
  withr::with_envvar(c("AOC_SESSION" = ""), {

    expect_error(day_continue("2022-12-01", ""), "Unable to authenticate")

    expect_error(input_fetch("2022-12-01"), "Unable to authenticate")

    expect_error(puzzle_fetch(1, "2022-12-01"), "Unable to authenticate")

  })
})
