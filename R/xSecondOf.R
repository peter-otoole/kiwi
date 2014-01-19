
#' xSecondOf
#'
#' Return the second element in a collection.
#'
#' @param
#'    coll a collection
#'
#' @param
#'    ... see above.
#'
#' @return
#'    The second element in \code{coll}.
#'
#' @section Corner Cases:
#'    Throws an error if \code{coll} has less than two
#'    elements; this is because any other corner case
#'    would violate the functions type-signature.
#'
#' @family selection_functions
#'
#' @template
#'    Variadic
#'
#' @rdname xSecondOf
#' @export

xSecondOf <- function (coll) {
	# Collection any -> any
	# return the second element of a collection x.

	invoking_call <- sys.call()

	assert(
		!missing(coll), invoking_call,
		exclaim$parametre_missing(coll))

	assert(
		is_collection(coll), invoking_call,
		exclaim$must_be_collection(
			coll, summate(coll)) )

	assert(
		length(coll) >= 2, invoking_call,
		exclaim$must_be_longer_than(
			coll, 2, summate(coll)) )

	coll[[2]]
}

#' @rdname xSecondOf
#' @export

xSecondOf... <- function (...) {
	xSecondOf(list(...))
}