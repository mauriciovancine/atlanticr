#' Atlantic Spatial
#'
#' ATLANTIC SPATIAL: a data set of landscape, topographic, hydrological, and anthropogenic metrics for the Atlantic Forest.
#' The table provides a description and characterization of each of the metric layers and links to access and download them.
#'
#' @format A tibble with 502 rows and 19 variables:
#' \describe{
#'   \item{id}{Id of the metric, a number from 0 to 502.}
#'   \item{metric}{Name of the metric.}
#'   \item{metric_group}{Name of the metric group to which the metric pertains: "landscape", "topographic", "hydrological", or "anthropogenic".}
#'   \item{metric_type}{Type of metric. For instance, "lulc" (land use and land cover), patch_id (id of the patch), core_area.}
#'   \item{metric_description}{Full description of the metric.}
#'   \item{value}{Range of values of the metric.}
#'   \item{value_description}{Description of the values, to ease their interpretation.}
#'   \item{unit}{Unit of the layer.}
#'   \item{lulc_class}{Classes of land use and land cover (lulc) used to produce the map.}
#'   \item{edge_depth_m}{Edge depth, in meters. Only relevant for some types of metrics, e.g. patch, landscape morphology, edge and core metrics.}
#'   \item{gap_crossing_m}{Gap crossing capability, in meters. Only relevant for some types of metrics, e.g. functional connectivity metrics.}
#'   \item{scale_buffer_radius_m}{Radius of the buffer considered for multi-scale metrics. Only relevant for some type of metrics, e.g. metrics of proportion.}
#'   \item{resolution}{Resolution of the raster layers.}
#'   \item{file_name}{Name of the Geotiff and TFW files.}
#'   \item{file_size_gb}{Size of the Geotiff file, in GB.}
#'   \item{zenodo_repository}{Zenodo repository where the metrics is stored.}
#'   \item{zenodo_link_main}{Link to the main file (Geotiff) to be downloaded for the corresponding metric.}
#'   \item{zenodo_link_auxiliary}{Link to the ancillary file (TFW) to be downloaded for the corresponding metric.}
#'   \item{zenodo_doi}{Link to the Digital Object Identifier (DOI) of the Zenodo repository.}
#'   }
#' @source {Vancine et al. ATLANTIC SPATIAL: a data set of landscape, topographic, hydrological, and anthropogenic metrics for the Atlantic Forest. Ecology.}
#' \doi{in review}
"atlantic_spatial"
