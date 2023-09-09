#' ---
#' title: "atlantic butterflies data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic butterflies ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2507

# unzip
unzip(zipfile = "data-raw/ecy2507-sup-0001-datas1.zip", exdir = "data-raw")

# fix
readr::read_delim("data-raw/ATLANTIC_BUTTERFLIES_sites.csv", delim = ";",
                  locale = readr::locale(encoding = "latin1")) %>%
    readr::write_csv("data-raw/ATLANTIC_BUTTERFLIES_sites.csv")

readr::read_delim("data-raw/ATLANTIC_BUTTERFLIES_species.csv", delim = ";",
                  locale = readr::locale(encoding = "latin1")) %>%
    dplyr::select(1:9) %>%
    readr::write_csv("data-raw/ATLANTIC_BUTTERFLIES_species.csv")

readr::read_delim("data-raw/ATLANTIC_BUTTERFLIES_references.csv", delim = ";",
                  locale = readr::locale(encoding = "latin1")) %>%
    readr::write_csv("data-raw/ATLANTIC_BUTTERFLIES_references.csv")

# import data
atlantic_butterflies_sites <- readr::read_delim("data-raw/ATLANTIC_BUTTERFLIES_sites.csv") %>%
    janitor::clean_names()

atlantic_butterflies_species <- readr::read_csv("data-raw/ATLANTIC_BUTTERFLIES_species.csv") %>%
    janitor::clean_names()

atlantic_butterflies_references <- readr::read_delim("data-raw/ATLANTIC_BUTTERFLIES_references.csv") %>%
    janitor::clean_names()

# combine data
atlantic_butterflies <- atlantic_butterflies_sites %>%
    dplyr::left_join(atlantic_butterflies_species)

# save data
usethis::use_data(atlantic_butterflies, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2507-sup-0001-datas1.zip")
unlink("data-raw/ATLANTIC_BUTTERFLIES*")
