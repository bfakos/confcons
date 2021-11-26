#' Confidence of the predictive distribution model
#'
#' Calculate the confidence in positive predictions within known presences (CPP,
#' \code{type = "positive"}) or confidence in predictions within known presences
#' (CP, \code{type = "neutral"}) based on the occurrence \code{observations},
#' the probability of occurrence \code{predictions} and the two
#' \code{thresholds} distinguishing certain negatives/positives from uncertain
#' predictions.
#'
#' @param observations An integer or logical vector containing the binary
#'   observations where presences are encoded as \code{1}s/\code{TRUE}s and
#'   absences as \code{0}s/\code{FALSE}s.
#' @param predictions A numeric vector containing the predicted probabilities of
#'   occurrence typically within the \code{[0, 1]} interval.
#'   \code{length(predictions)} should be equal to \code{length(observations)}
#'   and the order of the elements should match.
#' @param thresholds A numeric vector of length 2, typically calculated by
#'   \code{\link{thresholds}()}. The first element distinguishes certain
#'   negatives (certain absences) from uncertain predictions. The second element
#'   distinguishes certain positives (certain presences) from uncertain
#'   predictions. If missing, \code{confcons::thresholds(observations =
#'   observations, predictions = predictions)} is called.
#' @param type A character vector of length one containing the value "positive"
#'   (for calculating \emph{confidence in positive predictions} within known
#'   presences (CPP)) or "neutral" (for calculating \emph{confidence in
#'   predictions} within known presences (CP)). Defaults to "positive".
#' @return A numeric vector of length one. It is either NA_real_ or positive
#'   number within the \code{[0, 1]} interval.
#' @examples
#' set.seed(12345)
#' # TODO
#' \dontrun{
#' # TODO
#' }
#' @seealso \code{\link{thresholds}} for calculating the two thresholds,
#'   \code{\link{consistence}} for calculating consistence
confidence <- function(observations, predictions, thresholds = confcons::thresholds(observations = observations, predictions = predictions), type = "positive") {
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
	if (length(observations) != length(predictions)) stop("The length of parameters 'observations' and 'predictions' should be the same.")
	if (!is.numeric(thresholds)) {
		warning("I found that parameter 'thresholds' is not a numeric vector. Coercion is done.")
		thresholds <- as.numeric(thresholds)
	}
	if (length(thresholds) < 2) stop("Parameter 'thresholds' should be a vector of length two.")
	if (length(thresholds) > 2) warning(paste0("Parameter 'thresholds' has more elements (", as.character(length(thresholds)), ") then expected (2). Only the first two elements are used."))
	if (!is.character(type)) stop("Parameter 'type' should be a character vector of length one.")
	if (length(type) < 1) stop("Parameter 'type' should be a vector of length one.")
	if (length(type) > 1) warning(paste0("Parameter 'type' has more elements (", as.character(length(type)), ") then expected (1). Only the first element is used."))
	if (!type[1] %in% c("positive", "neutral")) stop("Parameter 'type' must be 'positive' or 'neutral'.")
	occurrence_mask <- observations == 1
	TP <- sum(as.integer(occurrence_mask & predictions > thresholds[2]), na.rm = TRUE)
	if (type[1] == "positive") {
		UP <- sum(as.integer(occurrence_mask & predictions > thresholds[1] & predictions <= thresholds[2]), na.rm = TRUE)
		return(if (TP + UP == 0) NA_real_ else TP / (TP + UP))
	} else {
		P <- sum(as.integer(occurrence_mask), na.rm = TRUE)
		FN <- sum(as.integer(occurrence_mask & predictions <= thresholds[1]), na.rm = TRUE)
		return(if (P == 0) NA_real_ else (TP + FN) / P)
	}
} # confidence()
