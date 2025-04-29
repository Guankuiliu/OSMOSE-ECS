rm(list=ls())
setwd("~/Prj/Workstudio/scenarios")
## Data Processing


data_path <- "~/Prj/Workstudio/scenarios"
osmose_base_BK <- "./osmose_base_BK/"  # OSMOSE-ECS calibrated.
biomass_base_path = file.path(osmose_base_BK, "output-PAPIER-trophic/ecs_biomass_Simu0.csv")
yield_base_path = file.path(osmose_base_BK, "output-PAPIER-trophic/ecs_yield_Simu0.csv")
biomass_base_df <- read.csv(biomass_base_path, skip = 1, header = TRUE)
yield_base_df <- read.csv(yield_base_path, skip = 1, header = TRUE)
biomass_base_mean = data.frame(colMeans(as.data.frame(sapply(biomass_base_df[51:100, 2:13], as.numeric))))
yield_base_mean = data.frame(colMeans(as.data.frame(sapply(yield_base_df[51:100, 2:13], as.numeric))))

data_all_path <- file.path(data_path, "OSMOSE_ALL")
data_low_path <- file.path(data_path, "OSMOSE_LOW")
data_middle_path <- file.path(data_path, "OSMOSE_MIDDLE")
data_high_path <- file.path(data_path, "OSMOSE_HIGH")
data_path_list <- c(data_all_path, data_low_path, data_middle_path, data_high_path)

Changeresults_post <- data.frame()
Changeresults_target <- data.frame()
for(scenario_group in data_path_list){
  dir_list <- list.dirs(scenario_group, full.names = FALSE, recursive = FALSE)
  target <- strsplit(scenario_group, '_')[[1]][2]
  for(dir in dir_list){
    f_ratio <- as.numeric(strsplit(dir, '_')[[1]][3])
    biomass_simu_path <- file.path(scenario_group, dir, "output-PAPIER-trophic/ecs_biomass_Simu0.csv")
    yield_simu_path <- file.path(scenario_group, dir, "output-PAPIER-trophic/ecs_yield_Simu0.csv")
    biomass_simu_df = read.csv(biomass_simu_path, skip = 1, header = TRUE)
    yield_simu_df = read.csv(yield_simu_path, skip = 1, header = TRUE)
    biomass_simu_mean = data.frame(colMeans(as.data.frame(sapply(biomass_simu_df[51:100, 2:13], as.numeric))))
    yield_simu_mean = data.frame(colMeans(as.data.frame(sapply(yield_simu_df[51:100, 2:13], as.numeric))))
    newdata_df <- data.frame("species" = rownames(biomass_simu_mean))
    newdata_df$"Biomass.sim" = biomass_simu_mean[, 1]
    newdata_df$"Yield.sim" = yield_simu_mean[, 1]
    newdata_df$"target" = tolower(target)
    newdata_df$"F" = f_ratio-1
    newdata_df$"Biochange" = (biomass_simu_mean[, 1]-biomass_base_mean[, 1])/biomass_base_mean[, 1]
    newdata_df$"Yieldchange" = (yield_simu_mean[, 1]-yield_base_mean[, 1])/yield_base_mean[, 1]
    newdata_df$"Functional.group" <- c(rep("low trophic", 5), rep("middle trophic", 3), rep("high trophic", 4))
    
    Changeresults_target <-rbind(Changeresults_target, newdata_df)
  }
  Changeresults_post <-rbind(Changeresults_post, Changeresults_target)
}

write.csv(Changeresults_post, "./Figs/fig02_biomass&yield/Changeresults.csv", row.names = FALSE)
















