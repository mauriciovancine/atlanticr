#' ---
#' title: "atlantic spatial data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic spatial ----------------------------------------------------

# fix data
atlantic_spatial <- readr::read_csv("data-raw/atlantic_spatial_description.csv") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_spatial, overwrite = TRUE)

# delete files
unlink("data-raw/atlantic_spatial_description.csv")
