
#' xTakeWhile
#'
#' Take every element in a collection from the start
#' until a predicate returns false.
#'
#' @section Type Signature:
#'    (any -> &lt;logical>) -> |any| -> |any|
#'
#' @param
#'    pred a predicate. The function to test each element of
#'    the collection with.
#'
#' @param
#'    coll a collection. The collection to drop elements from.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A list.
#'
#' @section Corner Cases:
#'    Returns the empty list if \bold{coll} is
#'    length-zero or the first element of
#'    \bold{coll} returns false for the predicate.
#'    Na values are considered false.
#'
#' @family selection_functions
#'
#' @template
#'    Variadic
#'
#' @example
#'    inst/examples/example-xTakeWhile.R
#'
#' @rdname xTakeWhile
#' @export

xTakeWhile <- MakeFun('xTakeWhile', function (pred, coll) {

	MACRO( Must_Have_Arity(pred, 1) )

	if (length(coll) == 0) {
		keep_names(list(), coll)
	} else {

		for (ith in seq_along(coll)) {

			is_match <- MACRO( Try_Higher_Order_Function( pred( coll[[ith]] ) ) )

			MACRO( Must_Be_Flag(is_match, pred) )

			if (!isTRUE(is_match)) {
				return ( as.list(head(coll, ith - 1)) )
			}
		}

		as.list(coll)
	}
})

#' @rdname xTakeWhile
#' @export

xTakeWhile_ <- MakeVariadic(xTakeWhile, 'coll')
