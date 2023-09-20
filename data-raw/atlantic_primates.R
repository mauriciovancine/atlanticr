#' ---
#' title: "atlantic primates data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)
library(janitor)

# atlantic primates ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.2785

# unzip
unzip(zipfile = "data-raw/ecy2525-sup-0001-datas1.zip", exdir = "data-raw")

# fix data
atlantic_primates_community <- readr::read_delim("data-raw/Dataset/ATLANTIC-PR_Community.csv",
                                       delim = ";") %>%
    janitor::clean_names()

atlantic_primates_occurence <- readr::read_delim("data-raw/Dataset/ATLANTIC-PR_Occurrence.csv",
                                                 delim = ";") %>%
    janitor::clean_names() %>%
    dplyr::select(1:33)

atlantic_primates_quantitative <- readr::read_delim("data-raw/Dataset/ATLANTIC-PR_Quantitative.csv",
                                                 delim = ";") %>%
    janitor::clean_names()

atlantic_primates_references <- readr::read_delim("data-raw/Dataset/ATLANTIC-PR_References.csv",
                                                 delim = ";", locale = readr::locale(encoding = "latin1")) %>%
    janitor::clean_names()

atlantic_primates <- atlantic_primates_community

# save data
usethis::use_data(atlantic_primates, overwrite = TRUE)

# delete files
unlink("data-raw/ecy2525-sup-0001-datas1.zip")
unlink("data-raw/Dataset/", recursive = TRUE)
