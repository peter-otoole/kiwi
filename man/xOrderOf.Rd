% Generated by roxygen2 (4.0.1.99): do not edit by hand
\name{xOrderOf}
\alias{xOrderOf}
\alias{xOrderOf_}
\title{xOrderOf}
\usage{
xOrderOf(nums)

xOrderOf_(...)
}
\arguments{
\item{nums}{a vector of numbers. The numbers to rank
   in order of size.}

\item{...}{see above.}
}
\value{
A vector of numbers.
}
\description{
Return a permutation of indices that reorders a collection of numbers.
}
\details{
\bold{xOrderOf} returns the indices for a collection that are required to
   re-order it. For example,

   \code{c(3, 1, 2)[ xOrderOf(c(3,1,2)) ]}

   re-arranges the collection as

   \code{c(1, 2, 3)}

   This is a trivial use of \bold{xOrderOf}; a more common use is to
   re-order a collection of collections by the indices of one row or column.
}
\section{Type Signature}{

    |numeric| -> &lt;integer>
}

\section{Corner Cases}{

   If nums is empty then \bold{integer(0)} is returned. Nums cannot contain
   na or nan values, as then are unorderable.
}
\examples{

NULL
}

