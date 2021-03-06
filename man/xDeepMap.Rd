% Generated by roxygen2 (4.0.1.99): do not edit by hand
\name{xDeepMap}
\alias{xDeepMap}
\alias{xDeepMap_}
\title{xDeepMap}
\usage{
xDeepMap(fn, coll)

xDeepMap_(fn, ...)
}
\arguments{
\item{fn}{a unary function. A function to recursively apply
   into a collection.}

\item{coll}{a collection. The collection to be mapped into.}

\item{...}{see above.}
}
\value{
A list or pairlist.
}
\description{
Recursively map a function into a nested collection,
preserving its structure.
}
\section{Type Signature}{

    (any -> any) -> |any| -> [any]
}

\section{Corner Cases}{

   xDeepMap preseves collection names.
}
\examples{

# 1. Recursively convert the elements of a list to strings.
#
#

tree <- list(
	1,
	list(
		2, 3
	),
	list(
		4, 5, 6, list(
			7
		)
	),
	8
)

xDeepMap(paste, tree)

# list(
#     '1',
#     list(
#         '2', '3'
#     ),
#     list(
#         '4', '5', '6', list(
#             '7'
#         )
#     ),
# '8'
# )
}
\seealso{
Other function_application_functions: \code{\link{xApply}},
  \code{\link{xApply_}}; \code{\link{xFlatMap}},
  \code{\link{xFlatMap_}}; \code{\link{xMap}},
  \code{\link{xMap_}}; \code{\link{xSpread}};
  \code{\link{xThread}}, \code{\link{xThread_}};
  \code{\link{xUnspread}}
}

