#' Atlantic Spatial
#'
#' ATLANTIC SPATIAL: a dataset of landscape, topographic, hydrologic and anthropogenic metrics for the Atlantic Forests of South America
#'
#' @param metric \cr
#' @param scale  \cr
#' @param edge_depth \cr
#' @param gap_crossing \cr
#' @param import \cr
#' @param path \cr
#'
#' @example examples/atlantic_spatial_download_example.R
#'
#' @name atlantic_spatial_download
#' @export
atlantic_spatial_download <- function(metric,
                                      scale,
                                      edge_depth,
                                      gap_crossing,
                                      import = FALSE,
                                      path = "."){

    # options
    options(timeout = 1e4)

    # directory
    setwd(path)

    # download
    download.file(url = "https://drive.usercontent.google.com/download?id=1a00sNlhamU8ahtcB24WD6JXwQqz0RZbo&export=download&authuser=0&confirm=t&uuid=6ce139fc-2cad-419f-b382-ddb7f0c83e77&at=APZUnTV_lMBu0WOUCQxJlbVLLurc:1694490404074",
                  destfile = "atlantic_spatial_forest_vegetation_binary.tif", mode = "wb")

    # import
    if(import){
        r <- terra::rast("atlantic_spatial_forest_vegetation_binary.tif")
        return(r)
    }

}
