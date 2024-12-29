#' ---
#' title: "atlantic camera trap mammals data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic camera trap mammals ------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/10.1002/ecy.4298

# download
download.file(url = "https://figshare.com/ndownloader/files/41311500",
              destfile = "data-raw/DATASET_CAMTRAP_SURVEYS_ATLANTICFOREST.csv", mode = "wb")

download.file(url = "https://figshare.com/ndownloader/files/41311503",
              destfile = "data-raw/DATASET_CAMTRAP_RECORDS_ATLANTICFOREST.csv", mode = "wb")

# import data
atlantic_camera_trap_mammals_surveys <- readr::read_delim("data-raw/DATASET_CAMTRAP_SURVEYS_ATLANTICFOREST.csv", delim = ";")
atlantic_camera_trap_mammals_surveys

atlantic_camera_trap_mammals <- readr::read_delim("data-raw/DATASET_CAMTRAP_RECORDS_ATLANTICFOREST.csv", delim = ";")
atlantic_camera_trap_mammals

# save data
usethis::use_data(atlantic_camera_trap_mammals_surveys, overwrite = TRUE)
usethis::use_data(atlantic_camera_trap_mammals, overwrite = TRUE)

# delete files
unlink("data-raw/DATASET_CAMTRAP_RECORDS_ATLANTICFOREST.csv")
unlink("data-raw/DATASET_CAMTRAP_SURVEYS_ATLANTICFOREST.csv")
