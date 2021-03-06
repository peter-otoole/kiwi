% Generated by roxygen2 (4.0.1.99): do not edit by hand
\name{xMinBy}
\alias{xMinBy}
\alias{xMinBy_}
\title{xMinBy}
\usage{
xMinBy(fn, coll)

xMinBy_(fn, ...)
}
\arguments{
\item{fn}{a unary function. The function to measure the size of
    an element.}

\item{coll}{a non-empty collection. The collection to find the
   smallest value of.}

\item{...}{see above.}
}
\value{
An element from \bold{coll}.
}
\description{
Get the smallest value in a collection according to a measure function.
}
\section{Type Signature}{

    (any -> &lt;number>) -> |any| -> any
}

\section{Corner Cases}{

   If an empty collection is given, an error is thrown. This is because
   is impossible to return an element from a list that has none.
}
\examples{

# 1.
#
# Find the input that gives the smallest output for
# a given polynomial

x_(-10:10) $ xMinBy(x := {
	-x^5 - 4*x + 12*x
})

# x = 10 gives the smallest output for f(x) = -x^5 - 4x - 12x
}
\seealso{
Other selection_functions: \code{\link{xAtKey}},
  \code{\link{xAtKey_}}; \code{\link{xAt}},
  \code{\link{xAt_}}; \code{\link{xDropWhile}},
  \code{\link{xDropWhile_}}; \code{\link{xDrop}},
  \code{\link{xDrop_}}; \code{\link{xFirstOf}},
  \code{\link{xFirstOf_}}; \code{\link{xFourthOf}},
  \code{\link{xFourthOf_}}; \code{\link{xInitOf}},
  \code{\link{xInitOf_}}; \code{\link{xLastOf}},
  \code{\link{xLastOf_}}; \code{\link{xMaxBy}},
  \code{\link{xMaxBy_}}; \code{\link{xRestOf}},
  \code{\link{xRestOf_}}; \code{\link{xSecondOf}},
  \code{\link{xSecondOf_}}; \code{\link{xSlice}},
  \code{\link{xSlice_}}; \code{\link{xTakeWhile}},
  \code{\link{xTakeWhile_}}; \code{\link{xTake}},
  \code{\link{xTake_}}; \code{\link{xThirdOf}},
  \code{\link{xThirdOf_}}
}

