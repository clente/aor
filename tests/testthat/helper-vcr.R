library("vcr") # *Required* as vcr is set up on loading
invisible(vcr::vcr_configure(
  dir = vcr::vcr_test_path("fixtures")
))
vcr::check_cassette_names()

# Mock the existance of an AOC session to fool validate_token()
if (Sys.getenv("AOC_SESSION", "") == "") {
  Sys.setenv("AOC_SESSION" = "VCR_MOCK")
}
