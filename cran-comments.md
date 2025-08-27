## Resubmission

This is a resubmission of the package after it was archived on CRAN.

### Changes
- Improper handling of packages in Suggests is fixed.
- Now all suggested packages are used conditionally in the vignette and the tests, as required by 'Writing R Extensions'.
- In the meanwhile, package 'blockCV' (which suggested package originally caused the issue in my vignette) was also updated.

## R CMD check results

0 errors \| 0 warnings \| 1 note

