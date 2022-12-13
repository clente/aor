#' Fetch an Advent of Code puzzle
#'
#' @description
#' Fetch (part of) a puzzle from the Advent of Code given the day it was
#' published. This function automatically transforms the text of the puzzle into
#' an R multi-line comment and writes it to the clipboard.
#'
#' See **Details** for more information on how this package converts HTML into
#' Markdown and how to sign in to your AoC account.
#'
#' @inheritSection day_start Conversion to Markdown
#' @inheritSection day_start Authentication
#'
#' @param part Part to fetch (either 1 or 2).
#' @inheritParams day_start
#'
#' @seealso [day_start()]
#' @export
puzzle_fetch <- function(part = 1, date = Sys.Date(), verbose = TRUE) {

  # Fetch text as a character string
  puzzle <- puzzle_fetch_text(part, date)

  # Show output to user
  if (verbose) {
    cat(puzzle, sep = "\n")
    cat("\n")
  }

  # Write output to clipboard
  if (interactive()) clipr::write_clip(puzzle)
  if (verbose) cli::cli_alert_success("Puzzle is on the clipboard.")

  invisible(puzzle)
}

#' Utility function to fetch the text that [puzzle_fetch()] outputs
#'
#' @noRd
puzzle_fetch_text <- function(part, date) {

  # Stop if the part is invalid
  if (!part %in% c(1, 2)) {
    stop("Invalid part.")
  }

  # Stop if the date is invalid
  if (lubridate::month(date) != 12 || lubridate::day(date) > 25) {
    stop("Invalid date.")
  }

  # Stop if AOC_SESSION is needed but not provided
  token <- Sys.getenv("AOC_SESSION", "")
  if (part == 2 && token == "") {
    stop(
      "In order to fetch the 2nd part of a puzzle, you must ",
      "supply your session cookie via the AOC_SESSION env var."
    )
  }

  # Temp file to write text to
  temp <- fs::file_temp(ext = "html")
  on.exit(fs::file_delete(temp))

  # Fetch puzzle
  "https://adventofcode.com/" |>
    stringr::str_c(lubridate::year(date), "/day/", lubridate::day(date)) |>
    httr::GET(httr::set_cookies(session = token)) |>
    httr::content(encoding = "UTF-8") |>
    xml2::xml_find_all("//article") |>
    purrr::pluck(part) |>
    xml2::xml_find_all("./*") |>
    base::as.character() |>
    stringr::str_c(collapse = "\n") |>
    stringr::str_replace_all("<span .*?[\"'](.*?)[\"']>(.*?)</span>", "\\2^[\\1]") |>
    stringr::str_remove_all('target="_blank"') |>
    readr::write_file(temp)

  # Format text
  temp |>
    stringr::str_c("cat ", ... = _) |>
    stringr::str_c(" | pandoc --from html --to markdown_strict") |>
    base::system(intern = TRUE) |>
    stringr::str_c("# ", ... = _) |>
    stringr::str_replace("## ---", "---") |>
    stringr::str_remove(" $") |>
    stringr::str_replace_all("\\\\\\[", "[") |>
    stringr::str_replace_all("\\\\\\]", "]")
}
