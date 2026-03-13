# jrn467001_XDesert_Cfix.R
# 
# Original file build_dataset.210467001.R

source('config.R')
# Set paths
out_path <- paste(im_path, 'WIP_packages/210467001_XDesert_Cfix', sep='/')
in_path <- paste(out_path, "source_data", sep="/")

# Output data file 1 name
f_out1 <- paste(out_path, "jrn467001_Xdesert_Cfix.csv", sep='/')

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

# Output data file 2 name
f_out2 <- paste(out_path, "jrn467001_Xdesert_LICOR_Meta.csv", sep='/')

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

# Output data file 3 name
f_out3 <- paste(out_path, "jrn467001_Xdesert_LICOR_Tracking.csv", sep='/')

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

# Output data file 4 name
f_out4 <- paste(out_path, "RawLicor_variable_key.csv", sep='/')

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


# Now copy files to main dir (if needed)
file.copy(paste(in_path, 'CrossDesertJERrawLICOR.xlsx', sep="/"),
          paste(out_path, 'CrossDesertJERrawLICOR.xlsx', sep="/"), overwrite = TRUE)
file.copy(paste(in_path, 'CrossDesertMOJrawLICOR.xlsx', sep="/"), 
          paste(out_path, 'CrossDesertMOJrawLICOR.xlsx', sep="/"), overwrite = TRUE)
file.copy(paste(in_path, 'CrossDesertSEVrawLICOR.xlsx', sep="/"),
          paste(out_path, 'CrossDesertSEVrawLICOR.xlsx', sep="/"), overwrite = TRUE)
file.copy(paste(in_path, 'CrossDesertRCEWrawLICOR.xlsx', sep="/"),
          paste(out_path, 'CrossDesertRCEWrawLICOR.xlsx', sep="/"), overwrite = TRUE)
file.copy(paste(in_path, 'XdesertLICORextration.R', sep="/"),
          paste(out_path, 'XdesertLICORextraction.R', sep="/"), overwrite = TRUE)

