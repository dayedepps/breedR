% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulation.R
\name{simulation}
\alias{simulation}
\alias{breedR.sample.phenotype}
\alias{breedR.sample.AR}
\alias{breedR.sample.splines}
\alias{breedR.sample.BV}
\alias{breedR.sample.pedigree}
\alias{breedR.sample.ranef}
\title{Simulation of phenotypes and model components}
\usage{
breedR.sample.phenotype(fixed = NULL, random = NULL, genetic = NULL,
  spatial = NULL, residual.variance = 1, N = NULL)

breedR.sample.AR(size, rho, sigma2, N = 1)

breedR.sample.splines(coord, nkn, sigma2, N = 1)

breedR.sample.BV(ped, Sigma, N = 1)

breedR.sample.pedigree(Nobs, Nparents, check.factorial = TRUE)

breedR.sample.ranef(dim, var, Nlevels, labels = NULL, N = Nlevels,
  vname = "X")
}
\arguments{
\item{fixed}{a numeric vector of regression coefficients.}

\item{random}{a list of random effects specifications, where each element is 
itself a list with elements \code{nlevels} and \code{sigma2}.}

\item{genetic}{a list with the additive genetic effect specifications. See 
Details.}

\item{spatial}{a list with the spatial effect specifications. See Details.}

\item{residual.variance}{is a positive number giving the value of the 
residual variance.}

\item{N}{number of simulated individuals. If \code{spatial} is specified, 
\code{N} is overridden by the product of \code{spatial$grid.size}. Otherwise
it is required. If \code{genetic} is specified, \code{N} is the size of the
offspring only.}

\item{size}{numeric. A vector of length two with the number of rows and
columns in the field trial}

\item{rho}{numeric. A vector of length two with the autocorrelation 
parameters for the row and column autoregressive processes}

\item{sigma2}{numeric. The marginal variance}

\item{coord}{numeric. A two-column matrix(-like) with spatial coordinates.}

\item{nkn}{numeric. A vector of length two with the number of (inner) knots
in each dimension}

\item{ped}{a pedigree object}

\item{Sigma}{numeric. The additive genetic variance. Either a variance for a 
single additive genetic effect, or a positive-definite matrix with the
covariance structure for a set of correlated genetic effects}

\item{Nobs}{numeric. Number of individuals to sample}

\item{Nparents}{numeric. Vector of length two. Number of dams and sires to 
randomly mate.}

\item{check.factorial}{logical. If TRUE (default), it checks whether all the 
possible matings had taken place at least once. If not, it stops with an 
error.}

\item{dim}{numeric. Dimension of the effect (e.g. n. of traits)}

\item{var}{numeric matrix. (Co)variance matrix}

\item{Nlevels}{numeric. Number of individuals values to sample}

\item{labels}{character vector of labels for each level.}

\item{vname}{string. A name for the resulting variables}
}
\description{
These functions allow to draw samples from several models 
  (spatial, genetic, competition, etc.) and to combine them to produce a 
  simulated phenotype. The resulting dataset can then be fitted with breedR 
  to compare the estimations with the true underlying parameters. 
  \code{breedR.sample.phenotype} is the main function in the group, as it 
  makes use of the rest to simulate a phenotype's components.
}
\details{
The design matrix for the \code{fixed} effects (if given) is a 
  column of ones and a matrix of random uniform values in \code{(0, 1)}. 
  Therefore, the first element in \code{fixed} gives the overall intercept.
  
  \code{genetic} is a list with the following elements:
  
  \itemize{
  
  \item \code{model} a character string, either 'add_animal' or 
  'competition'. In the former, a single breeding value per individual will 
  be simulated, while in the latter \emph{direct} and \emph{competition} 
  values are simulated.
  
  \item \code{Nparents} passed to \code{breedR.sample.pedigree}.
  
  \item \code{sigma2_a} numeric. For the \code{add_animal} model, the 
  variance of the additive genetic effect. For the \code{competition} model, 
  the \eqn{2\times 2} covariance matrix of direct and competition genetic 
  effects. Passed to \code{breedR.sample.BV} as \code{Sigma}.
  
  \item \code{check.factorial} passed to \code{breedR.sample.pedigree}
  
  \item \code{pec} numeric. If present, and only under the \code{competition}
  model, it simulates a \emph{Permanent Environmental Competition} effect 
  with the given variance.
  
  \item \code{relations} character. If present and equals \code{half-sibs} it
  will generate a pedigree with unknown sires, so that relationships in the 
  offspring are either unrelated or half-sibs are possible. Otherwise, both 
  parents are known and full-sibs are also possible.
  
  }
  
  Note that only one generation is simulated.
  
  \code{spatial} is a list with the following elements:
  
  \itemize{
  
  \item \code{model} a character string, either 'AR' or 'splines'.
  
  \item \code{grid.size} a numeric vector of length two with the number of 
  rows and columns of trees. Note that the spacing between trees is equal in 
  both dimensions.
  
  \item \code{rho/n.knots} passed to \code{breedR.sample.AR} or to 
  \code{breedR.sample.splines} as \code{nkn}.
  
  \item \code{sigma2_s}  passed to \code{breedR.sample.AR} or to 
  \code{breedR.sample.splines} as \code{sigma2}.
  
  }

\code{breedR.sample.AR} simulates a two-dimensional spatial process 
  as the kronecker product of first-order autoregressive processes in each 
  dimension.

\code{breedR.sample.splines} simulates a two-dimensional spatial 
  process as the kronecker product of B-splines processes in each dimension.

\code{breedR.sample.BV} simulates a set of breeding values (BV)
  given a pedigree

\code{breedR.sample.pedigree} simulates a one-generation pedigree 
  from random mating of independent founders. Note that if 
  \code{check.factorial} is \code{FALSE}, you can have some founders removed
  from the pedigree.

\code{breedR.sample.ranef} simulates a random effect with a given
  variance.
}
\examples{

breedR.sample.phenotype(fixed   = c(mu = 10, x = 2),
                        random = list(u = list(nlevels = 3,
                                               sigma2  = 1)),
                        genetic = list(model    = 'add_animal',
                                       Nparents = c(10, 10),
                                       sigma2_a = 2,
                                       check.factorial = FALSE),
                        spatial = list(model     = 'AR',
                                       grid.size = c(5, 5),
                                       rho       = c(.2, .8),
                                       sigma2_s  = 1),
                        residual.variance = 1)
}
