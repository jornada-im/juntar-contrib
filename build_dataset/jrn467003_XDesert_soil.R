# jrn467003_XDesert_soil.R
# 
# Original file build_dataset.210467003.R

source('config.R')
# Set paths
out_path <- file.path(im_path, 'WIP_packages/210467003_XDesert_soil')
in_path <- file.path(out_path, "source_data")

# Output data file 1 name
f_out1 <- file.path(out_path, "jrn467003_Xdesert_soil_stability.csv")

library(tidyverse)

# read in file
df_in <- read_csv(file.path(in_path, "XDESERTsoilStability.csv")) %>% mutate(
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


# Output data file 2 name
f_out2 <- file.path(out_path, "jrn467003_Xdesert_soil_chemistry.csv")

# read in file
df_in <- read_csv(file.path(in_path, "XdesertSoilChem.csv")) %>%
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
f_out3 <- file.path(out_path, "jrn467003_Xdesert_soil_moisture.csv")

# read in file
df_in <- read_csv(file.path(in_path, "XdesertSoilMoisture0.csv"))# %>%
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
f_out4 <- file.path(out_path, "jrn467003_Xdesert_PLFA_combined.csv")

# read in file
df_in <- read_csv(file.path(in_path, "Xdesert_PLFA_combinedAdapted_update.csv")) %>%
  rename("ArbuscularMycorrhizalPercent" = "ArbusularMycorrhizalPercent")
#		  skip = 12, na = c('nan', '.', ''))

df.export <- df_in# %>%
#  dplyr::select(type, mpg, wt, cyl, gear)

# Check for NAs and unique values of catvars
sapply(df.export, function(x) sum(is.na(x)))
unique(df.export$SampleID) # This should probably be split apart
unique(df.export$Depth)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export, f_out4, quote=F, row.names=F)

# Output data file name
f_out5 <- file.path(out_path, "jrn467003_Xdesert_soil_texture.csv")

# read in file
df_in <- read_csv(file.path(in_path, "CrossDesertSoilTexture_update.csv")) %>% mutate(
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

#### Publish?
library(jerald)
publish_dataset(210467003, "edi.staging", out_path, "~/Desktop", dry_run=TRUE, s3_upload=TRUE)

