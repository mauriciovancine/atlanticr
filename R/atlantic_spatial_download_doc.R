#' Download layers from the Atlantic Spatial dataset
#'
#' This functions provides a wrapper to download the metrics from the ATLANTIC SPATIAL dataset
#' for the Atlantic Forest from the corresponding Zenodo repositories where they are stored.
#' A description of the metrics can be found in the [[atlanticr::atlantic_spatial]] table.
#'
#' @param id `[integer]` \cr Integer or vector of integers with the IDs of the metric
#' layers to be downloaded. Metric IDs and description can be found in the
#' [[atlanticr::atlantic_spatial]] table.
#' @param path `[character]` \cr Path of the folder where the downloaded files should
#' be saved. Default is the current directory, `"."`.
#'
#' @param metric \cr Not yet implemented.
#' @param metric_group \cr Not yet implemented.
#' @param metric_type \cr Not yet implemented.
#' @param lulc_class \cr Not yet implemented.
#' @param edge_depth \cr Not yet implemented.
#' @param gap_crossing \cr Not yet implemented.
#' @param scale \cr Not yet implemented.
#' @param resolution \cr Not yet implemented.
#' @param cores \cr Not yet implemented.
#'
#' @example examples/atlantic_spatial_download_example.R
#' @references {Vancine et al. ATLANTIC SPATIAL: a data set of landscape, topographic, hydrological, and anthropogenic metrics for the Atlantic Forest. Ecology.}
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

    # rename
    id_filter <- id

    # filter
    atlantic_spatial_download_filter <- dplyr::filter(atlantic_spatial, id %in% id_filter)

    # prepare data
    if(any(id_filter %in% 0)){

        if(unique(length(id_filter) == 1 & id_filter == 0)){

            atlantic_spatial_download_filter_download <- atlantic_spatial_download_filter %>%
                dplyr::filter(id == 0) %>%
                dplyr::select(file_name, zenodo_link_main) %>%
                dplyr::rename(url = zenodo_link_main, destfile = file_name) %>%
                dplyr::mutate(destfile = paste0(destfile, ".gpkg"))

        } else{

            atlantic_spatial_download_filter_download_limit <- atlantic_spatial_download_filter %>%
                dplyr::filter(id == 0) %>%
                dplyr::select(file_name, zenodo_link_main) %>%
                dplyr::rename(url = zenodo_link_main, destfile = file_name) %>%
                dplyr::mutate(destfile = paste0(destfile, ".gpkg"))

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

    for(i in 1:nrow(atlantic_spatial_download_filter_download)){

        url <- atlantic_spatial_download_filter_download[i, ]$url
        destfile <- atlantic_spatial_download_filter_download[i, ]$destfile

        tryCatch({
            download.file(url = url, destfile = paste0(path, "/", destfile), quiet = FALSE, mode = "wb")
            cat(paste0("Successfully downloaded ", destfile, "\n"))
        }, error = function(e) {
            cat(paste0("Error downloading ", destfile, ": ", e$message, "\n"))
        })

    }

    # done
    cat("Download completed\n")

}
