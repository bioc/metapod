#' Combine grouped p-values with Fisher's method
#'
#' Combine p-values from grouped tests with Fisher's method.
#' Groups are defined according to unique levels of a grouping factor.
#'
#' @inheritParams groupedSimes
#'
#' @return A list containing:
#' \itemize{
#' \item \code{p.value}, a named numeric vector of length equal to the number of unique levels in \code{grouping}.
#' This contains the Fisher combined p-value for each group, log-transformed if \code{log.p=TRUE}.
#' Each entry is named according to the group.
#' \item \code{representative}, a named integer scalar specifying the representative test for each group.
#' Each entry is named according to the group.
#' \item \code{influential}, a logical vector of length equal to \code{p.values}.
#' Entries are \code{TRUE} for any p-value that is deemed \dQuote{influential} to the final combined p-value for its group.
#' }
#'
#' @inherit parallelFisher details
#' @inherit parallelFisher references
#' 
#' @author Aaron Lun
#' @examples
#' p1 <- rbeta(100, 0.8, 1)
#' g <- sample(10, length(p1), replace=TRUE)
#'
#' # Standard application:
#' out <- groupedFisher(p1, g)
#' str(out)
#'
#' # With weights:
#' out <- groupedFisher(p1, g, weights=rexp(length(p1)))
#' str(out)
#' 
#' # With log p-values. 
#' out <- groupedFisher(p1, g, log.p=TRUE)
#' str(out)
#'
#' @seealso
#' \code{\link{parallelFisher}}, for a version that operates on parallel vectors of p-values.
#'
#' @export
groupedFisher <- function(p.values, grouping, log.p=FALSE) {
    .grouped_compute(p.values, grouping, NULL, log.p, FUN=compute_grouped_fisher)
}