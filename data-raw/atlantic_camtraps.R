#' ---
#' title: "atlantic camtraps data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic camtraps ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/10.1002/ecy.1998

# unzip
unzip(zipfile = "data-raw/ecy1998-sup-0001-datas1.zip", exdir = "data-raw")

# import data
atlantic_camtraps_location <- readr::read_csv("data-raw/ATLANTIC_CAMTRAPS_1-0_LOCATION.csv") %>%
    janitor::clean_names()
atlantic_camtraps_location

atlantic_camtraps_survey <- readr::read_csv("data-raw/ATLANTIC_CAMTRAPS_1-0_SURVEY.csv") %>%
    janitor::clean_names()
atlantic_camtraps_survey

atlantic_camtraps_species <- readr::read_csv("data-raw/ATLANTIC_CAMTRAPS_1-0_SPECIES.csv") %>%
    janitor::clean_names()
atlantic_camtraps_species

atlantic_camtraps_records <- readr::read_csv("data-raw/ATLANTIC_CAMTRAPS_1-0_RECORDS.csv") %>%
    janitor::clean_names()
atlantic_camtraps_records

# join data
atlantic_camtraps_location_survey <- dplyr::left_join(atlantic_camtraps_location, atlantic_camtraps_survey)
atlantic_camtraps_location_survey

atlantic_camtraps_species_records <- dplyr::left_join(atlantic_camtraps_species, atlantic_camtraps_records)
atlantic_camtraps_species_records

atlantic_camtraps <- dplyr::left_join(atlantic_camtraps_location_survey, atlantic_camtraps_species_records)
atlantic_camtraps

# save data
usethis::use_data(atlantic_camtraps, overwrite = TRUE)

# delete files
unlink("data-raw/ecy1998-sup-0001-datas1.zip")
unlink("data-raw/ATLANTIC_CAMTRAPS*")
