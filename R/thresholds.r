#TODO: add roxygen comments
#TODO: be aware of the 80char limit

#' Calculate the two thresholds needed to create the extended confusion matrix
#'
#' Should be called using the full dataset containing both training and
#' evaluation locations.
#'
#' @param observations An integer or logical vector containing the binary
#'   observations where presences are encoded as \code{1}s/\code{TRUE}s and
#'   absences as \code{0}s/\code{FALSE}s.
#' @param predictions A numeric vector containing the predicted probabilities of
#'   occurrence. \code{length(predictions)} should be equal to
#'   \code{length(observations)} and the order of the elements should match.
#' @return A named numeric vector of length 2. First element
#'   ('\code{threshold1}') is the mean of probabilities predicted to the absence
#'   locations distinguishing certain absences from uncertain predictions.
#'   Second element ('\code{threshold2}') is the mean of probabilities predicted
#'   to the presence locations distinguishing certain absences from uncertain
#'   predictions
#' @examples
#' set.seed(12345)
#' thresholds(observations = c(rep(x = TRUE, times = 50), rep(x = FALSE, times = 50)), predictions = c(runif(n = 50, min = 0.3, max = 1), runif(n = 50, min = 0, max = 0.7)))
#' thresholds(observations = c(rep(x = 0L, times = 300), rep(x = 1L, times = 100)), predictions = c(runif(n = 300, min = 0, max = 0.6), runif(n = 100, min = 0.4, max = 1)))
#' \dontrun{
#' thresholds(observations = c(rep(x = 0, times = 300), rep(x = 1, times = 100)), predictions = c(runif(n = 300, min = 0, max = 0.6), runif(n = 100, min = 0.4, max = 1))) # throw a warning
#' thresholds(observations = c(FALSE, FALSE, TRUE, TRUE), predictions = c(0.2, 0.4, 0.7, 1.1)) # throw a warning
#' }
#' @seealso \code{\link{confidence}} for calculating confidences,
#'   \code{\link{consistence}} for calculating consistences
thresholds <- function(observations, predictions) {
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
	if (any(predictions[is.finite(predictions)] < 0) | any(predictions[is.finite(predictions)] > 1)) warning("Strange predicted values found. Parameter 'predictions' preferably contain numbers of the [0,1] interval.")
	if (length(observations) != length(predictions)) stop("The length of the two parameters should be the same.")
	threshold1 <- mean(x = predictions[observations == 0], na.rm = TRUE)
	threshold2 <- mean(x = predictions[observations == 1], na.rm = TRUE)
	return(c(threshold1 = threshold1, threshold2 = threshold2))
}
