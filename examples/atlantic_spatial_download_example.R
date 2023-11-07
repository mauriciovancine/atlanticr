library(atlanticr)

# read table with metrics
atlantic_spatial

# import data
atlanticr::atlantic_spatial_download(id = 3, path = ".")

# delete
unlink("003_atlantic_spatial_forest_vegetation_binary*")
