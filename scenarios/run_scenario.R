rm(list=ls())

library(osmose)
setwd("~/Prj/Workstudio/scenarios/")

F_ratio <- seq(0.1, 1.9, 0.1)
osmose_base_BK <- "./osmose_base_BK"  # OSMOSE-ECS calibrated.


## ALL
scenarios_all <- "OSMOSE_ALL"
dir.create(scenarios_all)
all_df <- data.frame()
for(f_ratio in F_ratio){
  print(paste("########## ", scenarios_all, f_ratio, " ##########", sep = ' '))
  osmose_tmp <- paste("osmose_ecs_", f_ratio, sep = "")
  osmose_tmp_path <- file.path(scenarios_all, osmose_tmp)
  dir.create(osmose_tmp_path)
  osmose_base_files <- list.files(osmose_base_BK, full.names = TRUE)
  for(file in osmose_base_files){
    file.copy(file, osmose_tmp_path, recursive = TRUE)
  }
  mortality_F_path <- file.path(osmose_tmp_path, "ecs_param-fishing_2Phase.csv")
  mortality_F_df <- read.csv(mortality_F_path, header = FALSE, blank.lines.skip = FALSE)
  biomass_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_biomass_Simu0.csv")
  yield_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_yield_Simu0.csv")
  biomass_base_df <- read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_base_df <- read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_base_mean = data.frame(colMeans(as.data.frame(sapply(biomass_base_df[51:100, 2:13], as.numeric))))
  yield_base_mean = data.frame(colMeans(as.data.frame(sapply(yield_base_df[51:100, 2:13], as.numeric))))

  for(i in 34:45){
    mortality_str = strsplit(mortality_F_df[i, 1], ';')[[1]][1]
    mortality_num_new = as.numeric(strsplit(mortality_F_df[i, 1], ';')[[1]][2])*f_ratio
    mortality_F_df[i, 1] = paste(mortality_str, mortality_num_new, sep = ';')
  }
  write.table(mortality_F_df, mortality_F_path, row.names = FALSE, col.names = FALSE, quote = FALSE)
  osmose_run_path = file.path(osmose_tmp_path, "ecs_all-parameters.csv")
  run_osmose(osmose_run_path, osmose = "../jar/osmose-4.3.3-jar-with-dependencies.jar", verbose = FALSE)
  biomass_simu_df = read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_simu_df = read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_simu_mean = data.frame(colMeans(as.data.frame(sapply(biomass_simu_df[51:100, 2:13], as.numeric))))
  yield_simu_mean = data.frame(colMeans(as.data.frame(sapply(yield_simu_df[51:100, 2:13], as.numeric))))
  newdata_df <- data.frame("species" = rownames(biomass_simu_mean))
  newdata_df$"Biomass.sim" = biomass_simu_mean[, 1]
  newdata_df$"Yield.sim" = yield_simu_mean[, 1]
  newdata_df$"target" = "all"
  newdata_df$"F" = f_ratio-1
  newdata_df$"Biochange" = (biomass_simu_mean[, 1]-biomass_base_mean[, 1])/biomass_base_mean[, 1]
  newdata_df$"Yieldchange" = (yield_simu_mean[, 1]-yield_base_mean[, 1])/yield_base_mean[, 1]
  newdata_df$"Functional.group" <- c(rep("low trophic", 5), rep("middle trophic", 3), rep("high trophic", 4))
  all_df <- rbind(newdata_df, all_df)
}
write.csv(all_df, "./all_change.csv", row.names = FALSE)


