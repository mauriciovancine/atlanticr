#' Atlantic Spatial
#'
#' ATLANTIC SPATIAL: a data set of landscape, topographic, hydrological, and anthropogenic metrics for the Atlantic Forest
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
atlantic_spatial_download <- function(
        id = NULL,
        metric = NULL,
        metric_group = NULL,
        metric_type = NULL,
        lulc_class = NULL,
        edge_depth = NULL,
        gap_crossing = NULL,
        scale = NULL,
        resolution = NULL,
        cores = 1,
        path = "."){

    # options
    options(timeout = 1e5)

    # directory
    initial_path <- getwd()
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
    atlantic_spatial_download_filter <- dplyr::filter(atlantic_spatial, id %in% id_filter)

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

    # prepare data
    if(any(id_filter %in% 0)){

        if(unique(length(id_filter) == 1 & id_filter == 0)){

            atlantic_spatial_download_filter_download <- atlantic_spatial_download_filter %>%
                dplyr::filter(id == 0) %>%
                dplyr::select(file_name, zenodo_link_main) %>%
                dplyr::rename(url = zenodo_link_main, destfile = file_name) %>%
                dplyr::mutate(destfile = paste0(file_name, ".gpkg"))

        } else{

            atlantic_spatial_download_filter_download_limit <- atlantic_spatial_download_filter %>%
                dplyr::filter(id == 0) %>%
                dplyr::select(file_name, zenodo_link_main) %>%
                dplyr::rename(url = zenodo_link_main, destfile = file_name) %>%
                dplyr::mutate(destfile = paste0(file_name, ".gpkg"))

            atlantic_spatial_download_filter_download_metrics <- atlantic_spatial_download_filter %>%
                dplyr::filter(id != 0) %>%
                dplyr::select(file_name, zenodo_link_main, zenodo_link_auxiliary) %>%
                tidyr::pivot_longer(cols = -file_name, names_to = "destfile", values_to = "url") %>%
                dplyr::mutate(destfile = paste0(file_name, c(".tif", ".tfw"))) %>%
                dplyr::select(-file_name)

            atlantic_spatial_download_filter_download <- rbind(
                atlantic_spatial_download_filter_download_limit,
                atlantic_spatial_download_filter_download_metrics)
        }

    } else{

        atlantic_spatial_download_filter_download <- atlantic_spatial_download_filter %>%
            dplyr::select(file_name, zenodo_link_main, zenodo_link_auxiliary) %>%
            tidyr::pivot_longer(cols = -file_name, names_to = "destfile", values_to = "url") %>%
            dplyr::mutate(destfile = paste0(file_name, c(".tif", ".tfw")))

    }

    # download
    cat("Starting download... \n")

    doParallel::registerDoParallel(parallelly::availableCores(omit = 2))

    foreach::foreach(i=1:nrow(atlantic_spatial_download_filter_download)) %dopar% {

        url <- atlantic_spatial_download_filter_download[i, ]$url
        destfile <- atlantic_spatial_download_filter_download[i, ]$destfile

        # cat(paste0("Dowloading ", destfile), "\n")
        download.file(url = url, destfile = destfile, quiet = TRUE, mode = "wb")

    }

    doParallel::stopImplicitCluster()

    cat("Download completed")

    # back directory
    setwd(initial_path)

}
