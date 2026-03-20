# jrn467002_XDesert_LPI.R
# 
# Original file build_dataset.210467002.R

library(tidyverse)

source('config.R')
# Set paths
out_path <- paste(im_path, 'WIP_packages/210467002_XDesert_LPI', sep='/')
in_path <- paste(out_path, "source_data", sep="/")

# Output data file 1 name
f_out1 <- paste(out_path, "jrn467002_Xdesert_LPI.csv", sep='/')

# read in data
df_in1 <- read_csv(paste(in_path, "XDESERTlpi.csv", sep="/")) 
#		  skip = 12, na = c('nan', '.', ''))

df.export1 <- df_in1

# Check for NAs and unique values of catvars
sapply(df.export1, function(x) sum(is.na(x)))
unique(df.export1$Site)
unique(df.export1$Location)
unique(df.export1$Page)
unique(df.export1$Top.Canopy)
unique(df.export1$Soil.Surface)
unique(df.export1$Recorder)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export1, f_out1, quote=F, row.names=F)


# Output data file 2 name
f_out2 <- paste(out_path, "Xdesert_codes.csv", sep='/')


# read in data
# Note that there were non-UTF characters here that were removed!
df_in2 <- read_csv(paste(in_path, "XdesertCodes.csv", sep="/")) %>%
  rename("vocabulary"="WhichCode") %>%
  mutate(vocabulary = vocabulary |> replace_values(
    "USDA_Codes" ~ "USDA",
    "Custom_Codes" ~ "custom")) %>%
  separate(Codes, into=c("code", "meaning"), sep="=|=\\s") %>%
  mutate(meaning=trimws(meaning))
#		  skip = 12, na = c('nan', '.', ''))


df.export2 <- df_in2

# Check for NAs and unique values of catvars
sapply(df.export2, function(x) sum(is.na(x)))
unique(df.export2$vocabulary)
unique(df.export2$code)

# Check for correspondence between LPI data and codes file (df1 and 2)
# First get unique codes in the LPI data file
lpi_codes <- unique(c(unique(df.export1$Top.Canopy),
               unique(df.export1$Code1),
               unique(df.export1$Code2), 
               unique(df.export1$Code3),
               unique(df.export1$Soil.Surface)))

# Merge with the code file Mikaela provided
# Note there were dupes in that file: CHVI8, DAPU7, PLMU3, BOBA2, LATR, LYPA
# This also shows quite a few NAs to be resolved
mystery_codes <- tibble(lpi_codes) %>%
  left_join(df.export2, by=join_by(lpi_codes==code), keep=T) %>%
  filter(is.na(code))

# Get the taxonomic merge code
## The chdir argument lets the sourced script use relative paths
source('../juntar-core/R/taxa_code_merge.R', chdir=TRUE)
# Match lter field codes to the missing codes
tm <- match_lter_codes(mystery_codes, 'lpi_codes', im_path)
# Pull out unmapped codes and a merged table
unmappedlter <- tm$unmapped_codes
mergedlter <- tm$merged %>% filter(!is.na(lpi_codes))

# Match lter field codes to the missing codes
tm2 <- match_usda_codes(mystery_codes, 'lpi_codes', im_path)
# Pull out unmapped codes and a merged table
unmappedusda <- tm2$unmapped_codes
mergedusda <- tm2$merged %>% filter(!is.na(lpi_codes))
# Join the two into one and write
test <- full_join(mergedlter, mergedusda, by="lpi_codes")
write.csv(test, paste(out_path, "lpi_mysterycodes_test.csv", sep="/"), quote=F, row.names=F)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export2, f_out2, quote=F, row.names=F)
## NOTE - there is a comma in one citation/binomial name - put that value in quotes

# Move some files
file.copy(paste(in_path, 'XdesertLPI.R', sep="/"),
          paste(out_path,'XdesertLPI.R', sep="/"), overwrite = TRUE)
file.copy(paste(in_path, "Cross Desert All Sites.kmz", sep="/"),
          paste(out_path, "Xdesert_All_Sites.kmz", sep="/"), overwrite = TRUE)

