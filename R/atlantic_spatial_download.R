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
                                      path = "."){

    # options
    options(timeout = 1e4)

    # directory
    setwd(path)

    # download
    googledrive::drive_deauth()
    googledrive::drive_user()
    file_id <- googledrive::as_id("1yPGzwXYy8bYqV5xl31W8iFCXJUdRufsF")
    file <- googledrive::drive_get(file_id)
    googledrive::drive_download(file)

}
