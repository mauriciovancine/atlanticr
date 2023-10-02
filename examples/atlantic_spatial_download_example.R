library(atlanticr)

# read table with metrics
atlantic_spatial

# import data
atlanticr::atlantic_spatial_download(path = ".")

# delete
unlink("001_atlantic_spatial_all_classes.tif")
