
#' xSecondOf
#'
#' Return the second element in a collection.
#'
#' @section Type Signature:
#'     |any| -> any
#'
#' @param
#'    coll a collection. The collection to get the
#'    second element of.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    The second element in \bold{coll}.
#'
#' @section Corner Cases:
#'    Throws an error if \bold{coll} has less than two
#'    elements; this is because any other corner case
#'    would violate the functions type-signature.
#'
#' @family selection_functions
#'
#' @template
#'    Variadic
#'
#' @example
#'    inst/examples/example-xSecondOf.R
#'
#' @rdname xSecondOf
#' @export

xSecondOf <- MakeFun('xSecondOf', function (coll) {

	MACRO( Must_Be_Longer_Than(1, coll) )

	coll[[2]]
})

#' @rdname xSecondOf
#' @export

xSecondOf_ <- MakeVariadic(xSecondOf, 'coll')