## LOW
scenarios_low <- "OSMOSE_LOW"
dir.create(scenarios_low)
low_df <- data.frame()
for(f_ratio in F_ratio){
  print(paste("########## ", scenarios_low, f_ratio, " ##########", sep = ' '))
  osmose_tmp <- paste("osmose_ecs_", f_ratio, sep = "")
  osmose_tmp_path <- file.path(scenarios_low, osmose_tmp)
  dir.create(osmose_tmp_path)
  osmose_base_files <- list.files(osmose_base_BK, full.names = TRUE)
  for(file in osmose_base_files){
    file.copy(file, osmose_tmp_path, recursive = TRUE)
  }
  mortality_F_path <- file.path(osmose_tmp_path, "ecs_param-fishing_2Phase.csv")
  mortality_F_df <- read.csv(mortality_F_path, header = FALSE, blank.lines.skip = FALSE)
  biomass_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_biomass_Simu0.csv")
  yield_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_yield_Simu0.csv")
  biomass_base_df <- read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_base_df <- read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_base_mean = data.frame(colMeans(as.data.frame(sapply(biomass_base_df[51:100, 2:13], as.numeric))))
  yield_base_mean = data.frame(colMeans(as.data.frame(sapply(yield_base_df[51:100, 2:13], as.numeric))))
  for(i in 34:38){
    mortality_str = strsplit(mortality_F_df[i, 1], ';')[[1]][1]
    mortality_num_new = as.numeric(strsplit(mortality_F_df[i, 1], ';')[[1]][2])*f_ratio
    mortality_F_df[i, 1] = paste(mortality_str, mortality_num_new, sep = ';')
  }
  write.table(mortality_F_df, mortality_F_path, row.names = FALSE, col.names = FALSE, quote = FALSE)
  osmose_run_path = file.path(osmose_tmp_path, "ecs_all-parameters.csv")
  run_osmose(osmose_run_path, osmose = "../jar/osmose-4.3.3-jar-with-dependencies.jar", verbose = FALSE)
  biomass_simu_df = read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_simu_df = read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_simu_mean = data.frame(colMeans(as.data.frame(sapply(biomass_simu_df[51:100, 2:13], as.numeric))))
  yield_simu_mean = data.frame(colMeans(as.data.frame(sapply(yield_simu_df[51:100, 2:13], as.numeric))))
  newdata_df <- data.frame("species" = rownames(biomass_simu_mean))
  newdata_df$"Biomass.sim" = biomass_simu_mean[, 1]
  newdata_df$"Yield.sim" = yield_simu_mean[, 1]
  newdata_df$"target" = "low"
  newdata_df$"F" = f_ratio-1
  newdata_df$"Biochange" = (biomass_simu_mean[, 1]-biomass_base_mean[, 1])/biomass_base_mean[, 1]
  newdata_df$"Yieldchange" = (yield_simu_mean[, 1]-yield_base_mean[, 1])/yield_base_mean[, 1]
  newdata_df$"Functional.group" <- c(rep("low trophic", 5), rep("middle trophic", 3), rep("high trophic", 4))
  low_df <- rbind(newdata_df, low_df)
}
write.csv(low_df, "./low_change.csv", row.names = FALSE)

## MID
scenarios_middle <- "OSMOSE_MIDDLE"
dir.create(scenarios_middle)
middle_df <- data.frame()
for(f_ratio in F_ratio){
print(paste("########## ", scenarios_middle, f_ratio, " ##########", sep = ' '))
  osmose_tmp <- paste("osmose_ecs_", f_ratio, sep = "")
  osmose_tmp_path <- file.path(scenarios_middle, osmose_tmp)
  dir.create(osmose_tmp_path)
  osmose_base_files <- list.files(osmose_base_BK, full.names = TRUE)
  for(file in osmose_base_files){
    file.copy(file, osmose_tmp_path, recursive = TRUE)
  }
  mortality_F_path <- file.path(osmose_tmp_path, "ecs_param-fishing_2Phase.csv")
  mortality_F_df <- read.csv(mortality_F_path, header = FALSE, blank.lines.skip = FALSE)
  biomass_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_biomass_Simu0.csv")
  yield_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_yield_Simu0.csv")
  biomass_base_df <- read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_base_df <- read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_base_mean = data.frame(colMeans(as.data.frame(sapply(biomass_base_df[51:100, 2:13], as.numeric))))
  yield_base_mean = data.frame(colMeans(as.data.frame(sapply(yield_base_df[51:100, 2:13], as.numeric))))
  for(i in 39:41){
    mortality_str = strsplit(mortality_F_df[i, 1], ';')[[1]][1]
    mortality_num_new = as.numeric(strsplit(mortality_F_df[i, 1], ';')[[1]][2])*f_ratio
    mortality_F_df[i, 1] = paste(mortality_str, mortality_num_new, sep = ';')
  }
  write.table(mortality_F_df, mortality_F_path, row.names = FALSE, col.names = FALSE, quote = FALSE)
  osmose_run_path = file.path(osmose_tmp_path, "ecs_all-parameters.csv")
  run_osmose(osmose_run_path, osmose = "../jar/osmose-4.3.3-jar-with-dependencies.jar", verbose = FALSE)
  biomass_simu_df = read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_simu_df = read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_simu_mean = data.frame(colMeans(as.data.frame(sapply(biomass_simu_df[51:100, 2:13], as.numeric))))
  yield_simu_mean = data.frame(colMeans(as.data.frame(sapply(yield_simu_df[51:100, 2:13], as.numeric))))
  newdata_df <- data.frame("species" = rownames(biomass_simu_mean))
  newdata_df$"Biomass.sim" = biomass_simu_mean[, 1]
  newdata_df$"Yield.sim" = yield_simu_mean[, 1]
  newdata_df$"target" = "middle"
  newdata_df$"F" = f_ratio-1
  newdata_df$"Biochange" = (biomass_simu_mean[, 1]-biomass_base_mean[, 1])/biomass_base_mean[, 1]
  newdata_df$"Yieldchange" = (yield_simu_mean[, 1]-yield_base_mean[, 1])/yield_base_mean[, 1]
  newdata_df$"Functional.group" <- c(rep("low trophic", 5), rep("middle trophic", 3), rep("high trophic", 4))
  middle_df <- rbind(newdata_df, middle_df)
}
write.csv(middle_df, "./middle_change.csv", row.names = FALSE)

