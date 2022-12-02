#' Fetch an Advent of Code puzzle's input
#'
#' Fetch the input of a puzzle from the Advent of Code given the day it was
#' published. This function automatically reads the input line by line and
#' writes it to the clipboard.
#'
#' @inheritParams day_start
#'
#' @seealso [day_start()]
#' @export
input_fetch <- function(date = Sys.Date()) {

  # Fetch text as a character string
  input <- input_fetch_text(date)

  # Show output to user
  cat(input, sep = "\n")
  cat("\n")

  # Write output to clipboard
  clipr::write_clip(input)
  cli::cli_alert_success("Input is on the clipboard.")

  invisible(input)
}

#' Utility function to fetch the text that [input_fetch()] outputs
#'
#' @noRd
input_fetch_text <- function(date) {

  # Stop if the date is invalid
  if (lubridate::month(date) != 12 || lubridate::day(date) > 25) {
    stop("Invalid date.")
  }

  # Stop if AOC_SESSION is not provided
  token <- Sys.getenv("AOC_SESSION", "")
  if (token == "") {
    stop(
      "In order to fetch the input of a puzzle, you must ",
      "supply your session cookie via the AOC_SESSION env var."
    )
  }

  # Fetch input
  "https://adventofcode.com/" |>
    stringr::str_c(
      lubridate::year(date), "/day/",
      lubridate::day(date), "/input"
    ) |>
    httr::GET(httr::set_cookies(session = token)) |>
    httr::content(encoding = "UTF-8") |>
    stringr::str_split("\n") |>
    purrr::pluck(1)
}
