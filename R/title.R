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
fetch_title <- function(date = Sys.Date()) {

  # Stop if the date is invalid
  if (lubridate::month(date) != 12 || lubridate::month(date) > 25) {
    stop("Invalid date.")
  }

  # Fetch title as a character string
  title <- fetch_title_text(date)

  # Show output to user
  cat(title, sep = "\n")
  cat("\n")

  # Write output to clipboard
  clipr::write_clip(title)
  cli::cli_alert_success("Title is on the clipboard.")

  invisible(title)

}

#' Utility function to fetch the title that [fetch_title()] outputs
#'
#' @noRd
fetch_title_text <- function(date) {

  # Fetch H2 of the page
  "https://adventofcode.com/" |>
    stringr::str_c(lubridate::year(date), "/day/", lubridate::day(date)) |>
    httr::GET() |>
    httr::content(encoding = "UTF-8") |>
    xml2::xml_find_first("//h2") |>
    xml2::xml_text() |>
    stringr::str_extract("(?<=: ).*?(?= ---)")
}
