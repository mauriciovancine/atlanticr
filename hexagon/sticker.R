# install.packages("hexSticker")

library(hexSticker)
library(png)

imgurl <- magick::image_read('content/project/atlantic-amphibians/hexagon/img2.png')

sticker(imgurl,
        package = "atlanticr",
        p_size = 13,
        p_color = "white",
        s_x = .9, s_y = .75, s_width = 1.5, s_height = 1.5,
        h_fill = "white",
        h_color = "white",
        filename = "pkgdown/favicon/featured-hex.png")

