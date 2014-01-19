
#' xFourthOf
#'
#' Return the fourth value in a collection.
#'
#' @param
#'    coll a collection.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    The fourth value in \code{coll}.
#'
#' @section Corner Cases:
#'    Throws an error if \code{coll} has less than four element; this is
#'    because any other corner case would violate the functions type-signature.
#'
#' @family selection_functions
#'
#' @template
#'    Variadic
#'
#' @rdname xFourthOf
#' @export

xFourthOf <- function (coll) {
	# Collection any -> any
	# return the fourth element of a collection x.

	invoking_call <- sys.call()

	assert(
		!missing(coll), invoking_call,
		exclaim$parametre_missing(coll))

	assert(
		is_collection(coll), invoking_call,
		exclaim$must_be_collection(
			coll, summate(coll)) )

	assert(
		length(coll) >= 4, invoking_call,
		exclaim$must_be_longer_than(
			coll, 3, summate(coll)) )

	coll[[4]]
}

#' @rdname xFourthOf
#' @export

xFourthOf... <- function (...) {
	xFourthOf(list(...))
}