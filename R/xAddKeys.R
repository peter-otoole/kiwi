
#' xAddKeys
#'
#' Add names to a collection.
#'
#' @section Type Signature:
#'    |character| -> |any| -> [any]
#'
#' @details
#'     \bold{xAddKeys} is similar to the in-place assignment
#'     function \bold{names<-}, except that it is not an in-place
#'     assignment function.
#'
#' @param
#'    strs a collection of strings. The names to add to the
#'    input collection.
#'
#' @param
#'    coll a collection. The collection to add names to.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A named list.
#'
#' @section Corner Cases:
#'    Returns the named empty list if \bold{coll} is length-zero. Both
#'    duplicated and length-zero names are allowed.
#'
#' @family key_functions
#'
#' @template
#'    Variadic
#'
#' @family key_functions
#'
#' @example
#'    inst/examples/example-xAddKeys.R
#'
#' @rdname xAddKeys
#' @export

xAddKeys <- MakeFun('xAddKeys', function (strs, coll) {

	MACRO( Must_Not_Contain_Na(strs) )
	MACRO( Must_Be_Equal_Length_To(strs, coll) )

	coll        <- as.list(coll)
	names(coll) <- strs
	coll
})

#' @rdname xAddKeys
#' @export

xAddKeys_ <- MakeVariadic(xAddKeys, 'coll')
