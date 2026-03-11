# build_dataset.210467002.R
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
# setwd('/Volumes/unix/path/to/datasets/ds210467002.../')
# setwd('Z:\\windows\path\to\datasets\ds210467002...\)

library(tidyverse)

# Path to incoming source data files
dsource <- "./source_data/"

# Output data file name
f_out <- "jrn467002_Xdesert_LPI.csv"

# read in mtcars (our example data)
df_in <- read_csv(paste0(dsource, "XDESERTlpi.csv")) 
#		  skip = 12, na = c('nan', '.', ''))

df.export <- df_in

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$Site)
unique(df.export$Location)
unique(df.export$Page)
unique(df.export$Top.Canopy)
unique(df.export$Soil.Surface)
unique(df.export$Recorder)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out, quote=F, row.names=F)


file.copy('./source_data/XdesertLPI.R', './XdesertLPI.R', overwrite = TRUE)
file.copy('./source_data/Cross Desert All Sites.kmz', 'Xdesert_All_Sites.kmz', overwrite = TRUE)

