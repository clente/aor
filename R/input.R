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
input_fetch <- function(date = Sys.Date(), verbose = TRUE) {

  # Fetch text as a character string
  input <- input_fetch_text(date)

  # Show output to user
  if (verbose) {
    cat(input, sep = "\n")
    cat("\n")
  }

  # Write output to clipboard
  if (interactive()) clipr::write_clip(input)
  if (verbose) cli::cli_alert_success("Input is on the clipboard.")

  invisible(input)
}

#' Utility function to fetch the text that [input_fetch()] outputs
#'
#' @noRd
input_fetch_text <- function(date) {

  # Validation
  date <- validate_date(date)
  token <- validate_token()

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
