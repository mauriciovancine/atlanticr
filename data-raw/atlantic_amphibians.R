#' ---
#' title: "atlantic amphibian data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(fastDummies)

# atlantic amphibians ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2392

# unzip
unzip(zipfile = "data-raw/ecy2392-sup-0001-datas1.zip", exdir = "data-raw")

# fix data
readr::read_csv("data-raw/ATLANTIC_AMPHIBIANS_references.csv",
                locale = readr::locale(encoding = "latin1")) %>%
    readr::write_csv("data-raw/ATLANTIC_AMPHIBIANS_references_fix.csv")

readr::read_csv("data-raw/ATLANTIC_AMPHIBIANS_sites.csv",
                locale = readr::locale(encoding = "latin1")) %>%
    readr::write_csv("data-raw/ATLANTIC_AMPHIBIANS_sites_fix.csv")

readr::read_csv("data-raw/ATLANTIC_AMPHIBIANS_species.csv",
                locale = readr::locale(encoding = "latin1")) %>%
    readr::write_csv("data-raw/ATLANTIC_AMPHIBIANS_species_fix.csv")

# import sites
si <- readr::read_csv("data-raw/ATLANTIC_AMPHIBIANS_sites_fix.csv") %>%
    fastDummies::dummy_cols("sampled_habitat", split = ",") %>%
    dplyr::relocate(sampled_habitat_br:sampled_habitat_NA, .after = sampled_habitat) %>%
    fastDummies::dummy_cols("active_methods", split = ",") %>%
    dplyr::relocate(active_methods_as:active_methods_NA, .after = active_methods) %>%
    fastDummies::dummy_cols("passive_methods", split = ",") %>%
    dplyr::relocate(passive_methods_ar:passive_methods_NA, .after = passive_methods) %>%
    fastDummies::dummy_cols("complementary_methods", split = ",") %>%
    dplyr::relocate(complementary_methods_ae:complementary_methods_NA, .after = complementary_methods) %>%
    fastDummies::dummy_cols("period", split = ",") %>%
    dplyr::relocate(period_da:period_NA, .after = period)

# import communities
sp <- read_csv("data-raw/ATLANTIC_AMPHIBIANS_species_fix.csv") %>%
    tidyr::drop_na(valid_name) %>%
    dplyr::select(id, valid_name, individuals) %>%
    dplyr::distinct(id, valid_name, .keep_all = TRUE) %>%
    dplyr::mutate(individuals = tidyr::replace_na(individuals, 1),
                  individuals = ifelse(individuals > 0, 1, 1))

# import references
rf <- read_csv("data-raw/ATLANTIC_AMPHIBIANS_references_fix.csv")

# join longer
atlantic_amphibians <- dplyr::left_join(si, sp) %>%
    dplyr::left_join(rf)

# save data
usethis::use_data(atlantic_amphibians, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2392-sup-0001-datas1.zip")
unlink(dir(path = "data-raw/", pattern = "ATLANTIC_AMPHIBIANS_", full.names = TRUE))
