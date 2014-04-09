
#' xUnzipKeys
#'
#' Split a named collection into a list of name: value list pairs.
#'
#' @details
#'     \bold{xUnzipKeys} is the inverse function to \bold{xZipKeys} - it
#'     takes a named collection and converts it into a list of
#'     key, value list pairs. This is primarily intended for allowing functions that
#'     cannot read collection names - like map and select - to be able to operate
#'     on both a value and its key simultaneouslty.
#'
#' @param
#'    coll a named collection. The collection to split into name, value pairs.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A named list.
#'
#' @section Corner Cases:
#'      Returns \code{list()} if \code{coll} is length-zero.
#'
#' @family reshaping_functions
#'
#' @family key_functions
#'
#' @template
#'    Variadic
#'
#' @example
#'    inst/examples/example-xUnzipKeys.R
#'
#' @rdname xUnzipKeys
#' @export

xUnzipKeys <- MakeFun(function (coll) {
	# Named collection any -> [[string, any]]
	# split a list into its names and values.

	invoking_call <- sys.call()

	MACRO( Must $ Not_Be_Missing(coll) )

	MACRO( Must $ Be_Named(coll) )
	MACRO( Must $ Be_Collection(coll) )

	if (length(coll) == 0) {
		list()
	} else {

		colnames <- names(coll)
		coll <- unname(coll)

		lapply(seq_along(coll), function (ith) {

			list(
				colnames[[ith]],
				coll[[ith]] )
		})
	}
})

#' @rdname xUnzipKeys
#' @export

xUnzipKeys... <- function (...) {
	xUnzipKeys(list(...))
}