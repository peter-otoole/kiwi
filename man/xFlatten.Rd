% Generated by roxygen2 (4.0.1.99): do not edit by hand
\name{xFlatten}
\alias{xFlatten}
\alias{xFlatten_}
\title{xFlatten}
\usage{
xFlatten(num, coll)

xFlatten_(num, ...)
}
\arguments{
\item{num}{a nonnegative whole-number. The maximum depth
   of collection in the return value.}

\item{coll}{a list or pairlist.}

\item{...}{see above.}
}
\value{
A list.
}
\description{
Unnest a nested list to a given depth.
}
\details{
\bold{xFlatten} flattens nested collections to a
   specific depth. \bold{num} specifies the maximum
   allowed depth in the returned list. When flattening a
   (infinitely nested) collection, \bold{num} equals 1 returns a
   collection, \bold{num} equals 2 returns a collection of
   collections, and so on.

   \bold{xFlatten} is currently implemented recursively (except for
   complete unlisting), so it is unstable for large or deep collections.
}
\section{Type Signature}{

   |numeric| -> |any| -> |any|
}

\section{Corner Cases}{

   Returns the empty list if \bold{coll} or \bold{num} is length-zero.
   Flattening to infinite doesn't affect the depth of the output list.
   Flattening to one level flattens the list fully. Flattening removes all
  list-names.
}
\examples{

# 1. flatten a tree-like collection.

tree <- list(
	list(
		list(3)
	),
	list(
		list(4),
		list(
			list(9)
		)
	)
)

xFlatten(1, tree)

# list(3, 4, 9)
}
\seealso{
Other reshaping_functions: \code{\link{xAppend}},
  \code{\link{xAppend_}}; \code{\link{xChop}},
  \code{\link{xChop_}}; \code{\link{xChunk}},
  \code{\link{xChunk_}}; \code{\link{xGroupBy}},
  \code{\link{xGroupBy_}}; \code{\link{xJoin}},
  \code{\link{xJoin_}}; \code{\link{xOneOf}},
  \code{\link{xOneOf_}}; \code{\link{xPrepend}},
  \code{\link{xPrepend_}}; \code{\link{xRepeat}},
  \code{\link{xRepeat_}}; \code{\link{xReverse}},
  \code{\link{xReverse_}}; \code{\link{xShuffle}},
  \code{\link{xShuffle_}}; \code{\link{xSortBy}},
  \code{\link{xSortBy_}}; \code{\link{xTabulate}},
  \code{\link{xTabulate_}}; \code{\link{xUnzipIndices}},
  \code{\link{xUnzipIndices_}}; \code{\link{xUnzipKeys}},
  \code{\link{xUnzipKeys_}}; \code{\link{xZipKeys}},
  \code{\link{xZipKeys_}}; \code{\link{xZip}},
  \code{\link{xZip_}}
}

