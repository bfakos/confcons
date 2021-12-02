#' Consistence of the predictive distribution model
#'
#' Calculates consistence of the model as the difference of the confidence
#' calculated on the evaluation and the confidence calculated on the training
#' subset. Consistence serves as a proxy for model's transferability.
#'
#' @param conf_train \strong{Conf}idence calculated on the \strong{train}ing
#'   subset: a numeric vector of length one, containing a number within the
#'   \code{[0, 1]} interval. Typically calculated by function
#'   \code{\link{confidence}()} using the training subset.
#' @param conf_eval \strong{Conf}idence calculated on the \strong{eval}uation
#'   subset: a numeric vector of length one, containing a number within the
#'   \code{[0, 1]} interval. Typically calculated by function
#'   \code{\link{confidence}()} using the evaluation subset.
#' @return A numeric vector of length one. It is either NA_real_ or a number
#'   within the \code{[-1, 1]} interval. Typically, it falls within the
#'   \code{[-1, 0]} interval. Greater value indicates more
#'   consistent/transferable model. I.e, the closer the returned value is to -1,
#'   the less consistence/transferable the model is. Value above 0 might be an
#'   artifact or might indicate that the training and evaluation subsets were
#'   accidentally swapped.
#' @examples
#' # Simple examples:
#' consistence(conf_train = 0.93, conf_eval = 0.21) # -0.72 - hardly consistent/transferable model
#' consistence(conf_train = 0.43, conf_eval = 0.35) # -0.08 - consistent/transferable model, although not so confident
#' consistence(conf_train = 0.87, conf_eval = 0.71) # -0.16 - a consistent/transferable model that is confident as well
#' consistence(conf_train = 0.67, conf_eval = 0.78) # 0.11 - positive value might be an artifact
#' consistence(conf_train = 0.67, conf_eval = NA_real_) # NA
#'
#' # Real-life case:
#' set.seed(12345)
#' observations <- c(rep(x = FALSE, times = 500), rep(x = TRUE, times = 500))
#' predictions <- c(runif(n = 500, min = 0, max = 0.7), runif(n = 500, min = 0.3, max = 1))
#' dataset <- data.frame(
#' 	observations = observations,
#' 	predictions = predictions,
#' 	for_evaluation = c(rep(x = FALSE, times = 250), rep(x = TRUE, times = 250), rep(x = FALSE, times = 250), rep(x = TRUE, times = 250))
#' )
#' thresholds_whole <- thresholds(observations = dataset$observations, predictions = dataset$predictions)
#' confidence_training <- confidence(observations = dataset$observations[!dataset$for_evaluation], predictions = dataset$predictions[!dataset$for_evaluation], thresholds = thresholds_whole) # 0.602
#' confidence_evaluation <- confidence(observations = dataset$observations[dataset$for_evaluation], predictions = dataset$predictions[dataset$for_evaluation], thresholds = thresholds_whole) # 0.520
#' consistence(conf_train = confidence_training, conf_eval = confidence_evaluation) # -0.083 - consistent/transferable model
#'
#' # Wrong parameterization:
#' \dontrun{
#' consistence(conf_train = 1.3, conf_eval = 0.5) # warning
#' consistence(conf_train = 0.6, conf_eval = c(0.4, 0.5)) # warning
#' }
#' @seealso \code{\link{thresholds}} for calculating the two thresholds,
#'   \code{\link{confidence}} for calculating confidence
consistence <- function(conf_train, conf_eval) {
	if (missing(conf_train) | missing(conf_eval)) stop("Both parameter 'conf_train' and 'conf_eval' should be set.")
	if (!is.numeric(conf_train)) stop("Parameter 'conf_train' should be a numeric vector of length one.")
	if (length(conf_train) < 1) stop("Parameter 'conf_train' should be a numeric vector of length one.")
	if (length(conf_train) > 1) warning(paste0("Parameter 'conf_train' has more elements (", as.character(length(conf_train)), ") then expected (1). Only the first element is used."))
	if (is.na(conf_train) | conf_train[1] < 0 | conf_train[1] > 1) warning(paste0("Parameter 'conf_train' is expected to fall within the [0, 1] interval, but found to be ", format(x = round(x = conf_train, digits = 3), nsmall = 3), "."))
	if (!is.numeric(conf_eval)) stop("Parameter 'conf_eval' should be a numeric vector of length one.")
	if (length(conf_eval) < 1) stop("Parameter 'conf_eval' should be a numeric vector of length one.")
	if (length(conf_eval) > 1) warning(paste0("Parameter 'conf_eval' has more elements (", as.character(length(conf_eval)), ") then expected (1). Only the first element is used."))
	if (is.na(conf_eval) | conf_eval[1] < 0 | conf_eval[1] > 1) warning(paste0("Parameter 'conf_eval' is expected to fall within the [0, 1] interval, but found to be ", format(x = round(x = conf_eval, digits = 3), nsmall = 3), "."))
	return(conf_eval[1] - conf_train[1])
} # consistence()
