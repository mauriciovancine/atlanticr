#' ---
#' title: "atlantic mammals data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# source
source("R/aux_fix_enconding.R")

# atlantic mammals ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2785

# unzip
unzip(zipfile = "data-raw/ecy2785-sup-0001-datas1.zip", exdir = "data-raw")

# fix data
atlantic_mammals <- readr::read_csv("data-raw/ATLANTIC_MAMMAL_MID_LARGE _assemblages_and_sites.csv") %>%
    janitor::clean_names()

# fix encongind
encoding_results <- fix_encoding(atlantic_mammals)
atlantic_mammals <- encoding_results$data

# save data
usethis::use_data(atlantic_mammals, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2785-sup-0001-datas1.zip")
unlink("data-raw/ATLANTIC_MAMMAL_MID_LARGE _assemblages_and_sites.csv")
