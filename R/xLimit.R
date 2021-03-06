
#' xLimit
#'
#' Create a function that can call its underlying
#' function a limited number of times.
#'
#' @section Type Signature:
#'     function -> &lt;numeric> -> function
#'
#' @details
#'    \bold{xLimit} limits the number of times a function
#'    can be called. It is primarily used for functions that
#'    makes request to online services with a rate limit.
#'    \bold{xLimit} makes it easy to respect a website's
#'    rate limits without adding a lot of boilerplate to your
#'    code.
#'
#'    \code{require(RCurl)}
#'
#'    \code{url <- "http://randomword.setgetgo.com/get.php"}
#'
#'    \code{random_word <- xLimit(function () paste(httpGET(url)), 3)}
#'
#'    \code{xMap(function (ith) random_word(), 1:3)}
#'
#'    \code{list("mashy\r\n", "iridectomy\r\n", "cystopyelitis\r\n")}
#'
#' @param
#'    fn an arbitrary function. The function to
#'    limit the number of times it can be called.
#'
#' @param
#'    num a nonnegative whole number. The number
#'    of times to allow the function to be called.
#'
#' @return
#'    A function with the same parametres as \bold{fn}.
#'
#' @section Corner Cases:
#'    xLimit throws an error if \bold{num} is not length-one.
#'
#' @family time_functions
#'
#' @example
#'    inst/examples/example-xLimit.R
#'
#' @rdname xLimit
#' @export

xLimit <- MakeFun('xLimit', function (fn, num) {

	MACRO( Must_Be_Longer_Than(0, num) )

	MACRO( Must_Be_Whole(num) )
	MACRO( Must_Be_Between(num, 0, Inf))

	.count <- 0

	do.call( 'function', list(
		as.pairlist(xFormalsOf(fn)),
		bquote({
			"a function created by xLimit."
			""
			if (.count < num) {
				.count <<- .count + 1
				.( call_with_params('fn', fn) )
			} else {
				Null
			}
	}) ))
})
