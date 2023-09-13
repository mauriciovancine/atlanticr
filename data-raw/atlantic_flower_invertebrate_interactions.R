#' ---
#' title: "atlantic flower invertebrate interactions data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic mammals ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.3900

# unzip
unzip(zipfile = "data-raw/ecy3900-sup-0001-data_s1.zip", exdir = "data-raw")

# fix data
atlantic_flower_invertebrate_interactions <- readr::read_csv("data-raw/AtlanticForestInvertFloInteractionData_2022-07.csv") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_flower_invertebrate_interactions, overwrite = TRUE)

# delete files
unlink("data-raw/ecy3900-sup-0001-data_s1.zip")
unlink("data-raw/AtlanticForestInvertFloAuthorsInfo_2022-07.csv")
unlink("data-raw/AtlanticForestInvertFloInteractionData_2022-07.csv")
unlink("data-raw/Metadata_S1.pdf")
