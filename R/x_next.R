

kiwi_env <- environment()





# is_variadic :: <string> -> <string>
#
# Check if a variable is of the form xMethod_ | x_Method_

is_variadic <- function (fn_name) {
	grepl('_$', fn_name)
}

# is_unchaining :: <string> -> <string>
#
# Check if a variable is of the form x_Method | x_Method_

is_unchaining <- function (fn_name) {
	grepl('^x_', fn_name)
}






# as_variadic :: <string> -> <string>
#
# Convert a method to the form xMethod_ | x_Method_

as_variadic <- function (fn_name) {
	if (is_variadic(fn_name)) {
		fn_name
	} else {
		paste0(fn_name, '_')
	}
}

# as_chaining :: <string> -> <string>
#
# Convert a method to the form x_Method | x_Method_

as_chaining <- function (fn_name) {
	if (!is_unchaining(fn_name)) {
		fn_name
	} else {
		gsub('^x_', 'x', fn_name)
	}
}

# as_nonvariadic :: <string> -> <string>
#
# Convert a method to the form xMethod | x_Method

as_nonvariadic <- function (fn_name) {
	if (!is_variadic(fn_name)) {
		fn_name
	} else {
		gsub('_$', '', fn_name)
	}
}

# as_unchaining :: <string> -> <string>
#
# Convert a method to the form xMethod | xMethod_

as_unchaining <- function (fn_name) {
	if (is_unchaining(fn_name)) {
		fn_name
	} else {
		gsub('^x', 'x_', fn_name)
	}
}





# lookup_fn :: <character> -> function
#
# take a method name and find its coresponding function.

lookup_fn <- function (method_name) {

	if (is_unchaining(method_name)) {
		kiwi_env[[ as_chaining(method_name) ]]
	} else {
		kiwi_env[[method_name]]
	}
}






# as_proto_params :: <character> -> <character>
#
# annotate the ... parametre of a function, if the
# function has one, so that the ... parametre is
# attached to the correct prototype.

as_proto_params <- function (method_name) {

	fn_name <- as_chaining(method_name)

	if (is_variadic(fn_name)) {

		variadic_fn     <- lookup_fn(fn_name)
		fn              <- kiwi_env[[ as_nonvariadic(fn_name) ]]

		variadic_params <- names(formals(variadic_fn))
		params          <- names(formals(fn))

		spread_param    <- params[!(params %in% variadic_params)]

		variadic_params[variadic_params == '...'] <- paste0('...', spread_param)
		variadic_params

	} else {

		fn <- kiwi_env[[fn_name]]
		names(formals(fn))

	}
}



# has_variadic_param :: <string> -> <logical>
#
# check if a set of parametres contins variadic parametres.

has_variadic_param <- function (params) {
	any(grepl('^[.]{3}', params))
}



# fixed_param :: <string> -> <string> -> <string>
#
#

fixed_param <- function (fn_name, params) {

	fn_params <- as_proto_params(fn_name)
	fn_params[ which(fn_params %in% params)[[1]] ]
}






# select all the kiwi functions with at least
# one given parametre, or a particular type of ... parametre.

fns_with_params <- function (fns, params) {

	Filter(
		function (fn_name) {
			any(as_proto_params(fn_name) %in% params)
		},
		fns
	)
}

# make_method :: <character> -> <character> -> function
#
# make method generates a method from a kiwi function.
#
# make_method solves some problems with first-generation kiwi-methods;
# each form of the method would have to explicitely added by hand, and
# methods that should be available in multiple forms werent.
#
# the new methods should allow the LHS argument to default to a particular
# parametre based on a prototye, but by calling the method with a named argument
# the method should intelligently decide which parametre to bind to the LHS.
#
#     x_(str1) $ xWrite(str2)
#
# or
#
#     x_(str2) $ xWrite(str1 = str1)
#
#
# Within a prototype there is preference for binding to some parametres above
# another (in reality a lot of these won't be found together):
#
#
#
#
#
#
#                        THE RULES
#
# 1, every method is available in the method chain.
##
# 3, if too many arguments are given, an error is thrown saying the
#    LHS couldn't be bound to any parametre.
#
# 4, if too few arguments are given, an error is thrown before
#    kiwi's partial application kicks in. This prevents ambiguities with
#    rebinding Self() after the user fixes another parametre.
#
# 5, The LHS will preferentially bind to one of the methods parameters;
#    for example collections will bind to 'coll' more preferably than
#    to the parametre 'fn'.
#
#    In this way, a call to a method without using names should never be
#    ambigious.
#
# 6, By calling a method with named arguments you can choose a parametre
#    to supply an argument to, as is normal for functions. In this case
#    the LHS is bound to it's second favourite parametre.
#
# 7, If the LHS is bound to a parametre for which it couldn't possibly
#    be correct (a collection to 'fn') an error is thrown.
#



