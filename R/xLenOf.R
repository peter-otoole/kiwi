
#' xLenOf
#'
#' Get the length of a collection.
#'
#' @section Type Signature:
#'     |any| -> &lt;number>
#'
#' @param
#'    coll a collection. The collection to test the
#'    length of.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A nonnegative integer.
#'
#' @section Corner Cases:
#'      Returns zero if \bold{coll} is empty.
#'
#' @template
#'    Variadic
#'
#' @example
#'    inst/examples/example-xLenOf.R
#'
#' @rdname xLenOf
#' @export

xLenOf <- MakeFun('xLenOf', function (coll) {
	length(coll)
})

#' @rdname xLenOf
#' @export

xLenOf_ <- MakeVariadic(xLenOf, 'coll')
