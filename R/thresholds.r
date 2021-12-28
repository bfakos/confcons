#' Thresholds needed to create the extended confusion matrix
#'
#' Calculate the two thresholds distinguishing certain negatives/positives from
#' uncertain predictions. The thresholds are needed to create the extended
#' confusion matrix and are further used for confidence calculation.
#'
#' @param observations Either an integer or logical vector containing the binary
#'   observations where presences are encoded as \code{1}s/\code{TRUE}s and
#'   absences as \code{0}s/\code{FALSE}s.
#' @param predictions A numeric vector containing the predicted probabilities of
#'   occurrence typically within the \code{[0, 1]} interval.
#'   \code{length(predictions)} should be equal to \code{length(observations)}
#'   and the order of the elements should match.
#' @return A named numeric vector of length 2. The first element
#'   ('\code{threshold1}') is the mean of probabilities predicted to the absence
#'   locations distinguishing certain negatives (certain absences) from
#'   uncertain predictions. The second element ('\code{threshold2}') is the mean
#'   of probabilities predicted to the presence locations distinguishing certain
#'   positives (certain presences) from uncertain predictions. For a typical
#'   model better than the random guess, the first element is smaller than the
#'   second one. The returned value might contain \code{NaN}(s) if the number of
#'   observed presences and/or absences is 0.
#' @examples
#' set.seed(12345)
#'
#' # Using logical observations:
#' observations_1000_logical <- c(rep(x = FALSE, times = 500),
#'                                rep(x = TRUE, times = 500))
#' predictions_1000 <- c(runif(n = 500, min = 0, max = 0.7),
#'                       runif(n = 500, min = 0.3, max = 1))
#' thresholds(observations = observations_1000_logical,
#'            predictions = predictions_1000) # 0.370 0.650
#'
#' # Using integer observations:
#' observations_4000_integer <- c(rep(x = 0L, times = 3000),
#'                                rep(x = 1L, times = 1000))
#' predictions_4000 <- c(runif(n = 3000, min = 0, max = 0.8),
#'                       runif(n = 1000, min = 0.2, max = 0.9))
#' thresholds(observations = observations_4000_integer,
#'            predictions = predictions_4000) # 0.399 0.545
#'
#' # Wrong parameterization:
#' \dontrun{
#' thresholds(observations = observations_1000_logical,
#'            predictions = predictions_4000) # error
#' set.seed(12345)
#' observations_4000_numeric <- c(rep(x = 0, times = 3000),
#'                                rep(x = 1, times = 1000))
#' predictions_4000_strange <- c(runif(n = 3000, min = -0.3, max = 0.4),
#'                               runif(n = 1000, min = 0.6, max = 1.5))
#' thresholds(observations = observations_4000_numeric,
#'            predictions = predictions_4000_strange) # multiple warnings
#' mask_of_normal_predictions <- predictions_4000_strange >= 0 & predictions_4000_strange <= 1
#' thresholds(observations = as.integer(observations_4000_numeric)[mask_of_normal_predictions],
#'            predictions = predictions_4000_strange[mask_of_normal_predictions]) # OK
#' }
#' @note \code{thresholds()} should be called using the whole dataset containing
#'   both training and evaluation locations.
#' @seealso \code{\link{confidence}} for calculating confidence,
#'   \code{\link{consistence}} for calculating consistence
#' @export
thresholds <- function(observations, predictions) {

	# Checking parameters
	if (missing(observations) | missing(predictions)) stop("Both parameter 'observations' and 'predictions' should be set.")
	if (is.logical(observations)) observations <- as.integer(observations)
	if (!is.integer(observations)) {
		warning("I found that parameter 'observations' is not an integer or logical vector. Coercion is done.")
		observations <- as.integer(observations)
	}
	if (!all(observations[is.finite(observations)] %in% 0:1)) stop("Parameter 'observations' should contain 0s (absences) and 1s (presences).")
	if (!is.numeric(predictions)) {
		warning("I found that parameter 'predictions' is not a numeric vector. Coercion is done.")
		predictions <- as.numeric(predictions)
	}
	if (any(predictions[is.finite(predictions)] < 0) | any(predictions[is.finite(predictions)] > 1)) warning("Strange predicted values found. Parameter 'predictions' preferably contains numbers falling within the [0,1] interval.")
	if (length(observations) != length(predictions)) stop("The length of the two parameters should be the same.")

	# Calculation
	threshold1 <- mean(x = predictions[observations == 0], na.rm = TRUE)
	threshold2 <- mean(x = predictions[observations == 1], na.rm = TRUE)
	return(c(threshold1 = threshold1, threshold2 = threshold2))

}
