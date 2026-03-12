# jrn467001_XDesert_Cfix.R
# 
# Original file build_dataset.210467001.R

source('config.R')
# Set paths
out_path <- paste(im_path, 'WIP_packages/210467001_XDesert_Cfix', sep='/')
in_path <- paste(out_path, "source_data", sep="/")
# Output data file name
f_out <- paste(out_path, "jrn467001_Xdesert_Cfix.csv", sep='/')

library(tidyverse)

# read first dataset
df_in <- read_csv(paste(in_path, "Study467cfixCrossDesert.csv", sep="/")) %>%
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
df_in <- read_csv(paste(in_path, "CrossDesertMetaLICOR.csv", sep="/")) %>%
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
df_in <- read_csv(paste(in_path, "CrossDesertTrackingLICOR.csv", sep="/"))#, 
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
df_in <- read_csv(paste(in_path, "RawLicor_variable_key.csv", sep="/"))#, 
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

