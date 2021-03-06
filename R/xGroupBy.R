
#' xGroupBy
#'
#' Group elements of a collection by the output of a function applied to each element.
#
#' @section Type Signature:
#'     (any -> any) -> |any| -> [[any]]
#'
#' @details
#'     xGroupBy allows the grouping of a heterogeneous dataset into groups of elements
#'     similar in some way.
#'
#' @param
#'     fn a unary function. The function returning the value to group its input by.
#'
#' @param
#'     coll a collection. The elements to group by a property.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    A list
#'
#' @section Corner Cases:
#'    If \bold{coll} is a empty collection the empty list is returned.
#'
#' @template
#'    Variadic
#'
#' @family reshaping_functions
#'
#' @example
#'    inst/examples/example-xGroupBy.R
#'
#' @rdname xGroupBy
#' @export

xGroupBy <- MakeFun('xGroupBy', function (fn, coll) {

	MACRO( Must_Have_Arity(fn, 1) )

	if (length(coll) == 0) {
		# do not keep names.
		list()
	} else {

		groups <- list()

		for (ith in seq_along(coll)) {
			group_found <- False

			elem <- coll[[ith]]
			map  <- MACRO( Try_Higher_Order_Function( fn(elem) ) )

			for (jth in seq_along(groups)) {

				# -- does the groupee fn(elem) belong in the jth group?
				if ( identical(map, groups[[jth]][[1]] ) ) {

					# -- append the element to the group.
					groups[[jth]][[2]] <- c(groups[[jth]][[2]], list(elem))

					group_found <- True
				}
			}

			# --- the groupee didn't belong in any group. Construct a new one.
			if (!group_found) {
				groups <- c(groups, list( list(map, list(elem)) ))
			}
		}
		groups
	}
})

#' @rdname xGroupBy
#' @export

xGroupBy_ <- MakeVariadic(xGroupBy, 'coll')
