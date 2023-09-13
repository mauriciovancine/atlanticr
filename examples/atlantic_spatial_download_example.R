library(atlanticr)
library(terra)

# read table with metrics
atlantic_spatial

# import data
r <- atlanticr::atlantic_spatial_download(import = TRUE,
                                          path = ".")

# raster
r

# delete
unlink("atlantic_spatial_forest_vegetation_binary.tif")
