#' Fetch the title of a puzzle from the Advent of Code
#'
#' Fetch the title of a puzzle from the Advent of Code given the day it was
#' published.
#'
#' @param date Day to fetch.
#'
#' @return A character string.
#'
#' @export
title_fetch <- function(date = Sys.Date()) {

  # Stop if the date is invalid
  if (lubridate::month(date) != 12 || lubridate::day(date) > 25) {
    stop("Invalid date.")
  }

  # Fetch title as a character string
  title <- title_fetch_text(date)

  # Show output to user
  cat(title, sep = "\n")
  cat("\n")

  # Write output to clipboard
  clipr::write_clip(title)
  cli::cli_alert_success("Title is on the clipboard.")

  invisible(title)
}

#' Utility function to fetch the title that [title_fetch()] outputs
#'
#' @noRd
title_fetch_text <- function(date) {

  # Fetch H2 of the page
  "https://adventofcode.com/" |>
    stringr::str_c(lubridate::year(date), "/day/", lubridate::day(date)) |>
    httr::GET() |>
    httr::content(encoding = "UTF-8") |>
    xml2::xml_find_first("//h2") |>
    xml2::xml_text() |>
    stringr::str_extract("(?<=: ).*?(?= ---)")
}
