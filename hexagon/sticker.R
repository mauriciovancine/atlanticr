library(tidyverse)
library(geodata)
library(terra)
library(hexSticker)
library(png)

# data
br <- geodata::gadm(country = "Brazil", path = "hexagon/", level = 0) %>%
    terra::crop(terra::ext(-75, -33, -35, 5))
plot(br)

br_r <- rast(br, ncols = 500, nrows = 500)

br_raster <- terra::rasterize(br, br_r)
br_raster
plot(br_raster)

terra::writeVector(br, "hexagon/br.gpkg", overwrite = TRUE)
terra::writeRaster(br_raster, "hexagon/br.tif", overwrite = TRUE)

af <- terra::vect(x = "hexagon/af.gpkg")
af_raster <- terra::rasterize(af, br_r)

set.seed(42)
af_p <- terra::spatSample(af, 100)

png(filename = "hexagon/img.png", width = 20, height = 20, units = "cm", bg = NA, res = 300)
plot(br_raster, col = "#dfdfdf", axes = FALSE, legend = FALSE)
plot(af_raster, col = "#7ce93a", axes = FALSE, legend = FALSE, add = TRUE)
plot(af_p, add = TRUE)
dev.off()

# sticker -----------------------------------------------------------------

# sticker
img <- magick::image_read('hexagon/img.png')

hexSticker::sticker(
    subplot = img,
    s_x = 1,
    s_y = .73,
    s_width = 1.4,
    s_height = 1.4,
    package = "atlanticr",
    p_x = 1,
    p_y = 1.5,
    p_color = "forestgreen",
    p_size = 25,
    h_fill = "white",
    h_color = "forestgreen",
    filename = "hexagon/logo.png",
    dpi = 400)

hexSticker::sticker(
    subplot = img,
    s_x = 1,
    s_y = .73,
    s_width = 1.4,
    s_height = 1.4,
    package = "atlanticr",
    p_x = 1,
    p_y = 1.5,
    p_color = "forestgreen",
    p_size = 25,
    h_fill = "white",
    h_color = "forestgreen",
    filename = "man/figures/logo.png",
    dpi = 400)

pkgdown::build_favicons(overwrite = TRUE)

# end ---------------------------------------------------------------------
