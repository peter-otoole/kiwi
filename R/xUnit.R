
#' xUnit
#'
#' Return the empty version of a collection.
#'
#' @section Type Signature:
#'     |any| -> ||
#'
#' @param
#'    coll an list, pairlist, or vector of any length.
#'    The collection to return the length-zero
#'    unit element of.
#'
#' @param ... see above
#'
#' @return
#'    Returns null if \bold{coll} is a pairlist, a
#'    typed vector of length zero if \bold{coll}
#'	  is a vector, and the empty list if \bold{coll} is a list.
#'
#' @section Corner Cases:
#'      The unit of a pairlist is null.
#'
#' @example
#'    inst/examples/example-xUnit.R
#'
#' @rdname xUnit
#' @export

xUnit <- MakeFun('xUnit', function (coll) {

	if (is.pairlist(coll)) {
		Null
	} else {
		unname(coll[0])
	}
})

#' @rdname xUnit
#' @export

xUnit_ <- MakeVariadic(xUnit, 'coll')
