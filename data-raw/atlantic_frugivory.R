#' ---
#' title: "atlantic frugivory data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic butterflies ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.1818

# unzip
unzip(zipfile = "data-raw/ecy1818-sup-0002-datas1.zip", exdir = "data-raw")

# import data
atlantic_frugivory <- readr::read_csv("data-raw/ATLANTIC_frugivory.csv") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_frugivory, overwrite = TRUE)

# delete files
unlink("data-raw/ecy1818-sup-0002-datas1.zip")
unlink("data-raw/ATLANTIC_frugivory.csv")
