needed_packages <- c("testthat", "vctrs", "mockery", "ROCR", "confcons")

missing_packages <- needed_packages[!vapply(X = needed_packages,
																						FUN = requireNamespace,
																						quietly = TRUE,
																						FUN.VALUE = logical(1))]

if (length(missing_packages) == 0) {
	test_check("confcons")
}
