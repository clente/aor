
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
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("clente/aor")
```

## Supply Session Cookie
You'll need to obtain and supply your AOC session cookie to get the right puzzle inputs.

### Obtain Session Cookie
1.  Navigate to any AOC page.
2.  Right-click anywhere and select 'inspect element'
3.  Click the Network tab, then All
4.  Reload the page
5.  Select any object from the left, then click Headers
6.  Your session cookie is the long hexadecimal string after `Cookie: session=`. Copy this

### Supply the Session Cookie
In R, run this command:
``` R
Sys.setenv('AOC_SESSION' = 'your_session_cookie')
```

## Example

The basic usage of aor revolves around `day_start()` and
`day_continue()`. By default, both functions fetch the **current day’s
puzzle**, but I’ll use `2022-12-01` as the example here:

``` r
# Start the puzzle for 2022-12-01 in the aoc2022/ directory
aor::day_start("2022-12-01", "aoc2022/")
#> ✔ Fetched title.
#> ✔ Fetched puzzle.
#> ✔ Fetched input.

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
```

And here is what the file looks like after runing `day_continue()`
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
