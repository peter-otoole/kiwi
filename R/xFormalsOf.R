
#' xFormalsOf
#'
#' @section Type Signature:
#'     function -> |any|
#'
#' Get a named list of parametres and their defaults from a function or primitive function.
#'
#' @param
#'    fn an arbitrary function. The function to get the parametres of.
#'
#' @return
#'    A named list, where each element's name is a parametre in \bold{fn} and each value
#'	  is the default value of that parametre.
#'
#' @section Corner Cases:
#'    If \bold{fn} is a primitive function a heuristic is used to obtain
#'    its formals. If a parametre has no default, the value of the
#'    corresponding element in the return value will be the empty symbol,
#'    which is identical to \code{quote(expr=)}.
#'
#' @family parametre_functions
#'
#' @example
#'    inst/examples/example-xFormalsOf.R
#'
#' @rdname xFormalsOf
#' @export

xFormalsOf <- MakeFun('xFormalsOf', function (fn) {

	if (is.primitive(fn)) {
		as.list( head(as.list(args(fn)), -1) )
	} else {
		as.list( formals(fn) )
	}
})