## HIGH
scenarios_high <- "OSMOSE_HIGH"
dir.create(scenarios_high)
high_df <- data.frame()
for(f_ratio in F_ratio){
  print(paste("########## ", scenarios_high, f_ratio, " ##########", sep = ' '))
  osmose_tmp <- paste("osmose_ecs_", f_ratio, sep = "")
  osmose_tmp_path <- file.path(scenarios_high, osmose_tmp)
  dir.create(osmose_tmp_path)
  osmose_base_files <- list.files(osmose_base_BK, full.names = TRUE)
  for(file in osmose_base_files){
    file.copy(file, osmose_tmp_path, recursive = TRUE)
  }
  mortality_F_path <- file.path(osmose_tmp_path, "ecs_param-fishing_2Phase.csv")
  mortality_F_df <- read.csv(mortality_F_path, header = FALSE, blank.lines.skip = FALSE)
  biomass_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_biomass_Simu0.csv")
  yield_simu_path = file.path(osmose_tmp_path, "output-PAPIER-trophic/ecs_yield_Simu0.csv")
  biomass_base_df <- read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_base_df <- read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_base_mean = data.frame(colMeans(as.data.frame(sapply(biomass_base_df[51:100, 2:13], as.numeric))))
  yield_base_mean = data.frame(colMeans(as.data.frame(sapply(yield_base_df[51:100, 2:13], as.numeric))))   
  for(i in 42:45){
    mortality_str = strsplit(mortality_F_df[i, 1], ';')[[1]][1]
    mortality_num_new = as.numeric(strsplit(mortality_F_df[i, 1], ';')[[1]][2])*f_ratio
    mortality_F_df[i, 1] = paste(mortality_str, mortality_num_new, sep = ';')
  }
  write.table(mortality_F_df, mortality_F_path, row.names = FALSE, col.names = FALSE, quote = FALSE)
  osmose_run_path = file.path(osmose_tmp_path, "ecs_all-parameters.csv")
  run_osmose(osmose_run_path, osmose = "../jar/osmose-4.3.3-jar-with-dependencies.jar", verbose = FALSE)
  biomass_simu_df = read.csv(biomass_simu_path, skip = 1, header = TRUE)
  yield_simu_df = read.csv(yield_simu_path, skip = 1, header = TRUE)
  biomass_simu_mean = data.frame(colMeans(as.data.frame(sapply(biomass_simu_df[51:100, 2:13], as.numeric))))
  yield_simu_mean = data.frame(colMeans(as.data.frame(sapply(yield_simu_df[51:100, 2:13], as.numeric))))
  newdata_df <- data.frame("species" = rownames(biomass_simu_mean))
  newdata_df$"Biomass.sim" = biomass_simu_mean[, 1]
  newdata_df$"Yield.sim" = yield_simu_mean[, 1]
  newdata_df$"target" = "high"
  newdata_df$"F" = f_ratio-1
  newdata_df$"Biochange" = (biomass_simu_mean[, 1]-biomass_base_mean[, 1])/biomass_base_mean[, 1]
  newdata_df$"Yieldchange" = (yield_simu_mean[, 1]-yield_base_mean[, 1])/yield_base_mean[, 1]
  newdata_df$"Functional.group" <- c(rep("low trophic", 5), rep("middle trophic", 3), rep("high trophic", 4))
  high_df <- rbind(newdata_df, high_df)
}
write.csv(high_df, "./high_change.csv", row.names = FALSE)

Changeresult_df <- data.frame()
Changeresult_df <- rbind(Changeresult_df, all_df, low_df, middle_df, high_df)
write.csv(Changeresult_df, "./Changeresults.csv", row.names = FALSE)



