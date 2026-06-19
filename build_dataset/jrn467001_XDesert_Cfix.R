# jrn467001_XDesert_Cfix.R
# 
# Original file build_dataset.210467001.R

source('config.R')
# Set paths
out_path <- file.path(im_path, 'WIP_packages/210467001_XDesert_Cfix')
in_path <- file.path(out_path, "source_data")

# Output data file 1 name
f_out1 <- file.path(out_path, "jrn467001_Xdesert_Cfix.csv")

library(tidyverse)

# read first dataset
df_in <- read_csv(file.path(in_path, "Study467cfixCrossDesert.csv")) %>%
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
f_out2 <- file.path(out_path, "jrn467001_Xdesert_LICOR_Meta.csv")

# read first dataset
df_in <- read_csv(file.path(in_path, "CrossDesertMetaLICOR.csv")) %>%
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
f_out3 <- file.path(out_path, "jrn467001_Xdesert_LICOR_Tracking.csv")

# read first dataset
df_in <- read_csv(file.path(in_path, "CrossDesertTrackingLICOR.csv"))#, 
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
f_out4 <- file.path(out_path, "RawLicor_variable_key.csv")

# read first dataset
df_in <- read_csv(file.path(in_path, "RawLicor_variable_key.csv"))#, 
#		  skip = 12, na = c('nan', '.', ''))


df.export <- df_in %>%
  select(-`Empty value code`)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out4, quote=F, row.names=F)


# Now copy files to main dir (if needed)
file.copy(file.path(in_path, 'CrossDesertJERrawLICOR.xlsx'),
          file.path(out_path, 'CrossDesertJERrawLICOR.xlsx'), overwrite = TRUE)
file.copy(file.path(in_path, 'CrossDesertMOJrawLICOR.xlsx'), 
          file.path(out_path, 'CrossDesertMOJrawLICOR.xlsx'), overwrite = TRUE)
file.copy(file.path(in_path, 'CrossDesertSEVrawLICOR.xlsx'),
          file.path(out_path, 'CrossDesertSEVrawLICOR.xlsx'), overwrite = TRUE)
file.copy(file.path(in_path, 'CrossDesertRCEWrawLICOR.xlsx'),
          file.path(out_path, 'CrossDesertRCEWrawLICOR.xlsx'), overwrite = TRUE)
file.copy(file.path(in_path, 'XdesertLICORextration.R'),
          file.path(out_path, 'XdesertLICORextraction.R'), overwrite = TRUE)


#### Publish?
library(jerald)
publish_dataset(210467001, "edi.staging", out_path, "~/Desktop", dry_run=TRUE, s3_upload=TRUE)

