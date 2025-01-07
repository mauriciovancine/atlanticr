library(atlanticr)

# read table with metrics
atlantic_spatial

# import data
atlanticr::atlantic_spatial_download(id = 0, path = ".")

# delete
unlink("000_atlantic_spatial_delimitation*")
