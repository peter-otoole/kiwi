
#' xAsVal
#'
#' Convert a normal R variable to a constant value.
#'
#' @details
#'     \bold{xAsVal} takes a variable that exists in the
#'     calling environment, and locks it. This prevents
#'     further modification, and if any attempt is made to
#'     modify the variable an error is thrown.
#'
#' @param
#'    sym a symbol or string. The name of the variable
#'    to be converted to a value.
#'
#' @return
#'    Null; used for side-effect.
#'
#' @section Corner Cases:
#'    \bold{xAsVal} throws an error if an attempt is made
#'    to convert a variable that doesn't exist in the
#'    parent frame.
#'
#' @family immutable_value_functions
#'
#' @example
#'    inst/examples/example-xAsVal.R
#'
#' @rdname xAsVal
#' @export

xAsVal <- MakeFun('xAsVal', function (sym) {

	MACRO( Must_Be_Existing_Ref(sym) )

	lockBinding(sym, parent.frame())
})
