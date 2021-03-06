library(steps)
library(raster)
library(future)
plan(multiprocess)

#system('rm /home/casey/Research/Github/steps/src/*.so /home/casey/Research/Github/steps/src/*.o')
#.pardefault <- par()
#par(mar=c(0.5,0.5,0.5,0.5))

############ MODEL INPUTS ###############

#Note, this is an age-structured matrix and is not generic
koala.trans.mat <- matrix(c(0.000,0.000,0.302,0.302,
                            0.940,0.000,0.000,0.000,
                            0.000,0.884,0.000,0.000,
                            0.000,0.000,0.793,0.793),
                          nrow = 4, ncol = 4, byrow = TRUE)
colnames(koala.trans.mat) <- rownames(koala.trans.mat) <- c('Stage_0_1','Stage_1_2','Stage_2_3','Stage_3_')

koala.trans.mat.es <- matrix(c(0.000,0.000,1,1,
                               1,0.000,0.000,0.000,
                               0.000,1,0.000,0.000,
                               0.000,0.000,1,1),
                             nrow = 4, ncol = 4, byrow = TRUE)
colnames(koala.trans.mat.es) <- rownames(koala.trans.mat.es) <- c('Stage_0_1','Stage_1_2','Stage_2_3','Stage_3_')

koala.stable.states <- abs(eigen(koala.trans.mat)$vectors[,1]/base::sum(eigen(koala.trans.mat)$vectors[,1]) ) 

koala.hab.suit <- raster("inst/extdata/Koala_HabSuit.tif") # read in spatial habitat suitability raster
koala.hab.suit <- (koala.hab.suit - cellStats(koala.hab.suit, min)) / (cellStats(koala.hab.suit, max) - cellStats(koala.hab.suit, min))
names(koala.hab.suit) <- "Habitat"
plot(koala.hab.suit, box = FALSE, axes = FALSE)

koala.hab.k <- ceiling(koala.hab.suit*10)
names(koala.hab.k) <- "Carrying Capacity"
plot(koala.hab.k, box = FALSE, axes = FALSE)

koala.pop <- ceiling(stack(replicate(4, koala.hab.k)) * koala.stable.states)
names(koala.pop) <- colnames(koala.trans.mat)
plot(koala.pop, box = FALSE, axes = FALSE)

koala.disp.bar <- koala.hab.suit*0
koala.disp.bar[cellFromRow(koala.disp.bar,nrow(koala.disp.bar)/2)] <- 1
plot(koala.disp.bar, box = FALSE, axes = FALSE)

koala.disp.param <- list(dispersal_distance=list('Stage_0-1'=0,'Stage_1-2'=10,'Stage_2-3'=10,'Stage_3+'=0),
                          dispersal_kernel=list('Stage_0-1'=0,'Stage_1-2'=exp(-c(0:9)^1/3.36),'Stage_2-3'=exp(-c(0:9)^1/3.36),'Stage_3+'=0),
                          dispersal_proportion=list('Stage_0-1'=0,'Stage_1-2'=0.35,'Stage_2-3'=0.35*0.714,'Stage_3+'=0),
                          barrier_type=1,
                          barriers_map=koala.disp.bar,
                          use_barriers=TRUE
)

koala.dist.fire <- stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Fire*'))

koala.pop.source <- koala.pop[[4]]
koala.pop.source[] <- 0
koala.pop.source[sample(which(getValues(koala.pop[[4]]) >= 3), 25)] <- 1
plot(koala.pop.source, box = FALSE, axes = FALSE)

koala.pop.sink <- koala.pop[[4]]
koala.pop.sink[] <- 0
koala.pop.sink[sample(which(getValues(koala.pop[[1]]) == 1 |
                            getValues(koala.pop[[2]]) == 1 |
                            getValues(koala.pop[[3]]) == 1 |
                            getValues(koala.pop[[4]]) == 1),
                      cellStats(koala.pop.source, sum))] <- 1
plot(koala.pop.sink, box = FALSE, axes = FALSE)

