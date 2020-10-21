#' Annotate AFL Oval
#'
#' Description to be added
#'
#'
#' @param dim TODO
#' @param origin TODO
#' @param aspect_ratio TODO
#' @param limits TODO
#' @param colour TODO
#' @param fill TODO
#' @param size TODO
#' @param ... TODO
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
annotate_afl_oval <- function(dim,
                              origin = list(x = 0, y = 0),
                              aspect_ratio = 1,
                              limits = TRUE,
                              colour = "dimgray", fill = NA, size = 1,
                              ...) {



  marking_layers <- unlist(list(
    annotate_afl_base(dim, origin, colour = colour, fill = fill, size = size, ...),
    annotate_afl_goal_square(dim, origin, colour = colour, fill = NA, size = size, ...),
    annotate_afl_centre_square(dim, origin, colour = colour, fill = NA, size = size, ...),
    annotate_afl_arcs(dim, origin, colour = colour, fill = fill, size = size, ...),
    annotate_afl_centre_circle(dim, origin, colour = colour, fill = NA, size = size, ...)
  ), recursive = FALSE)


  if (!is.null(aspect_ratio)) {
    marking_layers <- append(marking_layers, list(ggplot2::coord_fixed(aspect_ratio)))
  }

  if (limits) {
    limit_layers <- list(
      # Leave room for full field + goals and direction_label by default
      ggplot2::xlim(origin$x - 3,
                    origin$x + dim$width + 3),
      ggplot2::ylim(origin$y - 3,
                    origin$y + dim$length + 3)
    )

    marking_layers <- append(
      marking_layers,
      limit_layers,
    )
  }


  return(marking_layers)

}


#' Annotate AFL Base
#'
#' Internal function to create AFL base gorund with boundaries
#'
#' @inheritParams annotate_afl_oval
#'
#' @noRd
annotate_afl_base <- function(dim,
                              origin = list(x = 0, y = 0),
                              colour = "dimgray", fill = NA, size = 1,
                              ...) {

  # outer boundary
  ggforce::geom_ellipse(ggplot2::aes(
    x0 = origin$x + (dim$width / 2),
    y0 = origin$y + (dim$length / 2),
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
#' @inheritParams annotate_afl_oval
#'
#' @noRd
annotate_afl_centre_square <- function(dim,
                                       origin = list(x = 0, y = 0),
                                       colour = "dimgray", fill = NA, size = 1,
                                       ...) {

  square_width <- 50
  square_length <- 50

  ggplot2::annotate(
    geom = "rect",
    xmin = origin$x + (dim$width / 2) - (square_width / 2),
    xmax = origin$x + (dim$width / 2) + (square_width / 2),
    ymin = origin$y + (dim$length / 2) - (square_length / 2),
    ymax = origin$y + (dim$length / 2) + (square_length / 2),
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
#' @inheritParams annotate_afl_oval
#'
#' @noRd
annotate_afl_centre_circle <- function(dim,
                                       origin = list(x = 0, y = 0),
                                       colour = "dimgray", fill = NA, size = 1,
                                       ...) {
  outer_radius <- 10 / 2
  inner_radius <- 3 / 2

  list(
    # inner circle
    ggforce::geom_circle(ggplot2::aes(x0 = origin$x + (dim$width / 2),
                             y0 = origin$y + (dim$length / 2),
                             r = inner_radius),
    colour = colour,
    fill = fill,
    size = size,
    ...
  ),
  # outer circle
  ggforce::geom_circle(ggplot2::aes(x0 = origin$x + (dim$width / 2),
                           y0 = origin$y + (dim$length / 2),
                           r = outer_radius),
  colour = colour,
  fill = fill,
  size = size,
  ...
  ),
  # centreline
  ggplot2::annotate(
    geom = "line",
    x = c(origin$x + (dim$width / 2) - outer_radius,origin$x + (dim$width / 2) + outer_radius),
    y = c(origin$y + (dim$length / 2), origin$y + (dim$length / 2)),
    colour = colour,
    size = size,
    ...
  )
  )
}


#' Annotate AFL Goal Square
#'
#' Internal function to create AFL Goal Square
#'
#' @inheritParams annotate_afl_oval
#'
#' @noRd
annotate_afl_goal_square <- function(dim, origin = list(x = 0, y = 0),
                                     colour = "dimgray", fill = NA, size = 1, ...) {
  gs_width <- 6.4
  gs_length <- 9
  list(
    ggplot2::annotate(
      geom = "rect",
      xmin = origin$x + (dim$width / 2) - (gs_width / 2),
      xmax = origin$x + (dim$width / 2) + (gs_width / 2),
      ymin = origin$y,
      ymax = origin$y + gs_length,
      colour = colour,
      fill = fill,
      size = size,
      ...
    ),
    ggplot2::annotate(
      geom = "rect",
      xmin = origin$x + (dim$width / 2) - (gs_width / 2),
      xmax = origin$x + (dim$width / 2) + (gs_width / 2),
      ymin = origin$y + dim$length - gs_length,
      ymax = origin$y + dim$length,
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
#' @inheritParams annotate_afl_oval
#'
#' @noRd
annotate_afl_arcs <- function(dim, origin = list(x = 0, y = 0),
                              colour = "dimgray", fill = NA, size = 1, ...) {

  # calculate angles - taken directly from https://github.com/alittlefitness/afl_visual_analysis
  arc_r <- 50
  size_df <- data.frame(x = dim$width, y = dim$length)
  z <- (((size_df$x + size_df$y) / 4.01)^2 - arc_r^2 + (size_df$y / 2)^2) / (2 * (size_df$y / 2))
  h <- ((size_df$x + size_df$y) / 4)
  a <- sqrt(h^2 - z^2)
  angle <- acos(a / arc_r)

  list(
  # bottom arc
  ggforce::geom_arc(ggplot2::aes(
    x0 = origin$x + (dim$width / 2),
    y0 = origin$y,
    r = arc_r,
    start = -((pi/2) - angle),
    end = ((pi/2) - angle)
  ),
  colour = colour,
  size = size,
  ...
  ),
  # top arc
  ggforce::geom_arc(ggplot2::aes(
    x0 = origin$x + (dim$width / 2),
    y0 = origin$y + dim$length,
    r = -arc_r,
    start = -((pi/2) - angle),
    end = ((pi/2) - angle)
  ),
  colour = colour,
  size = size,
  ...
  ))
}
