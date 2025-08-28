testthat::test_that(desc = "returns expexted value for normal parameters - small example",
					code = {
						observations <- c(0L, 0L, 1L, 1L)
						predictions <- c(0, 0.5, 0.5, 1)
						testthat::expect_type(object = thresholds(observations = observations, predictions = predictions),
												type = "double")
						testthat::expect_vector(object= thresholds(observations = observations, predictions = predictions),
													ptype = numeric(length = 0))
						testthat::expect_length(object = thresholds(observations = observations, predictions = predictions),
													n = 2)
						testthat::expect_equal(object = thresholds(observations = observations, predictions = predictions),
												 expected = setNames(object = c(0.25, 0.75), nm = c("threshold1", "threshold2")))
					}
)

testthat::test_that(desc = "returns expexted value for normal parameters - long example - logical",
					code = {
						withr::local_seed(seed = 12345,
											 .rng_kind = "Mersenne-Twister",
											 .rng_normal_kind = "Inversion",
											 .rng_sample_kind = "Rejection")
						observations <- c(rep(x = FALSE, times = 500),
						                  rep(x = TRUE, times = 500))
						predictions <- c(runif(n = 500, min = 0, max = 0.7),
						                 runif(n = 500, min = 0.3, max = 1))
						testthat::expect_type(object = thresholds(observations = observations, predictions = predictions),
												type = "double")
						testthat::expect_vector(object= thresholds(observations = observations, predictions = predictions),
													ptype = numeric(length = 0))
						testthat::expect_length(object = thresholds(observations = observations, predictions = predictions),
													n = 2)
						testthat::expect_equal(object = round(x = thresholds(observations = observations, predictions = predictions), digits = 7),
												 expected = setNames(object = c(0.3703913, 0.6492754), nm = c("threshold1", "threshold2")))
					}
)

testthat::test_that(desc = "returns expexted value for normal parameters - long example - integer",
					code = {
						withr::local_seed(seed = 12345,
											 .rng_kind = "Mersenne-Twister",
											 .rng_normal_kind = "Inversion",
											 .rng_sample_kind = "Rejection")
						observations <- c(rep(x = 0L, times = 3000),
															rep(x = 1L, times = 1000))
						predictions <- c(runif(n = 3000, min = 0, max = 0.8),
														 runif(n = 1000, min = 0.2, max = 0.9))
						testthat::expect_type(object = thresholds(observations = observations, predictions = predictions),
												type = "double")
						testthat::expect_vector(object= thresholds(observations = observations, predictions = predictions),
													ptype = numeric(length = 0))
						testthat::expect_length(object = thresholds(observations = observations, predictions = predictions),
													n = 2)
						testthat::expect_equal(object = round(x = thresholds(observations = observations, predictions = predictions), digits = 7),
												 expected = setNames(object = c(0.4051179, 0.5432518), nm = c("threshold1", "threshold2")))
					}
)

testthat::test_that(desc = "returns errors/warnings if needed - parameter: observations",
					code = {
						testthat::expect_error(object = thresholds(predictions = 0:1),
												 regexp = NULL)
						testthat::expect_warning(object = thresholds(observations = c(0, 1), predictions = 0:1),
													 regexp = NULL)
						testthat::expect_silent(object = thresholds(observations = c(0L, 1L), predictions = 0:1))
						testthat::expect_error(object = thresholds(observations = c(0L, 2L), predictions = 0:1),
												 regexp = NULL)
						testthat::expect_warning(object = thresholds(observations = c("a", "b"), predictions = 0:1),
													 regexp = NULL) %>% suppressWarnings()
					}
)

testthat::test_that(desc = "returns errors/warnings if needed - parameter: predictions",
					code = {
						testthat::expect_error(object = thresholds(observations = 0:1),
												 regexp = NULL)
						testthat::expect_warning(object = thresholds(observations = c(0L, 1L), predictions = c("0", "1")),
													 regexp = NULL)
						testthat::expect_warning(object = thresholds(observations = c(0L, 1L), predictions = c(-2, 0.5)),
													 regexp = NULL)
						testthat::expect_warning(object = thresholds(observations = c(0L, 1L), predictions = c(0.5, 1.6)),
													 regexp = NULL)
					}
)

