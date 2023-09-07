library(tidyverse)
library(sf)
library(tmap)
library(hexSticker)

# data
af <- terra::vect(x = "hexagon/af.gpkg")
af_sim <- sf::st_simplify(sf::st_as_sf(af), dTolerance = 3e4) %>%
    sf::st_crop(xmin = -57.5, ymin = -32, xmax = -33, ymax = -5)

set.seed(42)
af_p <- sf::st_sample(af_sim, 100)

map <- tm_shape(af_sim)+
    tm_fill(col = "#90b13a") +
    tm_shape(af_p) +
    tm_dots(col = "black", size = 1, alpha = .5) +
    tm_layout(frame = FALSE, bg.color = "transparent")
map

tmap::tmap_save(tm = map, filename = "hexagon/img.png", width = 20, height = 20, units = "cm", dpi = 300, bg = NA)

# sticker -----------------------------------------------------------------

# sticker
img <- magick::image_read('hexagon/img.png')

hexSticker::sticker(
    subplot = img,
    s_x = 1.05,
    s_y = .9,
    s_width = 1.5,
    s_height = 1.5,
    package = "atlanticr",
    p_x = 1,
    p_y = 1.6,
    p_color = "black",
    p_size = 25,
    h_fill = "#feffec",
    h_color = "#90b13a",
    url = "mauriciovancine.github.io/atlanticr",
    u_x = 1,
    u_y = .09,
    u_size = 6,
    u_color = "gray50",
    filename = "hexagon/logo.png",
    dpi = 400)

hexSticker::sticker(
    subplot = img,
    s_x = 1.05,
    s_y = .9,
    s_width = 1.5,
    s_height = 1.5,
    package = "atlanticr",
    p_x = 1,
    p_y = 1.6,
    p_color = "black",
    p_size = 25,
    h_fill = "#feffec",
    h_color = "#90b13a",
    url = "mauriciovancine.github.io/atlanticr",
    u_x = 1,
    u_y = .09,
    u_size = 6,
    u_color = "gray50",
    filename = "man/figures/logo.png",
    dpi = 400)

pkgdown::build_favicons(overwrite = TRUE)

# end ---------------------------------------------------------------------
