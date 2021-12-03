test_that("returns expexted value for normal parameters", {
	expect_equal(thresholds(observations = c(0L, 0L, 1L, 1L), predictions = c(0, 0.5, 0.5, 1)), setNames(object = c(0.25, 0.75), nm = c("threshold1", "threshold2")))
})
