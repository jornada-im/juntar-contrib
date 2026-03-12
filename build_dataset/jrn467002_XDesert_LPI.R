# jrn467002_XDesert_LPI.R
# 
# Original file build_dataset.210467002.R

source('config.R')
# Set paths
out_path <- paste(im_path, 'WIP_packages/210467002_XDesert_LPI', sep='/')
in_path <- paste(out_path, "source_data", sep="/")
# Output data file name
f_out <- paste(out_path, "jrn467002_Xdesert_LPI.csv", sep='/')

library(tidyverse)

# read in data
df_in <- read_csv(paste(in_path, "XDESERTlpi.csv", sep="/")) 
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

# Move some files
file.copy(paste(in_path, 'XdesertLPI.R', sep="/"), paste(out_path,'XdesertLPI.R', sep="/"),
                overwrite = TRUE)
file.copy(paste(in_path, "Cross Desert All Sites.kmz", sep="/"), paste(out_path, "Xdesert_All_Sites.kmz", sep="/"),
                overwrite = TRUE)
