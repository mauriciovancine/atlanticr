#' ---
#' title: "atlantic small mammal abundance data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)
library(fastDummies)

# atlantic small mammal abundance ---------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2005

# unzip
unzip(zipfile = "data-raw/ecy2005-sup-0001-datas1.zip", exdir = "data-raw")

# import sites
atlantic_small_mammal_abundance_sites <- readr::read_delim("data-raw/Localities.csv", delim = ";",
                locale = readr::locale(encoding = "latin1")) %>%
    janitor::clean_names() %>%
    dplyr::relocate(longitude, .before = latitude)

atlantic_small_mammal_abundance_species <- readr::read_delim("data-raw/Mammal_Communities.csv", delim = ";",
                                                     locale = readr::locale(encoding = "latin1")) %>%
    janitor::clean_names() %>%
    dplyr::select(1:4)

# join longer
atlantic_small_mammal_abundance <- atlantic_small_mammal_abundance_sites %>%
    dplyr::left_join(atlantic_small_mammal_abundance_species)

# save data
usethis::use_data(atlantic_small_mammal_abundance, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2005-sup-0001-datas1.zip")
unlink("data-raw/Localities.csv")
unlink("data-raw/References.csv")
unlink("data-raw/Mammal_Communities.csv")
