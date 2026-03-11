# build_dataset.210467001.R
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
# setwd('/Volumes/unix/path/to/datasets/ds210467001.../')
# setwd('Z:\\windows\path\to\datasets\ds210467001...\)

library(tidyverse)

# Path to incoming source data files
dsource <- "./source_data/"

# Output data file name
f_out1 <- "jrn467001_Xdesert_Cfix.csv"

# read first dataset
df_in <- read_csv(paste0(dsource, "Study467cfixCrossDesert.csv")) %>%
  rename(MeasurementDate = MeasurmentDate)


df.export <- df_in

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
unique(df.export$Type)
#df.export$Type[df.export$Type == "CLV"] <- "CVL"
unique(df.export$Rep)
unique(df.export$Machine)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out1, quote=F, row.names=F)

# Output data file name
f_out2 <- "jrn467001_Xdesert_LICOR_Meta.csv"

# read first dataset
df_in <- read_csv(paste0(dsource, "CrossDesertMetaLICOR.csv")) %>%
  rename(MeasurementDate = MeasurmentDate)


df.export <- df_in

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
unique(df.export$Type)
#df.export$Type[df.export$Type == "CLV"] <- "CVL"
unique(df.export$Rep)
unique(df.export$Machine)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out2, quote=F, row.names=F)

# Output data file name
f_out3 <- "jrn467001_Xdesert_LICOR_Tracking.csv"

# read first dataset
df_in <- read_csv(paste0(dsource, "CrossDesertTrackingLICOR.csv"))#, 
#		  skip = 12, na = c('nan', '.', ''))


df.export <- df_in

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Location)
unique(df.export$Site)
unique(df.export$Type)
#df.export$Type[df.export$Type == "CLV"] <- "CVL"
unique(df.export$Rep)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out3, quote=F, row.names=F)

# Output data file name
f_out4 <- "RawLicor_variable_key.csv"

# read first dataset
df_in <- read_csv(paste0(dsource, "RawLicor_variable_key.csv"))#, 
#		  skip = 12, na = c('nan', '.', ''))


df.export <- df_in %>%
  select(-`Empty value code`)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out4, quote=F, row.names=F)


# Now copy files to main dir
file.copy('./source_data/CrossDesertJERrawLICOR.xlsx', './CrossDesertJERrawLICOR.xlsx', overwrite = TRUE)
file.copy('./source_data/CrossDesertMOJrawLICOR.xlsx', './CrossDesertMOJrawLICOR.xlsx', overwrite = TRUE)
file.copy('./source_data/CrossDesertSEVrawLICOR.xlsx', './CrossDesertSEVrawLICOR.xlsx', overwrite = TRUE)
file.copy('./source_data/CrossDesertRCEWrawLICOR.xlsx', './CrossDesertRCEWrawLICOR.xlsx', overwrite = TRUE)
file.copy('./source_data/XdesertLICORextration.R', './XdesertLICORextraction.R', overwrite = TRUE)

