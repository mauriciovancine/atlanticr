#' ---
#' title: "atlantic spatial data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic spatial ----------------------------------------------------

# fix data
atlantic_spatial <- readr::read_csv("https://raw.githubusercontent.com/mauriciovancine/ATLANTIC-SPATIAL/refs/heads/main/data/atlantic_spatial_description.csv") %>%
    janitor::clean_names()
atlantic_spatial

# save data
usethis::use_data(atlantic_spatial, overwrite = TRUE)
