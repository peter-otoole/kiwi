
#' xAsVar
#'
#' Convert a constant value back into a normal R value.
#'
#' @details
#'     \bold{xAsVar} takes a variable in the calling
#'     environment, and unlocks it, converting it back
#'     to a normal R variable.
#'
#' @param
#'     sym a symbol or string. The name of the variable
#'     to be converted to a variable.
#'
#' @return
#'     Null; used for side-effect.
#'
#' @section Corner Cases:
#'     Throws an error if attempting to convert a
#'     variable that doesn't exist (in the parent frame).
#'     Non-locked variables are also allowed.
#'
#' @family immutable_value_functions
#'
#' @example
#'     inst/examples/example-xAsVar.R
#'
#' @rdname xAsVar
#' @export

xAsVar <- MakeFun('xAsVar', function (sym) {

	MACRO( Must_Be_Existing_Ref(sym) )

	unlockBinding(sym, parent.frame())
})
