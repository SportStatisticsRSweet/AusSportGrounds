#' Removes background and axes details from a ggplot plot.
#'
#' Functionally very similar to `ggplot2::theme_void` and
#' adapted directly from `ggsoccer::theme_pitch`.
#'
#' @param aspect_ratio Aspect ratio (`y / x`) for the plot.
#'   Use `NULL` to let the plot take any aspect ratio.
#'
#' @return list of ggplot themes to be added to a ggplot plot
#'
#' @examples
#' library(ggplot2)
#'
#' data <- data.frame(x = c(90, 85, 82, 78, 83),
#'                          y = c(43, 40, 52, 56, 44))
#'
#' p <- ggplot(data, aes(x = x, y = y)) +
#'   geom_point()
#'
#' # Ground fixed to square by default
#' p + theme_ground(1)
#'
#' # Free aspect
#' p + theme_ground(aspect_ratio = NULL)
#'
#' @export
theme_ground <- function(aspect_ratio = 1) {

  ggplot2::theme(
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    axis.title = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    axis.text = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    aspect.ratio = aspect_ratio)

}