make_method <- local({

	# create_static_body :: function x <string> x <string> -> Expression
	#
	# create_static_body creates the body for methods in which the
	# LHS only satifies one parametre; that parametre is removed from the function,
	# and in the body Self( ) is used as the argument passed to the underlying function
	# the method is calling to.
	#
	# For variadic functions which fix '...', Self() is given as ..1, and ... is kept
	# as a parametre for additional arguments.

	create_static_body <- function (fn, method_name, fixed) {

		# -- accumulate a parametres list.
		# -- done with Reduce as more work is needed for variadic formals.
		arglist <- Reduce(
			function (acc, param) {

				if (param == fixed) {
					# -- this parametre is to be fixed.

					if (fixed == '...') {
						# -- fixing an ellipsis parametre
						c( acc, quote(Self()), as.symbol('...') )
					} else {
						# -- normal fixing
						c( acc, quote(Self()) )
					}

				} else {
					# -- don't fix this parametre.
					c(acc, as.symbol(param))
				}
			},
			names(formals(fn)),
			list()
		)

		if (is_unchaining(method_name)) {

			# -- normalise the method name to a function name.
			fn_sym <- as.symbol(as_chaining(method_name))

			bquote({
				.(( as.call(c(fn_sym, arglist)) ))
			})

		} else {

			fn_sym <- as.symbol(method_name)

			# -- chaining methods call x_ on the return value of kiwi function.
			bquote({
				x_( .(( as.call(c(fn_sym, arglist)) )) )
			})
		}
	}

	# create_dynamic_body
	#
	# (Sorry for using a buzzword)
	#
	# This creates the function body that accomponies methods in which the
	# LHS matches multiple parametres, and the arguments supplied by the user
	# might alter which parametre the LHS is bound to.

	create_dynamic_body <- function (fn, method_name, fixed) {

		# -- this can only be one argument short of
		# -- supplying arguments to its underlying function.

		if (is_unchaining(method_name)) {

			# -- normalise the method name to a function name.
			fn_sym <- as.symbol(as_chaining(method_name))

			bquote({

				argnames <- names(as.list(match.call(expand.dots = True))[-1])
				args     <- lapply(argnames, function (param) {
					eval(as.symbol(param))
				})
				names(args) <- argnames

				# -- ensure every argument is supplied (including LHS).
				if (length(args) != length(.( names(formals(fn)) )) - 1) {

					message = "Too few arguments were supplied to the method " %+% .(paste(fn_sym)) %+%
						", as methods\ncannot currently be partially applied.\n"

					throw_kiwi_error(sys.call(), message)
				}

				# -- set the missing argument to the LHS (Self() returns the LHS)
				args[[ setdiff(.( names(formals(fn)) ), names(args)) ]] <- quote(Self())

				# -- reorder the arguments so that with their names removed they
				# -- positionally match in the same way they would by name.

				unnamed_args <- lapply( .( names(formals(fn)) ), function (param) {
					args[[param]]
				})

				# -- unname
				do.call(.(fn_sym), unnamed_args)
			})

		} else {

			fn_sym <- as.symbol(method_name)

			# -- chaining methods call x_ on the return value of kiwi function.

			bquote({

				argnames <- names(as.list(match.call(expand.dots = True))[-1])
				args     <- lapply(argnames, function (param) {
				eval(as.symbol(param))
				})
				names(args) <- argnames

				# -- ensure every argument is supplied (including LHS).
				if (length(args) != length(.( names(formals(fn)) )) - 1) {

					message = "Too few arguments were supplied to the method " %+% .(paste(fn_sym)) %+%
						", as methods\ncannot currently be partially applied.\n"

					throw_kiwi_error(sys.call(), message)
				}

				# -- set the missing argument to the LHS (Self() returns the LHS)
				args[[ setdiff(.( names(formals(fn)) ), names(args)) ]] <- quote(Self())

				# -- reorder the arguments so that with their names removed they
				# -- positionally match in the same way they would by name.

				unnamed_args <-	 lapply( .( names(formals(fn)) ), function (param) {
					args[[param]]
				})

				# -- unname
				x_(do.call(.(fn_sym), unnamed_args))
			})
		}
	}

	function (fn_name, params) {

		fn                 <- lookup_fn(fn_name)
		fn_sym             <- as.symbol(fn_name)
		fn_params          <- names(formals(fn))

		# -- expand variadic parametre (...) to its replacement ...coll, ...fns.
		fn_proto_params    <- as_proto_params(fn_name)

		# -- which parametres (including the typed variadic parametre) are in this prototype?
		which_proto_params <- which(fn_proto_params %in%  params)
		# -- which aren't?
		which_other_params <- which(fn_proto_params %!in% params)

		method <- function () {}

		formals(method) <- formals(fn)

		if (length(fn_params) == 1 && fn_params == '...') {
			# -- the function just has a single variadic parametre.

			formals(method) <- formals(fn)
			body(method)    <- create_static_body(fn, fn_name, '...')

		} else if (length(which_proto_params) == 1) {
			# -- the LHS only satifies one parametre; only
			# -- one param is in the prototype.
			# -- so that parametre cannot be set by the user.
			# -- remove the parametre from the method's formals.

			# -- is the sole parametre being fixed as self() variadic?
			param_is_variadic <- has_variadic_param(fn_proto_params[which_proto_params])
			formals(method)   <- if (param_is_variadic) {
				# -- variadic parametres can take multiple arguments;
				# -- set the LHS to ...1, and keep ... around to take more args.
				formals(fn)
			} else {
				formals(fn)[which_other_params]
			}

			body(method) <- create_static_body(fn, fn_name, fn_params[which_proto_params])

		} else {
			# -- the LHS satisfies multiple parametres, so
			# -- the user may possibly choose which parametre
			# -- it gets bound to.
			#
			# -- in this case, a parametre cannot be removed from
			# -- the method, and the parametre that the LHS
			# -- gets bound to is determined at runtime by seeing what
			# -- parametres are free after the user supplied (possibly named)
			# -- input.

			formals(method) <- formals(fn)
			body(method)    <- create_dynamic_body(fn, fn_name)

		}

		environment(method) <- new.env(parent = environment(fn))

		method
	}

})





