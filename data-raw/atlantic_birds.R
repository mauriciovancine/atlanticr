#' ---
#' title: "atlantic birds data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic birds -------------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2119

# unzip
unzip(zipfile = "data-raw/ecy2119-sup-0002-datas1.zip", exdir = "data-raw")

# fix data
atlantic_birds_qualitative <- readr::read_csv("data-raw/DataS1/DataS1/ATLANTIC_BIRDS_qualitative.csv") %>%
    janitor::clean_names()

atlantic_birds_quantitative <- readr::read_csv("data-raw/DataS1/DataS1/ATLANTIC_BIRDS_quantitative.csv") %>%
    janitor::clean_names()

atlantic_birds_species <- readr::read_csv("data-raw/DataS1/DataS1/ATLANTIC_birds_species.csv") %>%
    janitor::clean_names()

atlantic_birds_references <- readr::read_csv("data-raw/DataS1/DataS1/ATLANTIC_BIRDS_refs.csv") %>%
    janitor::clean_names()

# join
atlantic_birds <- atlantic_birds_quantitative

# save data
usethis::use_data(atlantic_birds, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2119-sup-0002-datas1.zip")
unlink("data-raw/DataS1/", recursive = TRUE)
