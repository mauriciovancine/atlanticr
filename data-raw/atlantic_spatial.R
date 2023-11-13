#' ---
#' title: "atlantic spatial data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic spatial ----------------------------------------------------

# fix data
atlantic_spatial <- readr::read_csv("/home/mude/data/github/mauriciovancine/ATLANTIC-SPATIAL/data/atlantic_spatial_description.csv") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_spatial, overwrite = TRUE)
