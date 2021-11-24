#TODO: update roxygen comments

#' Calculate consistence of the predictive distribution model
#'
#' # TODO
#'
#' @param conf_train # TODO
#' @param conf_eval # TODO
#' @return # TODO
#' @examples
#' set.seed(12345)
#' # TODO
#' \dontrun{
#' # TODO
#' }
#' @seealso \code{\link{thresholds}} for calculating the two thresholds,
#'   \code{\link{confidence}} for calculating confidence
consistence <- function(conf_train, conf_eval) {
	return(conf_eval - conf_train)
} # consistence()