# make_proto :: <character> -> <character> -> Environment function
#
# make_proto takes kiwi's function names, and a list of parametres
# that flag the function for inclusion in the prototype.

make_proto <- function (fns, params, description) {

	self      <- Object()

	proto_fns <- c(
			fns_with_params(fns, params),
			lapply(
				fns_with_params(fns, params), as_unchaining) )

	for (proto_fn in proto_fns) {
		self[[proto_fn]] <- make_method(proto_fn, params)
	}

	self $ private <- list(contents_are = description)
	self
}




# proto_params
#
# A list with an element for each prototype. The parametres are unordered here;
# if a function has multiple parametres that belong in one prototype a relation
# determines their preceedence within make_method.

proto_params <- list(
	table      = c('tab'),
	factor     = c('fact'),

	any        = c('val', 'val1', 'val2'),
	`function` = c('fn', 'pred', '...fns', '...preds', 'val', 'val1', 'val2'),
	coll       = c(
		'ims',   '...ims',
		'ints',  '...ints',
		'raws',  '...raws',
		'str1',
		'str2',
		'bools', '...bools',
		'rexp',
		'nums',  '...nums',
		'strs',  '...strs',
		'str',
		'num',
		'coll1',  '...coll1',
		'coll2',  '...coll2',
		'fns',
		'preds',
		'coll',  '...coll',
		'colls', '...colls',
		'val', 'val1', 'val2'
	)
)






kiwi_fns         <- ls(kiwi_env, pattern = 'x[A-Z]')

x_any_proto      <- make_proto(kiwi_fns, proto_params $ any,        'arbitrary values')
x_table_proto    <- make_proto(kiwi_fns, proto_params $ table,      'data-frames or matrices')
x_factor_proto   <- make_proto(kiwi_fns, proto_params $ factor,     'factors')
x_function_proto <- make_proto(kiwi_fns, proto_params $ `function`, 'functions')
x_coll_proto     <- make_proto(kiwi_fns, proto_params $ coll,       'collections')






