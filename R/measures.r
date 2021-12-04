#' Goodness-of-fit, confidence and consistence measures
#'
#' Wrapper function for calculating the predictive distribution model's
#' \code{\link{confidence}}s, \code{\link{consistence}}s, and optionally some
#' well-known goodness-of-fit measures as well. The calculated measures are as
#' follows: \itemize{ \item confidence in predictions (CP) and confidence in
#' positive predictions (CPP) within known presences for the training and
#' evaluation subsets \item consistence of predictions (DCP) and positive
#' predictions (DCPP) \item Area Under the ROC Curve (AUC) - optional (see
#' parameter \code{goodness}) \item maximum of the True Skill Statistic (maxTSS)
#' - optional (see parameter \code{goodness})}
#'
#' If package \pkg{ROCR} is not available but parameter '\code{goodness}' is set
#' to \code{TRUE}, the value of AUC and maxTSS will be \code{NA_real_} and a
#' warning will be raised.
#'
#'
#' @param observations An integer or logical vector containing the binary
#'   observations where presences are encoded as \code{1}s/\code{TRUE}s and
#'   absences as \code{0}s/\code{FALSE}s.
#' @param predictions A numeric vector containing the predicted probabilities of
#'   occurrence typically within the \code{[0, 1]} interval.
#'   \code{length(predictions)} should be equal to \code{length(observations)}
#'   and the order of the elements should match.
#' @param evaluation_mask A logical vector (mask) of the evaluation subset. Its
#'   \code{i}th element indicates whether the  \code{i}th element of
#'   \code{observations} was used for evaluation (\code{TRUE}) or for training
#'   (\code{FALSE}). \code{length(evaluation_mask)} should be equal to
#'   \code{length(observations)} and the order of the elements should match,
#'   i.e. \code{observations[evaluation_mask]} were the evaluation subset and
#'   \code{observations[!evaluation_mask]} were the training subset.
#' @param goodness Logical vector of length one, defaults to \code{FALSE}.
#'   Indicates, whether goodness-of-fit measures (AUC and maxTSS) should be
#'   calculated. If set to \code{TRUE}, external package '\pkg{ROCR}' is needed
#'   for the calculation (see section 'Note').
#' @param df Logical vector of length one, defaults to \code{FALSE}. Indicates,
#'   whether the returned value should be a one-row \code{data.frame} that is
#'   \code{rbind()}able if \code{measures()} is called on multiple models in a
#'   \code{for} loop or a \code{lapply()}. See section 'Value' and 'Examples'
#'   for details.
#' @return A named numeric vector (if \code{df} is \code{FALSE}; the default) or
#'   a \code{data.frame} (if \code{df} is \code{TRUE}) of one row.
#'   \code{length()} of the vector or \code{ncol()} of the \code{data.frame} is
#'   6 (if \code{goodness} is \code{FALSE}; the default) or 8 (if
#'   \code{goodness} is \code{TRUE}). The name of the elements/columns are as
#'   follows: \describe{ \item{CP_train}{confidence in predictions within known
#'   presences (CP) for the training subset} \item{CP_eval}{confidence in
#'   predictions within known presences (CP) for the evaluation subset}
#'   \item{DCP}{consistence of predictions} \item{CPP_train}{confidence in
#'   positive predictions within known presences (CPP) for the training subset}
#'   \item{CPP_eval}{confidence in positive predictions within known presences
#'   (CPP) for the evaluation subset} \item{DCPP}{consistence of positive
#'   predictions} \item{AUC}{Area Under the ROC Curve (Hanley and McNeil 1982;
#'   calculated by \code{\link[ROCR]{prediction}})} \item{maxTSS}{Maximum of the
#'   True Skill Statistic (Allouche et al. 2006; calculated by
#'   \code{\link[ROCR]{prediction}})} }
#' @examples
#' set.seed(12345)
#'
#' # TODO
#'
#' # Wrong parameterization:
#' \dontrun{
#' # TODO
#' }
#' @note Since \pkg{confcons} is a light-weight, stand-alone packages, it does
#'   not import package \pkg{ROCR}, i.e. installing \pkg{confcons} does not mean
#'   installing \pkg{ROCR} automatically. If you need AUC and maxTSS (i.e.,
#'   parameter '\code{goodness}' is set to \code{TRUE}), you should install
#'   \pkg{ROCR} or install \pkg{confcons} along with its dependencies (i.e.,
#'   \code{devtools::install_github(repo = "bfakos/confcons", dependencies =
#'   TRUE)}).
#' @references \itemize{\item Allouche O, Tsoar A, Kadmon R (2006): Assessing
#'   the accuracy of species distribution models: prevalence, kappa and the true
#'   skill statistic (TSS). Journal of Applied Ecology 43(6): 1223-1232.
#'   \link[=https://dx.doi.org/10.1111/j.1365-2664.2006.01214.x]{DOI:
#'   10.1111/j.1365-2664.2006.01214.x}. \item Hanley JA, McNeil BJ (1982): The
#'   meaning and use of the area under a receiver operating characteristic (ROC)
#'   curve. Radiology 143(1): 29-36.
#'   \link[=https://dx.doi.org/10.1148/radiology.143.1.7063747]{DOI:
#'   10.1148/radiology.143.1.7063747}.}
#' @seealso \code{\link{confidence}} for calculating confidence,
#'   \code{\link{consistence}} for calculating consistence,
#'   \code{\link[ROCR]{prediction}} for calculating AUC and TSS
#' @export
measures <- function(observations, predictions, evaluation_mask, goodness = FALSE, df = FALSE) {

	# Checking parameters

	# Calculation


}
