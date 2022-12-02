#' Start solving a puzzle from the Advent of Code
#'
#' Create a directory with everything the user needs to start solving a puzzle
#' from the Advent of Code. Once the 1st part is done, [day_continue()] appends
#' the 2nd part to the file created by this function.
#'
#' @param date Day to fetch.
#' @param path Where to create directory.
#'
#' @return Path to the created directory.
#'
#' @seealso [day_continue()]
#' @export
day_start <- function(date = Sys.Date(), path = "./") {

  # Stop if the date is invalid
  if (lubridate::month(date) != 12 || lubridate::day(date) > 25) {
    stop("Invalid date.")
  }

  # Fetch title
  title <- snakecase::to_snake_case(title_fetch_text(date))
  cli::cli_alert_success("Fetched title.")

  # Fetch puzzle
  puzzle <- puzzle_fetch_text(1, date)
  cli::cli_alert_success("Fetched puzzle.")

  # Fetch input
  input <- input_fetch_text(date)
  cli::cli_alert_success("Fetched input.")

  # Create directory
  dir <- date |>
    lubridate::day() |>
    stringr::str_pad(width = 2, pad = "0") |>
    stringr::str_c("_", title, "/") |>
    fs::path(path, ... = "_") |>
    fs::path_norm() |>
    fs::dir_create()

  # Files
  f_puzzle <- fs::path(dir, "puzzle", ext = "R")
  f_input <- fs::path(dir, "input", ext = "txt")

  # Append instructions
  puzzle <- c(
    puzzle,
    "",
    "# Your input can be found on the file below:",
    stringr::str_c('input <- "', f_input, '"'),
    "",
    "# Once you're done with part 1, run the following line to fetch part 2:",
    stringr::str_c('aor::day_continue("', as.character(date), '", "', f_puzzle, '")')
  )

  readr::write_lines(puzzle, f_puzzle)
  readr::write_lines(input, f_input)

  invisible(dir)
}

#' Continue solving a puzzle from the Advent of Code
#'
#' Given a file created by [day_start()], append the 2nd part of a puzzle to the
#' end of said file.
#'
#' # Authentication
#'
#' This function is capable of using an authenticated session to fetch the 2nd
#' part of a puzzle after the user has answered the 1st part. For this to work,
#' the user must supply their session cookie as an environment variable called
#' `AOC_SESSION`.
#'
#' @param date Day to fetch.
#' @param path Path to a file created by [day_start()].
#'
#' @return Path to the appended file.
#'
#' @seealso [day_start()]
#' @export
day_continue <- function(date, path) {

  # Stop if the date is invalid
  if (lubridate::month(date) != 12 || lubridate::day(date) > 25) {
    stop("Invalid date.")
  }

  # Stop if AOC_SESSION is needed but not provided
  token <- Sys.getenv("AOC_SESSION", "")
  if (token == "") {
    stop(
      "In order to fetch the 2nd part of a puzzle, you must ",
      "supply your session cookie via the AOC_SESSION env var."
    )
  }

  # Fetch puzzle
  puzzle <- puzzle_fetch_text(2, date)
  cli::cli_alert_success("Fetched puzzle.")

  # Append 2nd part to file
  puzzle <- c("", puzzle)
  readr::write_lines(puzzle, path, append = TRUE)

  invisible(path)
}