# -------------------------------- Type Constructor -------------------------------- #

#' x_
#'
#' Generate an kiwi object with methods available to it.
#'
#' @param
#'    val an arbitrary value. The value to wrap in an
#'    kiwi object.
#'    The methods available depend on the input
#'    type; functions and collections have the most methods available.
#'
#' @param
#'    ... see above.
#'
#' @return
#'    An object of class "kiwi". Internally the object is represented as a
#'    list with a single field \bold{x}, but this field cannot be accessed directly.
#'    Instead, the method \bold{$ x_( )} or \bold{$ x_Identity( )} can be used to
#'    return the data stored in an kiwi object.
#'
#'    The methods available to an kiwi object depend on the type of the data it
#'    contains. All kiwi objects inherit a handful of methods regardless of their
#'    type; these include \bold{xIdentity} and \bold{xTap} - a method that allows
#'    anonymous function to be executed on an kiwi object.
#'
#'    The two primary groups of methods are collection methods and function methods.
#'
#'    Matrices, data frames, and factors have methods for converting them to collections,
#'    while normal Kiwi functions are also available as methods for collections
#'    and functions.
#'
#' @section Corner Cases:
#'    The methods that can be used by \bold{$ x_( )} object varies depending
#'    on the type of val.
#'
#' @family methods
#'
#' @example
#'    inst/examples/example-x_.R
#'
#' @rdname x_
#' @export

x_ <- MakeFun('x_', function (val) {
	# Collection any -> Kiwi any
	# type constructor for the method-chaining data type.



	# -- a useful corner case; there are no methods
	# -- specifically for kiwi objects with kiwi
	# -- objects in them. Makes defining methods easier.
	if (any(class(val) == 'kiwi')) {
		val
	} else {
		# -- cannot just be a val with a class label,
		# -- as if val is null then x_ will fail.
		structure(list(x = val), class = 'kiwi')
	}
})

#' @rdname x_
#' @export

x__ <- function (...) {
	x_(list(...))
}





# NOTE: Cannot make more specific;
#
# making coll more specific screws up the predictability of length-zero corner cases,
# requires extremely expensive type-checking to be fully generic.

get_proto_ref <- local({

	x_table_members    <- ls(x_table_proto)
	x_factor_members   <- ls(x_factor_proto)
	x_function_members <- ls(x_function_proto)
	x_coll_members     <- ls(x_coll_proto)
	x_any_members      <- ls(x_any_proto)

	function (val) {
		# get the reference to the appropriate methods.

		# -- keep this code fairly efficient.

		if (is.function( val )) {
			list(x_function_proto, x_function_members)
		} else if (is.matrix( val ) || is.data.frame( val )) {
			list(x_table_proto, x_table_members)
		} else if (is.factor( val )){
			list(x_factor_proto, x_factor_members)
		} else if (is_atomic( val ) || is_generic( val )) {
			list(x_coll_proto, x_coll_members)
		} else {
			list(x_any_proto, x_any_members)
		}
	}

})










# suggest_similar_method :: <character> ->
#
# suggest_similar_method takes a mispelled method name, and
# returns the name of the most similar method.
# It uses a combination of nearest-string
# search, and manual hacks.
#