koala.surv <- list(stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Sur_F03R+')),
                   stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Sur_F01+')),
                   stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Sur_F02NR+')),
                   stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Sur_F03NR+')))

koala.fec <- list(NULL,
                  NULL,
                  stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Sur_F02R+')),
                  stack(list.files("inst/extdata", full = TRUE, pattern = 'Koala_Sur_F03R+')))

################# BASIC DETERMINISTIC GROWTH #####################

koala.habitat <- build_habitat(habitat_suitability = koala.hab.suit,
                               carrying_capacity = koala.hab.k,
                               misc = NULL)
koala.demography <- build_demography(transition_matrix = koala.trans.mat,
                                     type = 'local', 
                                     habitat_suitability = koala.hab.suit,
                                     dispersal_parameters = koala.disp.param,
                                     misc = NULL)
koala.population <- build_population(population_raster = koala.pop)
koala.state <- build_state(habitat = koala.habitat,
                           demography = koala.demography,
                           population = koala.population)

koala.habitat.dynamics <- habitat_dynamics()
koala.demography.dynamics <- demography_dynamics()
koala.population.dynamics <- population_dynamics()
koala.dynamics <- build_dynamics(habitat_dynamics = koala.habitat.dynamics,
                                 demography_dynamics = koala.demography.dynamics,
                                 population_dynamics = koala.population.dynamics,
                                 order = c("habitat_dynamics",
                                           "population_dynamics",
                                           "demography_dynamics")
)

sim_results <- simulation(state = koala.state,
                          dynamics = koala.dynamics,
                          timesteps = 100,
                          replicates = 5)

########################################################################

################# WITH ENVIRONMENTAL STOCHASTICITY #####################

koala.habitat <- build_habitat(habitat_suitability = koala.hab.suit,
                               carrying_capacity = koala.hab.k,
                               misc = NULL)
koala.demography <- build_demography(transition_matrix = koala.trans.mat,
                                     type = 'local', 
                                     habitat_suitability = koala.hab.suit,
                                     dispersal_parameters = koala.disp.param,
                                     misc = NULL)
koala.population <- build_population(population_raster = koala.pop)
koala.state <- build_state(habitat = koala.habitat,
                           demography = koala.demography,
                           population = koala.population)

koala.habitat.dynamics <- habitat_dynamics()
koala.demography.dynamics <- demography_dynamics(demo_environmental_stochasticity(transition_matrix = koala.trans.mat,
                                                                                  stochasticity = koala.trans.mat.es))
koala.population.dynamics <- population_dynamics()
koala.dynamics <- build_dynamics(habitat_dynamics = koala.habitat.dynamics,
                                 demography_dynamics = koala.demography.dynamics,
                                 population_dynamics = koala.population.dynamics,
                                 order = c("habitat_dynamics",
                                           "population_dynamics",
                                           "demography_dynamics")
)

sim_results <- simulation(state = koala.state,
                          dynamics = koala.dynamics,
                          timesteps = 10,
                          replicates = 5)

########################################################################

################# WITH DETERMINISTIC CHANGES TO HABITAT #####################

koala.habitat <- build_habitat(habitat_suitability = koala.hab.suit,
                               carrying_capacity = koala.hab.k,
                               misc = NULL)
koala.demography <- build_demography(transition_matrix = koala.trans.mat,
                                     type = 'local', 
                                     habitat_suitability = koala.hab.suit,
                                     dispersal_parameters = koala.disp.param,
                                     misc = NULL)
koala.population <- build_population(population_raster = koala.pop)
koala.state <- build_state(habitat = koala.habitat,
                           demography = koala.demography,
                           population = koala.population)

koala.habitat.dynamics <- habitat_dynamics()
koala.demography.dynamics <- demography_dynamics()
koala.population.dynamics <- population_dynamics()
koala.dynamics <- build_dynamics(habitat_dynamics = koala.habitat.dynamics,
                                 demography_dynamics = koala.demography.dynamics,
                                 population_dynamics = koala.population.dynamics,
                                 order = c("habitat_dynamics",
                                           "population_dynamics",
                                           "demography_dynamics")
)

sim_results <- simulation(state = koala.state,
                          dynamics = koala.dynamics,
                          timesteps = 100,
                          replicates = 5)

########################################################################

################# WITH DEMOGRAPHIC DENSITY DEPENDENCE #####################

koala.habitat <- build_habitat(habitat_suitability = koala.hab.suit,
                               carrying_capacity = koala.hab.k*0.1,
                               misc = NULL)
koala.demography <- build_demography(transition_matrix = koala.trans.mat,
                                     type = 'local', 
                                     habitat_suitability = koala.hab.suit,
                                     dispersal_parameters = koala.disp.param,
                                     misc = NULL)
koala.population <- build_population(population_raster = koala.pop)
koala.state <- build_state(habitat = koala.habitat,
                           demography = koala.demography,
                           population = koala.population)

koala.habitat.dynamics <- habitat_dynamics()
koala.demography.dynamics <- demography_dynamics(demo_dens_dep = demo_density_dependence(koala.trans.mat,
                                                                                         fecundity_fraction = 0.8,
                                                                                         survival_fraction = 0.8))
koala.population.dynamics <- population_dynamics()
koala.dynamics <- build_dynamics(habitat_dynamics = koala.habitat.dynamics,
                                 demography_dynamics = koala.demography.dynamics,
                                 population_dynamics = koala.population.dynamics,
                                 order = c("habitat_dynamics",
                                           "population_dynamics",
                                           "demography_dynamics")
)

sim_results <- simulation(state = koala.state,
                          dynamics = koala.dynamics,
                          timesteps = 100,
                          replicates = 5)

########################################################################

################# WITH DETERMINISTIC CHANGES IN DEMOGRAPHICS #####################

koala.habitat <- build_habitat(habitat_suitability = koala.hab.suit,
                               carrying_capacity = koala.hab.k,
                               misc = NULL)
koala.demography <- build_demography(transition_matrix = koala.trans.mat,
                                     type = 'local', 
                                     habitat_suitability = koala.hab.suit,
                                     dispersal_parameters = koala.disp.param,
                                     misc = NULL)
koala.population <- build_population(population_raster = koala.pop)
koala.state <- build_state(habitat = koala.habitat,
                           demography = koala.demography,
                           population = koala.population)

koala.habitat.dynamics <- habitat_dynamics()
koala.demography.dynamics <- demography_dynamics(demo_dens_dep = demo_density_dependence(koala.trans.mat,
                                                                                         fecundity_fraction = 0.8,
                                                                                         survival_fraction = 0.8))
koala.population.dynamics <- population_dynamics()
koala.dynamics <- build_dynamics(habitat_dynamics = koala.habitat.dynamics,
                                 demography_dynamics = koala.demography.dynamics,
                                 population_dynamics = koala.population.dynamics,
                                 order = c("habitat_dynamics",
                                           "population_dynamics",
                                           "demography_dynamics")
)

sim_results <- simulation(state = koala.state,
                          dynamics = koala.dynamics,
                          timesteps = 100,
                          replicates = 5)

##################################################################################

################# WITH DEMOGRAPHIC STOCHASTICITY IN POPULATION #####################

koala.habitat <- build_habitat(habitat_suitability = koala.hab.suit,
                               carrying_capacity = koala.hab.k,
                               misc = NULL)
koala.demography <- build_demography(transition_matrix = koala.trans.mat,
                                     type = 'local', 
                                     habitat_suitability = koala.hab.suit,
                                     dispersal_parameters = koala.disp.param,
                                     misc = NULL)
koala.population <- build_population(population_raster = koala.pop)
koala.state <- build_state(habitat = koala.habitat,
                           demography = koala.demography,
                           population = koala.population)

koala.habitat.dynamics <- habitat_dynamics()
koala.demography.dynamics <- demography_dynamics()
koala.population.dynamics <- population_dynamics(pop_change = demographic_stochasticity())
koala.dynamics <- build_dynamics(habitat_dynamics = koala.habitat.dynamics,
                                 demography_dynamics = koala.demography.dynamics,
                                 population_dynamics = koala.population.dynamics,
                                 order = c("habitat_dynamics",
                                           "population_dynamics",
                                           "demography_dynamics")
)

sim_results <- simulation(state = koala.state,
                          dynamics = koala.dynamics,
                          timesteps = 10,
                          replicates = 5)

########################################################################

plot(sim_results)

plot(sim_results, stage = 2)

plot(sim_results, stage = 0)

plot(sim_results[1], type = "raster", stage = 0)

plot(sim_results[1], type = "raster", stage = 2)

plot(sim_results[1], type = "raster", stage =4, animate = TRUE)

plot(sim_results[1], object = "habitat_suitability")

plot(sim_results[1], object = "carrying_capacity")