testthat::test_that(desc = "returns errors/warnings if needed - both parameters",
					code = {
						testthat::expect_error(object = thresholds(),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = c(0L, 1L), predictions = 0.5),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = 0L, predictions = c(0.5, 0.6, 0.7)),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = integer(length = 0), predictions = c(0.5, 0.6, 0.7)),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = 0L, predictions = numeric(length = 0)),
												 regexp = NULL)
					}
)

testthat::test_that(desc = "type = \"information\"",
					code = {
						withr::local_seed(seed = 12345,
															.rng_kind = "Mersenne-Twister",
															.rng_normal_kind = "Inversion",
															.rng_sample_kind = "Rejection")
						observations <- c(rep(x = 0L, times = 3000),
															rep(x = 1L, times = 1000))
						predictions <- c(runif(n = 3000, min = 0, max = 0.8),
														 runif(n = 1000, min = 0.2, max = 0.9))
						testthat::expect_type(object = thresholds(observations = observations, predictions = predictions, type = "information"),
												type = "double")
						testthat::expect_vector(object= thresholds(observations = observations, predictions = predictions, type = "information"),
													ptype = numeric(length = 0))
						testthat::expect_length(object = thresholds(observations = observations, predictions = predictions, type = "information"),
													n = 2)
						testthat::expect_type(object = thresholds(observations = observations, predictions = predictions, type = "information", range = 0.4),
												type = "double")
						testthat::expect_vector(object= thresholds(observations = observations, predictions = predictions, type = "information", range = 0.4),
													ptype = numeric(length = 0))
						testthat::expect_length(object = thresholds(observations = observations, predictions = predictions, type = "information", range = 0.4),
													n = 2)
						testthat::expect_warning(object = thresholds(observations = observations, predictions = predictions, type = "information", range = "0.3"),
												 regexp = NULL)
						testthat::expect_warning(testthat::expect_warning(testthat::expect_error(object = thresholds(observations = observations, predictions = predictions, type = "information", range = "aaa"),
																											 regexp = NULL),
																					regexp = NULL),
													 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = observations, predictions = predictions, type = "information", range = numeric(length = 0)),
												 regexp = NULL)
						testthat::expect_warning(object = thresholds(observations = observations, predictions = predictions, type = "information", range = c(0.4, 0.3)),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = observations, predictions = predictions, type = "information", range = NA_real_),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = observations, predictions = predictions, type = "information", range = 0),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = observations, predictions = predictions, type = "information", range = -0.1),
												 regexp = NULL)
						testthat::expect_error(object = thresholds(observations = observations, predictions = predictions, type = "information", range = 0.6),
												 regexp = NULL)
					}
)

testthat::test_that(desc = "returns errors/warnings if needed - complex examples",
					code = {
						withr::local_seed(seed = 12345,
															.rng_kind = "Mersenne-Twister",
															.rng_normal_kind = "Inversion",
															.rng_sample_kind = "Rejection")
						observations <- c(rep(x = FALSE, times = 500),
															rep(x = TRUE, times = 500))
						predictions <- c(runif(n = 3000, min = 0, max = 0.8),
														 runif(n = 1000, min = 0.2, max = 0.9))
						testthat::expect_error(object = thresholds(observations = observations, predictions = predictions),
							           regexp = NULL)
						observations_4000_numeric <- c(rep(x = 0, times = 3000),
																					 rep(x = 1, times = 1000))
						predictions_4000_strange <- c(runif(n = 3000, min = -0.3, max = 0.4),
																					runif(n = 1000, min = 0.6, max = 1.5))
						testthat::expect_warning(object = testthat::expect_warning(object = thresholds(observations = observations_4000_numeric, predictions = predictions_4000_strange),
																														regexp = NULL),
													 regexp = NULL)
						mask_of_normal_predictions <- predictions_4000_strange >= 0 & predictions_4000_strange <= 1
						testthat::expect_silent(object = thresholds(observations = as.integer(observations_4000_numeric)[mask_of_normal_predictions],
						                                  predictions = predictions_4000_strange[mask_of_normal_predictions]))
					}
)
