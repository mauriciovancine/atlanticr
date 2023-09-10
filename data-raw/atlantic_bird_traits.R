#' ---
#' title: "atlantic bird traits data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic bird traits --------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2647

# unzip
unzip(zipfile = "data-raw/ecy2647-sup-0001-datas1.zip", exdir = "data-raw")

# fix data
atlantic_bird_traits <- readr::read_csv("data-raw/ATLANTIC_BIRD_TRAITS_completed_2018_11_d05.csv") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_bird_traits, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2647-sup-0001-datas1.zip")
unlink("data-raw/ATLANTIC_*")
unlink("data-raw/MetadataS1_PROOF_RCR.pdf")
