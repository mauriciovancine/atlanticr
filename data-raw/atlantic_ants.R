#' ---
#' title: "atlantic ants data preparation"
#' ---

# prepare r -------------------------------------------------------------

# packages
library(tidyverse)

# atlantic ants ----------------------------------------------------

# download
# download data from https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/ecy.3580

# unzip
unzip(zipfile = "data-raw/ecy3580-sup-0001-datas1.zip", exdir = "data-raw")

# fix data
atlantic_ants <- readr::read_delim("data-raw/ATLANTIC_ANTS_dataset.txt", delim = "\t") %>%
    janitor::clean_names()

# save data
usethis::use_data(atlantic_ants, overwrite = TRUE)

# delete files
unlink("data-raw/ecy3580-sup-0001-datas1.zip")
unlink("data-raw/ATLANTIC_ANTS_dataset.txt")
unlink("data-raw/ATLANTIC_ANTS_references.docx")
unlink("data-raw/MetadataS1 2021-12-21d.docx")
