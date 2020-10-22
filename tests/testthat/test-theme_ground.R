context("Theme Ground")

skip_on_cran() # This test suite is long-running (on cran) and is skipped

test_that("theme_ground returns valid ggplot theme object", {
  t <- theme_ground()

  # make sure we are returning a theme
  expect_true(ggplot2:::is.theme(t))

  # check a few of the theme elements are as expected
  expect_identical(t$axis.title, ggplot2::element_blank())

})

test_that("using theme_ground with ggplot object updates it's theme", {
  p <- ggplot2::ggplot() +
    theme_ground()

  # make sure we are returning a ggplot object
  expect_is(p, "ggplot")

  # make sure ggplot theme elements are as expected
  expect_identical(p$theme$panel.background, ggplot2::element_blank())

})
