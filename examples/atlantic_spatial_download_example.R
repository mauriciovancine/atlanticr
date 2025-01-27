library(atlanticr)

# read table with metrics
atlantic_spatial

# import data
atlanticr::atlantic_spatial_download(id = 0, path = ".")

# delete
unlink("000_atlantic_spatial_delimitation*")

#-- not run
if(FALSE) {
    # import multiple files
    atlanticr::atlantic_spatial_download(id = c(0, 1, 2), path = "../")
}
