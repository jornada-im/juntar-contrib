# build_dataset.210467003.R
# 
# BOILERPLATE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# This is a template build script using R to prepare a dataset
# for EDI. You can safely remove this and other boilerplate
# and use the rest to design a new R script for your data.
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


# Set the working directory to a local or network share path
# (this only works in RStudio). 
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# If this fails try something like these:
# setwd('/Volumes/unix/path/to/datasets/ds210467003.../')
# setwd('Z:\\windows\path\to\datasets\ds210467003...\)

library(tidyverse)

# Path to incoming source data files
dsource <- "./source_data/"

# Output data file name
f_out1 <- "jrn467003_Xdesert_soil_stability.csv"

# read in file
df_in <- read_csv(paste0(dsource, "XDESERTsoilStability.csv")) %>% mutate(
  Date = as.Date(Date, format = '%m/%d/%Y'))
#		  skip = 12, na = c('nan', '.', ''))


df.export <- df_in# %>%
#  dplyr::select(type, mpg, wt, cyl, gear)


# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
unique(df.export$Depth)
df.export$Depth[df.export$Depth == "Subsuface"] <- "Subsurface"
unique(df.export$Hydrophobic)
df.export$Hydrophobic[is.na(df.export$Hydrophobic)] <- "NH"
unique(df.export$Type)
#df.export$Type[df.export$Type == "CVL"] <- "CLV"
unique(df.export$Stability)
unique(df.export$Observer)
unique(df.export$Page)

# Clean commas in Notes
df.export$Notes <- gsub(',', ';', df.export$Notes)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out1, quote=F, row.names=F)


# Output data file name
f_out2 <- "jrn467003_Xdesert_soil_chemistry.csv"

# read in file
df_in <- read_csv(paste0(dsource, "XdesertSoilChem.csv")) %>%
  rename("SaturationPercent" = "SatruationPercent")
#		  skip = 12, na = c('nan', '.', ''))

df.export <- df_in# %>%
#  dplyr::select(type, mpg, wt, cyl, gear)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
df.export$Site[df.export$Site == "M59"] <- "M50" # A mistake
unique(df.export$Depth)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out2, quote=F, row.names=F)

# Output data file name
f_out3 <- "jrn467003_Xdesert_soil_moisture.csv"

# read in file
df_in <- read_csv(paste0(dsource, "XdesertSoilMoisture0.csv"))# %>%
#  rename("SaturationPercent" = "SatruationPercent")
#		  skip = 12, na = c('nan', '.', ''))

df.export <- df_in# %>%
#  dplyr::select(type, mpg, wt, cyl, gear)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
unique(df.export$Depth)
unique(df.export$DishNum)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out3, quote=F, row.names=F)


# Output data file name
f_out4 <- "jrn467003_Xdesert_PLFA_combined.csv"

# read in file
df_in <- read_csv(paste0(dsource, "Xdesert_PLFA_combinedAdapted.csv")) %>%
  rename("ArbuscularMycorrhizalPercent" = "ArbusularMycorrhizalPercent")
#		  skip = 12, na = c('nan', '.', ''))

df.export <- df_in# %>%
#  dplyr::select(type, mpg, wt, cyl, gear)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$SampleID)
unique(df.export$Depth)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out4, quote=F, row.names=F)

# Output data file name
f_out5 <- "jrn467003_Xdesert_soil_texture.csv"

# read in file
df_in <- read_csv(paste0(dsource, "CrossDesertSoilTexture.csv")) %>% mutate(
  StartDate = as.Date(StartDate, format = '%m/%d/%Y'))

df.export <- df_in# %>%
#  dplyr::select(type, mpg, wt, cyl, gear)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
unique(df.export$Depth)
df.export$Depth[df.export$Depth == "0-1 cm"] <- "Surface"

# Clean commas in Notes
df.export$Notes <- gsub(',', ';', df.export$Notes)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out5, quote=F, row.names=F)

