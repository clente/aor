
<!-- README.md is generated from README.Rmd. Please edit that file -->

# aor

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/clente/aor/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/clente/aor/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of aor is to help useRs solve the [Advent of
Code](https://adventofcode.com/) in R! It has some helper functions to
fetch puzzles and inputs as quickly as possible.

## Installation

You can install the development version of aor from
[GitHub](https://github.com/clente/aor) with:

``` r
# install.packages("devtools")
devtools::install_github("clente/aor")
```

aor also calls [pandoc](https://pandoc.org/) internally. If you don’t
use RStudio, you might have to install pandoc manually before using this
package.

## Authentication

Before using aor, you’ll probably want to save your Advent of Code
session cookie as an environment variable; this is necessary for aor to
fetch the 2nd part of puzzles.

In order to find your session cookie, do the following:

1.  Navigate to <https://adventofcode.com/>.
2.  Press `F12` to open your browser’s developer tools.
3.  Select the Network tab.
4.  Reload the page.
5.  Click on the first request that shows up.
6.  In Request Headers, copy the long string after `session=`.

<img src="man/figures/authentication.webp" width="100%" />

Once you have your session cookie, add it to an environment variable
called `AOC_SESSION`. You can do this by running the following command:

``` r
# Add your cookie to .Renviron
readr::write_lines('AOC_SESSION="YOUR_COOKIE"', "~/.Renviron", append = TRUE)
```

If this doesn’t work even after restarting R, your can force your
session cookie directly with the following command (just remember to
**never upload your cookie to GitHub**):

``` r
# Set the environment variable directly
Sys.setenv("AOC_SESSION" = "YOUR_COOKIE")
```

## Example

The basic usage of aor revolves around `day_start()` and
`day_continue()`. By default, both functions fetch the **current day’s
puzzle**, but I’ll use `2022-12-01` as the example here:

``` r
# Start the puzzle for 2022-12-01 in the aoc2022/ directory
aor::day_start("2022-12-01", "aoc2022/")
#> ✔ Fetched puzzle.
#> ✔ Fetched input.
#> ✔ Created directory 'aoc2022/01_calorie_counting'
#> ✔ Wrote part 1 to 'aoc2022/01_calorie_counting/puzzle.R'
#> ✔ Wrote input to 'aoc2022/01_calorie_counting/input.txt'
#> ℹ To fetch part 2, run `aor::day_continue("2022-12-01", "aoc2022/01_calorie_counting/puzzle.R")`

# Files created
fs::dir_tree("aoc2022/")
#> aoc2022/
#> └── 01_calorie_counting
#>     ├── input.txt
#>     └── puzzle.R
```

Here is what `aoc2022/01_calorie_counting/puzzle.R` looks like (note
that I’m omitting most of the question so that the output is not super
long):

``` r
# --- Day 1: Calorie Counting ---
#
# Santa's reindeer typically eat regular reindeer food, but they need a
# lot of [magical energy](/2018/day/25) to deliver presents on Christmas.
# For that, their favorite snack is a special type of *star* fruit that
# only grows deep in the jungle. The Elves have brought you on their
# annual expedition to the grove where the fruit grows.
#
# ...
#
# Find the Elf carrying the most Calories. *How many total Calories is
# that Elf carrying?*

# Your input can be found on the file below:
input <- "aoc2022/01_calorie_counting/input.txt"

# Once you're done with part 1, run the following line to fetch part 2:
aor::day_continue("2022-12-01", "aoc2022/01_calorie_counting/puzzle.R")
```

Once you solve part 1 of the puzzle, you can run the last line of the
template to automatically fetch part 2 into the same file!

``` r
aor::day_continue("2022-12-01", "aoc2022/01_calorie_counting/puzzle.R")
#> ✔ Fetched puzzle.
#> ✔ Wrote part 2 to 'aoc2022/01_calorie_counting/puzzle.R'
```

And here is what the file looks like after running `day_continue()`
(again omitting most of the question):

``` r
# --- Day 1: Calorie Counting ---
#
# Santa's reindeer typically eat regular reindeer food, but they need a
# lot of [magical energy](/2018/day/25) to deliver presents on Christmas.
# For that, their favorite snack is a special type of *star* fruit that
# only grows deep in the jungle. The Elves have brought you on their
# annual expedition to the grove where the fruit grows.
#
# ...
#
# Find the Elf carrying the most Calories. *How many total Calories is
# that Elf carrying?*

# Your input can be found on the file below:
input <- "aoc2022/01_calorie_counting/input.txt"

# Once you're done with part 1, run the following line to fetch part 2:
aor::day_continue("2022-12-01", "aoc2022/01_calorie_counting/puzzle.R")

# --- Part Two ---
#
# By the time you calculate the answer to the Elves' question, they've
# already realized that the Elf carrying the most Calories of food might
# eventually *run out of snacks*.
#
# ...
#
# Find the top three Elves carrying the most Calories. *How many Calories
# are those Elves carrying in total?*
```

Good luck! See you on the other side!

## Ethics

The source code of the Advent of Code has a message for us:

> *Please be careful with automated requests; I’m not a massive company,
> and I can only take so much traffic. Please be considerate so that
> everyone gets to play.*

With this in mind, aor makes **exactly** the same number of requests as
a regular user would: one to get part 1 of the puzzle, one to get the
input and one to get part 2. Even aor’s unit tests are mocked!

Having said this, please refrain from making spurious requests using
aor; **don’t** create bots, scrapers, or anything of the like. Thanks
for your comprehension.
