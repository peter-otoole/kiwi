% Generated by roxygen2 (4.0.1.99): do not edit by hand
\name{xCompose}
\alias{\%then\%}
\alias{xCompose}
\alias{xCompose_}
\title{xCompose}
\usage{
xCompose(fns)

xCompose_(...)

fn1 \%then\% fn2
}
\arguments{
\item{fns}{a collection of functions. The functions to
   compose with each other.}

\item{...}{see above.}

\item{fn1}{a function.}

\item{fn2}{a function.}
}
\value{
A variadic function.
}
\description{
Take several functions and return a composite function.
}
\details{
Kiwi's function composition is largely done with the infix
   operators \%of\% and \%then\%.

   \bold{\%then\%} is the classic function composition operator;

   \code{(as.numeric \%then\% sqrt \%then\% print)('10')}

   Like methods, the order of function execution is from left to right;
   convert a string to a number then take the square root then print the value.
   The reversed form \%of\% is equally as common.

   The classic example of function composition (apart from
   Church numerals) is composing linear functions.

   \code{f <- x := 2*x}

   \code{g <- x := 4*x}

   \code{h <- x := 1*x}

   \code{(f \%of\% g \%of\% h)(1)}

   \code{(x := 2*(4*(1*x)) )(1)}

   xCompose

   In this case the output of one function is piped to
   another:

   \code{1 => 1*1 => 1*4 => 4*2 => 8}

   In this case function composition behaves exactly like
   multiplication.

   In more typical use of \bold{xCompose} is to reduce the
   number of anonymous functions needed by some programs.

   \code{xMap(sqrt \%of\% sqrt, 1:10)}
}
\section{Type Signature}{

    |function| -> (..any -> any)
}

\section{Corner Cases}{

   \bold{xCompose} throws an error if no functions are passed to it, as it has
   no sensible definition in this case.
}
\examples{

# 1. Composing linear functions
#    composing linear function 'multiplies' them,
#    so composing x := 2x and x := 3x returns the
#    'product' function x := 6x

f <- x := 2*x
g <- x := 3*x

# h = x := 3(2*x)
# h = x := 6*x

h <- f \%then\% g

h(2)
# 12

}
\seealso{
Other function_combining_functions: \code{\link{\%and\%}},
  \code{\link{\%or\%}}, \code{\link{xLift}},
  \code{\link{xLift_}}; \code{\link{xJuxtapose}},
  \code{\link{xJuxtapose_}}

Other function_modifying_functions: \code{\link{\%and\%}},
  \code{\link{\%or\%}}, \code{\link{xLift}},
  \code{\link{xLift_}}; \code{\link{xCapture}},
  \code{\link{xK}}; \code{\link{xDelay}};
  \code{\link{xFix}}, \code{\link{xFix_}};
  \code{\link{xJuxtapose}}, \code{\link{xJuxtapose_}};
  \code{\link{xNegate}}; \code{\link{xSpread}};
  \code{\link{xThread}}, \code{\link{xThread_}};
  \code{\link{xUnspread}}
}