suggest_similar_method <- local({

	# close_method :: <character> -> <character> -> <character>
	#
	# Get the string distance to other candidate methods, and return
	# sufficiently close methods.

	close_method <- function (method_name, candidates) {

		dists <- adist(method_name, candidates)

		meets_threshold <-
			min(dists) < ceiling(nchar(method_name) / log(nchar(method_name)) )

		if (meets_threshold) {
			candidates[which.min(dists)]
		} else {
			character(0)
		}
	}

	# change_of_suffix :: <character> -> <character> -> <character>
	#
	# Transforms the suffix of a method and checks if it equals
	# after changing the suffix.
	#
	# xMethod -> xMethodOf | xMethodOf -> xMethod

	change_of_suffix <- function (method_name, candidates) {

		with_suffix    <- gsub('_$', 'Of_', method_name)
		without_suffix <- gsub('Of_$',  '', method_name)

		if (any(candidates == with_suffix)) {
			with_suffix
		} else if (any(candidates == without_suffix)) {
			without_suffix
		}
	}

	# change_to_prefix :: <character> -> <character> -> <character>
	#
	# Chage the prefix
	#
	# xAsMethod -> xToMethod | xToMethod -> xAsMethod

	change_to_prefix <- function (method_name, candidates) {

		with_prefix    <- gsub('As', 'To', method_name)
		without_prefix <- gsub('To', 'As', method_name)

		if (any(candidates == with_prefix)) {
			with_prefix
		} else if (any(candidates == without_prefix)) {
			without_prefix
		}
	}

	# change_to_keys :: <character> -> <character> -> <character>
	#
	# Change occurrences of the substring 'Names' to 'Keys', as
	# kiwi only uses Keys.

	change_to_keys <- function (method_name, candidates) {

		swapped <- gsub('Names', 'Keys', method_name)

		if (any(candidates == swapped)) {
			swapped
		}
	}

	# change_common_name :: <character> -> <character> -> <character>
	#
	# Change_common_name checks if a method has a name commonly used in another language.

	change_common_name <- function (method_name, candidates) {

		alias <- function (from, to) {

			out <- list()

			for (incorrect in from) {
				out <- list(out,
					list(as_chaining(method_name),    as_chaining(to)),
					list(as_unchaining(method_name),  as_unchaining(to)),
					list(as_variadic(method_name),    as_variadic(to)),
					list(as_nonvariadic(method_name), as_nonvariadic(to))
				)
			}

			out
		}

		match <- Filter(
			function (pair) {
				pair[[1]] == method_name
			},
			c(
				alias(c('xFilterNot', 'xRemove'), 'xReject'))
		)

		match[[2]]
	}





	function (val, method_name, content_type, invoking_call) {

		# -- get the edit distance to each
		# -- to each method in the prototype.
		proto <- get_proto_ref(val)

		candidates <- setdiff(proto[[2]], 'private')

		# -- try to find a similar method.
		matches    <- list(
			close =
				close_method(method_name, candidates),
			change_of_suffix =
				change_of_suffix(method_name, candidates),
			change_to_prefix =
				change_to_prefix(method_name, candidates),
			change_common_name =
				change_common_name(method_name, candidates)
		)

		similar <- matches[[ which(nchar(matches) > 0)[1] ]]

		# -- build up the message.

		message <- if (length(similar) == 0) {
			"Could not find the method " %+% dQuote(method_name) %+%
			" in the methods available for " %+% content_type %+% "."
		} else {
			"Could not find the method " %+% dQuote(method_name) %+%
			" in the methods available for " %+% content_type %+%
			":\n" %+%
			colourise $ green(
				"did you mean " %+% rsample(similar, size = 1) %+% "?")
		}

		throw_kiwi_error(invoking_call, message)
	}
})






#' @export

`$.kiwi` <- local({

	# some methods are known by their more common
	# but worse names (like filter, filterNot).
	# Meet the user half way and suggest the "proper" name.

	function (obj, method) {
		# Kiwi a -> symbol -> function
		# return an kiwi method associated with the type a.

		method_name <- paste0(substitute(method))
		proto       <- get_proto_ref( obj[['x']] )

		if ( !any(proto[[2]] == method_name) || method_name == "private" ) {
			# -- the invoked method wasn't found, so we should give a suggestion.

			invoking_call <- paste0(' $ ', method_name)

			contents_are <- proto[[1]][['private']][['contents_are']]

			suggest_similar_method(
				obj[['x']], method_name, contents_are, invoking_call)

		}

		fn <- proto[[1]][[method_name]]
		environment(fn)[['Self']] <- function () {
			obj[['x']]
		}

		fn
	}
})

# -------------------------------- Print Method -------------------------------- #

#' @export

print.kiwi <- function (x, ...) {

	proto        <- get_proto_ref( x[['x']] )
	contents_are <- proto[[1]][['private']] [['contents_are']]

	header <- colourise $ blue(
		'\n[ an kiwi object with methods for ' %+% contents_are %+% ' ]')

	cat(
		header  %+% '\n\n' %+%
		'$x_()' %+% '\n')

	print(x $ x_Identity(), ...)
}
