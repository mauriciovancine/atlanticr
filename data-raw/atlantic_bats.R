#' ---
#' title: "atlantic bats data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic bats ---------------------------------------------------------

# download
download.file(url = "https://raw.githubusercontent.com/LEEClab/Atlantic_series/master/ATLANTIC_BATS/DATASET/2018_02_d21/ATLANTIC_BATS_2020_comp.xlsx",
              destfile = "data-raw/ATLANTIC_BATS_2020_comp.xlsx", mode = "wb")

# import data
atlantic_bats <- readxl::read_excel("data-raw/ATLANTIC_BATS_2020_comp.xlsx") %>%
    janitor::clean_names() %>%
    dplyr::select(-id_20, -id_137) %>%
    dplyr::rename(id = id_1)

# separate data
atlantic_bats_sites <- atlantic_bats %>%
    dplyr::select(c(1:31, 136:139))

atlantic_bats_species <- atlantic_bats %>%
    dplyr::select(c(1, 32:135)) %>%
    tidyr::pivot_longer(cols = -1,
                        names_to = "species",
                        values_to = "abundance")

# join
atlantic_bats <- dplyr::left_join(atlantic_bats_sites, atlantic_bats_species)

# save data
usethis::use_data(atlantic_bats, overwrite = TRUE)

# delete files
unlink("data-raw/ATLANTIC_BATS_2020_comp.xlsx")
