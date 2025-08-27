## Resubmission

This is a resubmission of the package after it was archived on CRAN.

### Changes
- Fixed the issue that caused archival (improper handling of packages in Suggests).
- Now all suggested packages are used conditionally, as required by 'Writing R Extensions'.
- In the meanwhile, package 'blockCV' (which suggested package originally caused the issue in my vignette) was also updated.

## R CMD check results

0 errors \| 0 warnings \| 1 note

