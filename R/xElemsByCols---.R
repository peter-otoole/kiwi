
#' xElemsByCols
#'
#' Enumerate the elements of a matrix down columns.
#'
#' @param
#'      tab a matrix. The matrix to enumerate by elements.
#'
#' @return
#'      A kiwi object containing a list.
#'
#' @section Corner Cases:
#'      Returns the empty list if either dimension of \bold{tab} is empty.
#'
#' @family methods
#'
#' @name xElemsByCols

xElemsByCols <- MakeFun('xElemsByCols', function (tab) {

	if (prod(dim(tab) == 0)) {
		list()
	} else {
		as.list(tab)
	}
})
