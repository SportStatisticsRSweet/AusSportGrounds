#' Ground dimensions
#'
#' @description The dimensions of the ground to build with the `annotate_` set of functions.
#'
#' We provide some common ground dimensions but custom dimensions can be used.
#'
#' @details A "ground dimensions" is simply a list of dimensions that define a
#' coordinate system. The required dimensions are:
#'
#' \itemize{
#'  \item{"length"}{The length of the longest part of the ground (x axis)}
#'  \item{"width"}{The width of the ground from side to the other (y axis)}
#'  \item{"origin_x"}{The minimum x coordinate of the ground}
#'  \item{"origin_y"}{The minimum y coordinate of the ground}
#' }
#'
#' The following ground dimensions are provided
#' \itemize{
#'  \item{"ground_mcg"}{For the MCG}
#' }
#'
#' @export
ground_mcg <- list(
  length = 160,
  width = 141,
  origin_x = 0,
  origin_y = 0
)

#' @rdname ground_mcg
#' @export
# Source: https://www.foxsports.com.au/afl/geelongs-gmhba-stadium-playing-surface-to-shrink-as-boundaries-brought-in-for-player-safety/news-story/03d334db55d584cd66e545a4bd7beff4
ground_gabba <- list(
  length = 156,
  width = 138,
  origin_x = 0,
  origin_y = 0
)

