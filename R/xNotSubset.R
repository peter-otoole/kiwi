
#' xNotSubset
#'
#' Test if a collection is not a subset of a second collection.
#'
#' @section Type Signature:
#'     |any| -> |any| -> &lt;logical>
#'
#' @param
#'    coll1 a collection. The set to test for non-membership in a superset.
#'
#' @param
#'    coll2 a collection. The superset to test.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A boolean value.
#'
#' @section Corner Cases:
#'    Returns logical(0) if \bold{coll1} or \bold{coll2} is length-zero.
#'
#' @template
#'    Variadic
#'
#' @example
#'    inst/examples/example-xNotSubset.R
#'
#' @family set_functions
#'
#' @rdname xNotSubset
#' @export

xNotSubset <- MakeFun('xNotSubset', function (coll1, coll2) {

	if (length(coll1) == 0 || length(coll2) == 0) {
		logical(0)
	} else {

		for (elem in coll1) {
			if (elem %is_in% coll2) {
				return(False)
			}
		}
		True
	}
})

#' @rdname xNotSubset
#' @export

xNotSubset_ <- MakeVariadic(xNotSubset, 'coll2')
