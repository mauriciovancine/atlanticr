#' ---
#' title: "atlantic pollination data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic pollination ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.3595

# unzip
unzip(zipfile = "data-raw/ecy3595-sup-0001-datas1.zip", exdir = "data-raw")

# fix data
atlantic_pollination <- readr::read_delim("data-raw/DataS1/ATLANTIC-floverint_int.csv", delim = ";") %>%
    janitor::clean_names()
    dplyr::mutate(scientific_name_plant_ver = paste0(genera_plan_ver, "_", sp_plant_ver),
                  scientific_name_vert_ver = paste0(genera_floralvisitor_ver, "_", sp_floralvisitor_ver),
                  .after = 3)

atlantic_pollination_plant <- readr::read_delim("data-raw/DataS1/ATLANTIC-floverint_plant.csv", delim = ";") %>%
    janitor::clean_names() %>%
    dplyr::select(1:26) %>%
    dplyr::mutate(scientific_name_plant_ver = paste0(genera, "_", species), .after = 1)

atlantic_pollination_vert <- readr::read_delim("data-raw/DataS1/ATLANTIC-floverint_vert.csv", delim = ";") %>%
    janitor::clean_names() %>%
    dplyr::select(1:15) %>%
    dplyr::mutate(scientific_name_vert_ver = paste0(genera_ver, "_", species_ver), .after = 1)

# save data
usethis::use_data(atlantic_pollination, overwrite = TRUE)

# delete files
unlink("data-raw/ecy3595-sup-0001-datas1.zip")
unlink("data-raw/DataS1/", recursive = TRUE)
unlink("data-raw/MetadataS1.pdf")
