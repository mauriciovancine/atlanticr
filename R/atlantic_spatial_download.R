#' Atlantic Spatial
#'
#' ATLANTIC SPATIAL: a dataset of landscape, topographic, hydrologic and anthropogenic metrics for the Atlantic Forests of South America
#'
#' @param metric \cr
#' @param metric_group  \cr
#' @param metric_type  \cr
#' @param lulc_class  \cr
#' @param edge_depth \cr
#' @param gap_crossing \cr
#' @param scale  \cr
#' @param resolution  \cr
#' @param cores  \cr
#' @param path \cr
#'
#' @example examples/atlantic_spatial_download_example.R
#'
#' @name atlantic_spatial_download
#' @export
atlantic_spatial_download <- function(id = NULL,
                                      metric = NULL,
                                      metric_group = NULL,
                                      metric_type = NULL,
                                      lulc_class = NULL,
                                      edge_depth = NULL,
                                      gap_crossing = NULL,
                                      scale = NULL,
                                      resolution = NULL,
                                      path = "."){

    # options
    options(timeout = 1e5)

    # directory
    setwd(path)

    # rename
    id_filter <- id
    # metric_filter <- metric
    # metric_group_filter <- metric_group
    # metric_type_filter <- metric_type
    # lulc_class_filter <- lulc_class
    # edge_depth_filter <- edge_depth
    # gap_crossing_filter <- gap_crossing
    # scale_filter <- scale
    # resolution_filter <- resolution

    # filter
    atlantic_spatial_download_filter <- atlantic_spatial %>%
        dplyr::filter(id %in% id_filter)

    # atlantic_spatial_download_filter <- atlantic_spatial %>%
    #     dplyr::filter(id %in% id_filter |
    #                   metric %in% metric_filter |
    #                   metric_group %in% metric_group_filter |
    #                   metric_type %in% metric_type_filter |
    #                   lulc_class %in% lulc_class_filter |
    #                   edge_depth %in% edge_depth_filter |
    #                   gap_crossing %in% gap_crossing_filter |
    #                   scale %in% scale_filter |
    #                   resolution %in% resolution_filter)

    # file id drive
    file_id_drive_tif <- dplyr::pull(atlantic_spatial_download_filter, file_id_drive_tif)
    file_id_drive_tfw <- dplyr::pull(atlantic_spatial_download_filter, file_id_drive_tfw)
    file_id_drive <- c(file_id_drive_tif, file_id_drive_tfw)

    # download
    googledrive::drive_deauth()
    file_id <- googledrive::as_id(file_id_drive)
    file <- googledrive::drive_get(file_id)

    # download
    for(i in 1:nrow(file)){

        googledrive::drive_download(file[i, ]$id, overwrite = TRUE)

    }

}
