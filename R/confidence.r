#TODO: add roxygen comments
#TODO: be aware of the 80char limit

confidence <- function(observations, predictions, thresholds, type) {
	if (!type %in% c("positive", "neutral")) stop("Parameter 'type' must be 'positive' or 'neutral'.")
	occurrence_mask <- observations == 1
	TP <- sum(occurrence_mask & predictions > thresholds[2], na.rm = TRUE)
	if (type == "positive") {
		UP <- sum(occurrence_mask & predictions > thresholds[1] & predictions <= thresholds[2], na.rm = TRUE)
		return(if (TP + UP == 0) NA_real_ else TP / (TP + UP))
	} else {
		P <- sum(occurrence_mask, na.rm = TRUE)
		FN <- sum(occurrence_mask & predictions <= thresholds[1], na.rm = TRUE)
		return(if (P == 0) NA_real_ else (TP + FN) / P)
	}
} # confidence()
