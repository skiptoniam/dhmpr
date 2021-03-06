% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dispersal_proportion_functions-class.R
\name{density_dependence_dispersing}
\alias{density_dependence_dispersing}
\title{Density-dependent proportions of populations dispersing}
\usage{
density_dependence_dispersing(maximum_proportions = 1)
}
\arguments{
\item{maximum_proportions}{A single value or vector of the maximum proportions (between zero
and one) of individuals in each life stage that disperse - default is 1. If maximum
proportions are specified as a single number, then all life-stages use that value, however,
a vector of maximum proportions (equal in length to the number of life-stages) can also be
specified. Maximum proportions are multiplied by the calculated proportions based on carrying
capacity so to prevent stages from dispersing, set corresponding values to zero.}
}
\value{
An object of class \code{dispersal_proportion_function}
}
\description{
The proportion of populations dispersing will be density dependent in a simulation. Proportions
of populations in each life stage dispersing is adjusted based on available carrying capacity.
If life-stages are set by the \link[steps]{population_density_dependence_functions}, these
will be used to determine how close the population is to carrying capacity. If no
life-stages are set or density dependence is set to NULL in \link[steps]{population_dynamics},
the function will consider all life-stages in the calculation.
}
\examples{

# Example of a proportion function that disperses all populations based on their approach
# to carrying capacity

\dontrun{
prop_dispersal <- density_dependence_dispersing()

kb_dispersal <- kernel_dispersal(dispersal_proportion = prop_dispersal,
                      max_distance = 2000,
                      dispersal_kernel = exponential_dispersal_kernel(distance_decay = 1000))

ls <- landscape(population = egk_pop, suitability = egk_hab, carrying_capacity = egk_k)

pd <- population_dynamics(change = growth(egk_mat), dispersal = kb_dispersal)

simulation(landscape = ls, population_dynamics = pd, habitat_dynamics = NULL, timesteps = 20)
}
}
