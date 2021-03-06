% Generated by roxygen2 (4.0.1.99): do not edit by hand
\name{xNotIn}
\alias{xNotIn}
\alias{xNotIn_}
\title{xNotIn}
\usage{
xNotIn(val, coll)

xNotIn_(val, ...)
}
\arguments{
\item{val}{an arbitrary value. The value to test for
   non-membership in a collection.}

\item{coll}{a collection. The collection to test elements from.}

\item{...}{see above.}
}
\value{
A boolean value.
}
\description{
Check if a collection doesn't contain a value.
}
\section{Type Signature}{

    any -> |any| -> &lt;logical>
}

\section{Corner Cases}{

   Various types of \code{Na} are not-distinguished between.
   Type conversion is not carried out.
}
\examples{

# 1. A toy example with the letters

xNotIn('a', LETTERS)

# False
}
\seealso{
Other set_functions: \code{\link{xDuplicatesOf}},
  \code{\link{xDuplicatesOf_}}; \code{\link{xInterOf}},
  \code{\link{xInterOf_}}; \code{\link{xIsIn}},
  \code{\link{xIsIn_}}; \code{\link{xIsSubset}},
  \code{\link{xIsSubset_}}; \code{\link{xNotSubset}},
  \code{\link{xNotSubset_}}; \code{\link{xPowerSetOf}},
  \code{\link{xPowerSetOf_}}; \code{\link{xProdSetOf}},
  \code{\link{xProdSetOf_}}; \code{\link{xUnionOf}},
  \code{\link{xUnionOf_}}; \code{\link{xUniqueOf}},
  \code{\link{xUniqueOf_}}
}

