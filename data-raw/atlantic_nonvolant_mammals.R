#' ---
#' title: "atlantic non-volant mammals data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic bats ---------------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/10.1002/ecy.2107

# unzip
unzip(zipfile = "data-raw/ecy2107-sup-0002-datas1.zip", exdir = "data-raw")

# import data
atlantic_nonvolant_mammals_sites <- readr::read_csv("data-raw/Mammals_UPRB_study_sites.csv") %>%
    janitor::clean_names() %>%
    dplyr::mutate(site = as.character(site))

atlantic_nonvolant_mammals_species <- readr::read_csv("data-raw/Mammals_UPRB_species.csv") %>%
    janitor::clean_names() %>%
    tidyr::pivot_longer(cols = -c(order, family, genus, species, frequency_of_occurrence, iucn_status, brazilian_status),
                        names_to = "site", values_to = "incidence") %>%
    dplyr::filter(incidence > 0) %>%
    dplyr::select(-incidence) %>%
    dplyr::mutate(site = stringr::str_replace_all(site, "site_", ""))

atlantic_nonvolant_mammals_records <- readr::read_csv("data-raw/Mammals_UPRB_records.csv") %>%
    janitor::clean_names()

# join
atlantic_nonvolant_mammals <- dplyr::left_join(atlantic_nonvolant_mammals_sites, atlantic_nonvolant_mammals_species) %>%
    dplyr::left_join(atlantic_nonvolant_mammals_records)

# save data
usethis::use_data(atlantic_nonvolant_mammals, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2107-sup-0002-datas1.zip")
unlink("data-raw/Mammals_UPRB_*")
