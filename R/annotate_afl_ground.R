#' Annotate AFL Oval
#'
#' Description to be added
#'
#'
#' @param dim
#' @param colour
#' @param fill
#' @param size
#' @param ...
#'
#' @return list of ggplot geoms to be added to a ggplot plot
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' # Create the MCG
#' g <- ggplot() +
#'      annotate_afl_oval(dim = ground_mcg, fill = "green", alpha = 0.2)
#'
#' # Add blank theme
#' g + theme_ground()
#'
#' # Create the Gabba
#' ggplot() +
#' annotate_afl_oval(dim = ground_gabba, fill = "green", alpha = 0.2) +
#' theme_ground()
#'
#' # Custom ground
#' dim <- list(length = 175, width = 130, origin_x = 0, origin_y = 0)
#'
#' ggplot() +
#' annotate_afl_oval(dim = dim, fill = "green", alpha = 0.2) +
#' theme_ground()
#'
#'
annotate_afl_oval <- function(dim, colour = "dimgray", fill = NA, size = 1, ...) {

  # need to add some validation
  #
  marking_layers <- unlist(list(
    annotate_afl_base(dim, colour = colour, fill = fill, size = size, ...),
    annotate_afl_goal_square(dim, colour = colour, fill = NA, size = size, ...),
    annotate_afl_centre_square(dim, colour = colour, fill = NA, size = size, ...),
    #annotate_afl_arcs(dim, colour = colour, fill = fill, size = size, ...), # can't get this working yet
    annotate_afl_centre_circle(dim, colour = colour, fill = NA, size = size, ...)
  ), recursive = FALSE)

}


#' Annotate AFL Base
#'
#' Internal function to create AFL base gorund with boundaries
#'
#' @param dim
#' @param colour
#' @param fill
#' @param size
#' @param ...
#'
#' @noRd
annotate_afl_base <- function(dim, colour = "dimgray", fill = NA, size = 1, ...) {

  # outer boundary
  ggforce::geom_ellipse(aes(
    x0 = dim$origin_x + (dim$width / 2),
    y0 = dim$origin_y + (dim$length / 2),
    a = dim$width / 2,
    b = dim$length / 2,
    angle = 0
  ),
  fill = fill,
  colour = colour,
  size = size,
  ...
  )
}


#' Annotate AFL Centre Square
#'
#' Internal function to create AFL Centre Square
#'
#' @param dim
#' @param colour
#' @param fill
#' @param size
#' @param ...
#'
#' @noRd
annotate_afl_centre_square <- function(dim, colour = "dimgray", fill = NA, size = 1, ...) {
  square_width <- 50
  square_length <- 50

  ggplot2::annotate(
    geom = "rect",
    xmin = dim$origin_x + (dim$width / 2) - (square_width / 2),
    xmax = dim$origin_x + (dim$width / 2) + (square_width / 2),
    ymin = dim$origin_y + (dim$length / 2) - (square_length / 2),
    ymax = dim$origin_y + (dim$length / 2) + (square_length / 2),
    colour = colour,
    fill = fill,
    size = size,
    ...
  )
}

#' Annotate AFL Centre Circle
#'
#' Internal function to create AFL Centre Circle
#'
#' @param dim
#' @param colour
#' @param fill
#' @param size
#' @param ...
#'
#' @noRd
annotate_afl_centre_circle <- function(dim, colour = "dimgray", fill = NA, size = 1, ...) {
  outer_radius <- 10 / 2
  inner_radius <- 3 / 2

  list(
    ggplot2::annotation_custom(
      grob = grid::circleGrob(gp = grid::gpar(col = colour, fill = fill, size = size, ...)),
      xmin = dim$origin_x + (dim$width / 2) - inner_radius,
      xmax = dim$origin_x + (dim$width / 2) + inner_radius,
      ymin = dim$origin_y + (dim$length / 2) - inner_radius,
      ymax = dim$origin_y + (dim$length / 2) + inner_radius
    ),
    ggplot2::annotation_custom(
      grob = grid::circleGrob(gp = grid::gpar(col = colour, fill = fill, size = size, ...)),
      xmin = dim$origin_x + (dim$width / 2) - outer_radius,
      xmax = dim$origin_x + (dim$width / 2) + outer_radius,
      ymin = dim$origin_y + (dim$length / 2) - outer_radius,
      ymax = dim$origin_y + (dim$length / 2) + outer_radius
    )
  )
}


#' Annotate AFL Goal Square
#'
#' Internal function to create AFL Goal Square
#'
#' @param dim
#' @param colour
#' @param fill
#' @param size
#' @param ...
#'
#' @noRd
annotate_afl_goal_square <- function(dim, colour = "dimgray", fill = NA, size = 1, ...) {
  gs_width <- 6.4
  gs_length <- 9
  list(
    ggplot2::annotate(
      geom = "rect",
      xmin = dim$origin_x + (dim$width / 2) - (gs_width / 2),
      xmax = dim$origin_x + (dim$width / 2) + (gs_width / 2),
      ymin = dim$origin_y,
      ymax = dim$origin_y + gs_length,
      colour = colour,
      fill = fill,
      size = size,
      ...
    ),
    ggplot2::annotate(
      geom = "rect",
      xmin = dim$origin_x + (dim$width / 2) - (gs_width / 2),
      xmax = dim$origin_x + (dim$width / 2) + (gs_width / 2),
      ymin = dim$origin_y + dim$length - gs_length,
      ymax = dim$origin_y + dim$length,
      colour = colour,
      fill = fill,
      size = size,
      ...
    )
  )
}

#' Annotate AFL Arcs
#'
#' Internal function to create AFL Arcs
#'
#' @param dim
#' @param colour
#' @param fill
#' @param size
#' @param ...
#'
#' @noRd
annotate_afl_arcs <- function(dim, colour = "dimgray", fill = NA, size = 1, ...) {
  # Not working yet
  size_df <- tibble(x = dim$width, y = dim$length)
  z <- (((size_df$x + size_df$y) / 4.01)^2 - 2500 + (size_df$x / 2)^2) / (2 * (size_df$x / 2))
  h <- ((size_df$x + size_df$y) / 4)
  a <- sqrt(h^2 - z^2)
  angle <- acos(a / 50)

  ggforce::geom_arc(aes(
    x0 = dim$origin_x + (dim$width / 2),
    y0 = dim$origin_y,
    r = 50,
    start = angle,
    end = -angle
  ),
  fill = fill,
  colour = colour,
  size = size,
  ...
  )
}
