context("Annotate AFL Ground")

skip_on_cran() # This test suite is long-running (on cran) and is skipped

test_that("annotate_afl_oval returns valid ggplot layer object", {
  g <- annotate_afl_oval(ground_mcg)

  # make sure we are returning a set of layers
  expect_true(ggplot2:::is.layer(g[[1]]))
  expect_true(ggplot2:::is.layer(g[[2]]))
  expect_true(ggplot2:::is.layer(g[[3]]))

})

test_that("providing arguments to annotate_afl_oval returns valid ggplot params", {

  # check a few of the theme elements defaults are as expected
  g <- annotate_afl_oval(ground_mcg)
  expect_identical(g[[1]]$aes_params$fill, NA)
  expect_identical(g[[1]]$aes_params$size, 1)
  expect_identical(g[[1]]$aes_params$alpha, NULL)

  # Check that other geom params work
  g2 <- annotate_afl_oval(ground_mcg, fill = "black", alpha = 0.5, size = 5)
  expect_identical(g2[[1]]$aes_params$fill, "black")
  expect_identical(g2[[1]]$aes_params$size, 5)
  expect_identical(g2[[1]]$aes_params$alpha, 0.5)

  # Apart from layer 1, no other layers should have a fill
  expect_identical(g2[[2]]$aes_params$fill, NA)
  expect_identical(g2[[3]]$aes_params$fill, NA)
  expect_identical(g2[[2]]$aes_params$size, 5)
  expect_identical(g2[[2]]$aes_params$alpha, 0.5)

})

test_that("using annotate_afl_oval with ggplot object returns a valid ggplot object", {
  p <- ggplot2::ggplot() +
    annotate_afl_oval(ground_mcg)

  # make sure we are returning a ggplot object
  expect_is(p, "ggplot")

  # make sure layers and data are as expected - should be at least 9 layers and no data
  expect_gte(length(p$layers), 9)
  expect_equal(length(p$data), 0)

  # check a few of the theme elements defaults are as expected
  g <- annotate_afl_oval(ground_mcg)
  expect_identical(p$layers[[1]]$aes_params$fill, NA)
  expect_identical(p$layers[[1]]$aes_params$size, 1)
  expect_identical(p$layers[[1]]$aes_params$alpha, NULL)

})
