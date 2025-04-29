rm(list=ls())
setwd("~/Prj/Workstudio/scenarios/osmose_base_BK")

library(rJava)
library(usethis)
library(devtools)
library(osmose)
library(calibrar)
library(foreach)
library(iterators)
library(parallel)

library(doParallel)

# run the osmose java core
run_osmose("ecs_all-parameters.csv", osmose="../../jar/osmose-4.3.3-jar-with-dependencies.jar")
