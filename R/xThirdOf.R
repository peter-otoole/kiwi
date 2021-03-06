
#' xThirdOf
#'
#' Return the third value in a collection.
#'
#' @section Type Signature:
#'     |any| -> any
#'
#' @param
#'    coll a collection. The collection to get the
#'    third element of.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    The third element in \bold{coll}.
#'
#' @section Corner Cases:
#'    Throws an error if \bold{coll} has less than
#'    three elements; this is because any other corner
#'    case would violate the function's type-signature.
#'
#' @template
#'    Variadic
#'
#' @family selection_functions
#'
#' @example
#'    inst/examples/example-xThirdOf.R
#'
#' @rdname xThirdOf
#' @export

xThirdOf <- MakeFun('xThirdOf', function (coll) {

	MACRO( Must_Be_Longer_Than(2, coll) )

	coll[[3]]
})

#' @rdname xThirdOf
#' @export

xThirdOf_ <- MakeVariadic(xThirdOf, 'coll')
