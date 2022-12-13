#' Check validity of `part` (and convert to numeric)
#'
#' @noRd
validate_part <- function(part) {

  part <- as.numeric(part)

  if (!part %in% c(1, 2)) {
    cli::cli_abort(c(
      "Supplied `part` is invalid",
      i = "Part must be equal to either 1 or 2"
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
      "Supplied `date` is invalid",
      i = "Date must be between Dec. 1st and Dec. 25th, starting in 2015"
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
      "`AOC_SESSION` is invalid, unable to authenticate",
      i = "See 'https://github.com/clente/aor#authentication' to learn more"
    ))
  }

  return(token)
}
