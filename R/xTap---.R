
#' xTap
#'
#' Apply an anonymous function to the contents of an kiwi object.
#'
#' @section Type Signature:
#'     (any -> any) -> any -> any
#'
#' @param
#'    fn a unary function. The function to apply to the data in the kiwi object.
#'
#' @param
#'    val an arbitrary value. The contents of the kiwi object.
#'
#' @details
#'    \bold{xTap} applies non-kiwi functions to be applied to kiwi objects.
#'    These functions can be named or unnamed. This allows base functions
#'    or external libraries to inter-operate with kiwi's chaining methods.
#'
#'    \code{x_(letters) $ xShuffle() $ x_Tap(sort)}
#'
#'    \bold{xTap} also allows the use of anonymous methods.
#'
#'    \code{x_(1:10) $ x_Tap(nums := all(nums > 0))}
#'
#' @return
#'      A kiwi object.
#'
#' @section Corner Cases:
#'     None.
#'
#' @family methods
#'
#' @name xTap

xTap <- MakeFun('xTap', function (fn, val) {

	MACRO( Must_Have_Arity(fn, 1) )

	MACRO( Try_Higher_Order_Function( fn(val) ) )
})
