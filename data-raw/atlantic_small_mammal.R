#' ---
#' title: "atlantic small mammal data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(data.table)
library(janitor)

# atlantic small mammal ---------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.1893

# unzip
unzip(zipfile = "data-raw/ecy1893-sup-0002-datas1.zip", exdir = "data-raw")

# import
atlantic_small_mammal_sites <- data.table::fread("data-raw/ATLANTIC_SM_Study_Site.csv", encoding = "Latin-1") %>%
    tibble::as_tibble() %>%
    janitor::clean_names()

atlantic_small_mammal_species <- data.table::fread("data-raw/ATLANTIC_SM_Capture.csv", encoding = "Latin-1") %>%
    tibble::as_tibble() %>%
    janitor::clean_names()

atlantic_small_mammal_references <- data.table::fread("data-raw/ATLANTIC_SM_Reference.csv", encoding = "Latin-1") %>%
    tibble::as_tibble() %>%
    janitor::clean_names() %>%
    dplyr::mutate(reference_number = as.character(reference_number))

# join
atlantic_small_mammal <- atlantic_small_mammal_sites %>%
    dplyr::left_join(atlantic_small_mammal_species) %>%
    dplyr::left_join(atlantic_small_mammal_references)

# save data
usethis::use_data(atlantic_small_mammal, overwrite = TRUE)

# delete files
unlink("data-raw/ecy1893-sup-0002-datas1.zip")
unlink("data-raw/ATLANTIC_SM_*")
unlink("data-raw/__MACOSX/", recursive = TRUE)
