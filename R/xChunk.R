
#' xChunk
#'
#' Divide a collection into segments of fixed length.
#'
#' @section Type Signature:
#'     |numeric| -> |any| -> [[any]]
#'
#' @param
#'    num a nonnegative whole number. The desired
#'    length of each group of elements.
#'
#' @param
#'    coll a collection. The collections to divide into groups.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A list of lists.
#'
#' @section Corner Cases:
#'    The final list in the return value will have less than \bold{num}
#'    elements if \code{length(coll)} is not evenly divisible by \bold{num}.
#'    if \bold{coll} or \bold{num} is length-zero, the empty list is returned.
#'
#' @family reshaping_functions
#'
#' @template
#'    Variadic
#'
#' @example
#'    inst/examples/example-xChunk.R
#'
#' @rdname xChunk
#' @export

xChunk <- MakeFun('xChunk', function (num, coll) {

	MACRO( Must_Be_Whole(num) )
	MACRO( Must_Be_Between(num, 1, Inf))

	if (length(coll) == 0 || length(num) == 0) {
		# -- do not name outer list.
		list()
	} else if (is.infinite(num)) {
		list(as.list(coll))
	} else {

		lapply(
			seq(1, to = length(coll), by = num),
			function (lower) {
				as.list(coll[ lower:min(length(coll), lower + num - 1) ])
		})

	}
})

#' @rdname xChunk
#' @export

xChunk_ <- MakeVariadic(xChunk, 'coll')
