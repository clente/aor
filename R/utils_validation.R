#' Check validity of `part` (and convert to numeric)
#'
#' @noRd
validate_part <- function(part) {

  part <- as.numeric(part)

  if (!part %in% c(1, 2)) {
    cli::cli_abort(c(
      "Supplied {.field part} is invalid.",
      i = "Part must be equal to either 1 or 2."
    ))
  }

  return(part)
}

#' Check validity of `date` (and convert to date)
#'
#' @noRd
validate_date <- function(date) {

  date <- lubridate::as_date(date)

  day <- lubridate::day(date) > 25
  month <- lubridate::month(date) != 12
  year <- lubridate::year(date) < 2015

  if (day || month || year) {
    cli::cli_abort(c(
      "Supplied {.field date} is invalid.",
      i = "Date must be between Dec. 1st and Dec. 25th, starting in 2015."
    ))
  }

  return(date)
}

#' Check validity of `AOC_SESSION`
#'
#' @noRd
validate_token <- function() {

  token <- Sys.getenv("AOC_SESSION", "")

  if (token == "") {
    cli::cli_abort(c(
      "Unable to authenticate: {.envvar AOC_SESSION} is invalid.",
      i = "See {.url https://github.com/clente/aor#authentication} to learn more."
    ))
  }

  return(token)
}

#' Check if pandoc is installed
#'
#' @noRd
validate_pandoc <- function() {

  version <- system("pandoc --version", intern = TRUE)[1]

  if (!stringr::str_detect(version, "^pandoc [0-9\\.]+$")) {
    cli::cli_abort(c(
      "Unable to find pandoc.",
      i = "See {.url https://pandoc.org/installing.html} to learn more."
    ))
  }

  return(version)
}
