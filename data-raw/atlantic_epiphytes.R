#' ---
#' title: "atlantic epiphytes data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic epiphytes ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2541

# unzip
unzip(zipfile = "data-raw/ecy2541-sup-0002-datas1.zip", exdir = "data-raw")

# fix data
atlantic_epiphytes_abundance <- readr::read_delim("data-raw/DataS1_Abundance.txt", delim = "\t") %>%
    janitor::clean_names()

atlantic_epiphytes_occurrence <- readr::read_delim("data-raw/DataS1_Occurrence.txt", delim = "\t") %>%
    janitor::clean_names() %>%
    dplyr::mutate(year_finish = as.numeric(year_finish))

# combine data
atlantic_epiphytes <- dplyr::bind_rows(atlantic_epiphytes_abundance, atlantic_epiphytes_occurrence)
atlantic_epiphytes

# save data
usethis::use_data(atlantic_epiphytes, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2541-sup-0002-datas1.zip")
unlink("data-raw/DataS1_Abundance.txt")
unlink("data-raw/DataS1_Occurrence.txt")
unlink("data-raw/DataS1_References.csv")
unlink("data-raw/__MACOSX/", recursive = TRUE)
