#' Create template for an Advent of Code puzzle
#'
#' @description
#' [day_start()] creates a directory with everything needed to start solving a
#' puzzle from the Advent of Code. Once the user submits part 1 of the puzzle,
#' [day_continue()] can append part 2 to the same file.
#'
#' See **Details** for more information on how this package converts HTML to
#' Markdown and how to sign in to your AoC account.
#'
#' # Conversion to Markdown
#'
#' Conversion from HTML to Markdown is made with [Pandoc](https://pandoc.org/).
#' If you use RStudio, you most likely already have Pandoc installed; otherwise,
#' make sure to install it before using this function.
#'
#' Pandoc is really good, but it's not perfect. I have chosen to, therefore,
#' implement a few aspects of the conversion manually:
#'
#' * Hidden tooltips (which only show up on the website when one hovers over the
#' text) are converted into inline footnotes on the final output.
#' * URLs that link to external sites have their `target` attribute removed.
#'
#' # Authentication
#'
#' This package is capable of using an authenticated session to fetch the 2nd
#' part of a puzzle after the user has answered the 1st part. For this to work,
#' the user must supply their session cookie as an environment variable called
#' `AOC_SESSION`.
#'
#' Please refer to the
#' [README](https://github.com/clente/aor/blob/main/README.md) for detailed
#' instructions on how to find and set your session cookie.
#'
#' @param date Day to fetch.
#' @param path Directory where to write the template.
#' @param verbose Whether to display progress or not.
#'
#' @export
day_start <- function(date = Sys.Date(), path = "./", verbose = TRUE) {

  # Validation
  date <- validate_date(date)

  # Fetch puzzle
  puzzle <- puzzle_fetch_text(1, date)
  if (verbose) cli::cli_alert_success("Fetched puzzle.")

  # Fetch input
  input <- input_fetch_text(date)
  if (verbose) cli::cli_alert_success("Fetched input.")

  # Parse title
  title <- puzzle |>
    utils::head(1) |>
    stringr::str_extract("(?<=[0-9]{1,2}\\: ).*?(?= ---$)") |>
    snakecase::to_snake_case()

  # Create directory
  dir <- date |>
    lubridate::day() |>
    stringr::str_pad(width = 2, pad = "0") |>
    stringr::str_c("_", title, "/") |>
    fs::path(path, ... = _) |>
    fs::path_norm() |>
    fs::dir_create()

  if (verbose) cli::cli_alert_success("Created directory {.file {dir}}")

  # Files
  f_puzzle <- fs::path(dir, "puzzle", ext = "R")
  f_input <- fs::path(dir, "input", ext = "txt")

  # Append instructions
  cmd <- stringr::str_glue('aor::day_continue("{date}", "{f_puzzle}")')
  puzzle <- c(
    puzzle,
    "",
    "# Your input can be found on the file below:",
    stringr::str_glue('input <- "{f_input}"'),
    "",
    "# Once you're done with part 1, run the following line to fetch part 2:",
    cmd
  )

  readr::write_lines(puzzle, f_puzzle)
  if (verbose) cli::cli_alert_success("Wrote part 1 to {.file {f_puzzle}}")

  readr::write_lines(input, f_input)
  if (verbose) cli::cli_alert_success("Wrote input to {.file {f_input}}")

  if (verbose) cli::cli_alert_info("To fetch part 2, run {.code {cmd}}")

  invisible(dir)
}

#' @rdname day_start
#' @param file Path to `puzzle.R` file created by [day_start()]
#'
#' @export
day_continue <- function(date, file, verbose = TRUE) {

  # Validation
  date <- validate_date(date)
  token <- validate_token()

  # Fetch puzzle
  puzzle <- puzzle_fetch_text(2, date)
  if (verbose) cli::cli_alert_success("Fetched puzzle.")

  # Append 2nd part to file
  puzzle <- c("", puzzle)
  readr::write_lines(puzzle, file, append = TRUE)
  if (verbose) cli::cli_alert_success("Wrote part 2 to {.file {file}}")

  invisible(file)
}
