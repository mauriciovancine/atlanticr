#' ---
#' title: "atlantic mammal traits data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic mammals ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2106

# unzip
unzip(zipfile = "data-raw/ecy2106-sup-0002-datas1.zip", exdir = "data-raw")

# fix data
atlantic_mammal_traits <- readr::read_csv("data-raw/ATLANTIC_TR_all_data.csv") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_mammal_traits, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2106-sup-0002-datas1.zip")
unlink("data-raw/ATLANTIC_TR_all_data.csv")
unlink("data-raw/ATLANTIC_TR_means.csv")
