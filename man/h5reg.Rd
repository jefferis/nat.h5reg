% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/h5reg.R
\name{h5reg}
\alias{h5reg}
\title{Wrapper object for one or more HDF5 encoded transforms}
\usage{
h5reg(..., swap = NULL)
}
\arguments{
\item{...}{Path to one or more HDF5 encoded registrations.}

\item{swap}{When \code{TRUE} implies that the registration specifies the
direction required for transforming points. When \code{FALSE} implies the
inverse. The default implied by \code{swap=NULL} is \code{swap=TRUE} for
all registrations.}
}
\value{
A character vector with additional class \code{h5reg}.
}
\description{
Wrapping paths to one or more h5 registration files on disk in
  an \code{antsreg} object means that they can be used by
  \code{nat::\link{xform}} and inside \code{nat::\link{reglist}} objects.
}
\details{
h5 registrations contains both forward and inverse deformation
  fields along with the corresponding affine transforms wrapped in a single
  HDF5 file. They are therefore naively invertible just by picking out the
  correct registration field.

  For historical reasons (based on the convention of CMTK), when
  \code{swap=FALSE}, we assume we are trying to specify a registration in the
  direction required for image transformation. This is the opposite of the
  direction required for point transformation, which is the convention for h5
  registration files. We therefore set \code{swap=TRUE} when it is not
  specified.

  If multiple registrations are specified, they are given in order from
  floating to template brain, reading from left to right. See
  \code{nat::\link{xform}} and \code{nat::\link{reglist}} for further
  details.
}
\examples{
\dontrun{
# We will use sample Kenyon Cells in FCWB (FlyCircuit) space
library(nat)
head(kcs20)

# swap=FALSE, so this will map points onto JRC2018F
kcs20.jrc2018 = xform(kcs20,
                      reg = h5reg('JRC2018F_FCWB_transform_quant16.h5', swap=FALSE)
)

# map back again (round trip test)
kcs20.rt = xform(
  kcs20.jrc2018,
  reg = h5reg('JRC2018F_FCWB_transform_quant16.h5')
)

plot3d(kcs20.jrc2018, col='green')

clear3d()
plot3d(kcs20, col='red')
plot3d(kcs20.rt, col='blue')

diffs=xyzmatrix(kcs20)-xyzmatrix(kcs20.rt)
str(diffs)
plot(as.data.frame(diffs))
}
}
\seealso{
\code{\link{h5reg-utils}}

Other h5reg: 
\code{\link{xformpoints.h5reg}()}
}
\concept{h5reg}
