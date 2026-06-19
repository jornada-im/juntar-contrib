# jrn467002_XDesert_LPI.R
# 
# Original file build_dataset.210467002.R

library(tidyverse)

source('config.R')
# Set paths
out_path <- file.path(im_path, 'WIP_packages/210467002_XDesert_LPI')
in_path <- file.path(out_path, "source_data")

# Output data file 1 name
f_out1 <- file.path(out_path, "jrn467002_Xdesert_LPI.csv")

# read in data
df_in1 <- read_csv(file.path(in_path, "XDESERTlpi.csv")) 
#		  skip = 12, na = c('nan', '.', ''))

df.export1 <- df_in1

# Based on feedback from Mikaela (see SolvingLPIprobelm.xlsx), there are some unknown
# codes in the data that need to be changed because they were either a) entered
# with an incorrect code, or b) entered with an unknown code and identified later.
df.export1 |> filter(Top.Canopy=="MUPO")
df.export1 <- df.export1 |> mutate(
  across(Top.Canopy:Soil.Surface, ~ replace_values(.,
    "UKSI" ~ "CEVA",
    "Arist" ~ "ARIST", # Change to ARIST in codes doc
    "UNKsh1" ~ "PERA4",
    "STIPI" ~ "STPI",
    "ACNA2" ~ "ACHNA2",
    "UNKSH1" ~ "DAFO",
    "PLMU" ~ "PLMU3",
    "BOBA" ~ "BOBA2",
    "UNK1" ~ "ACHNA2",
    "IKF1" ~ "ARCOC4",
    "PRGL" ~ "PRGL2",
    "MUPO" ~ "MUPO2",
    "UKG2" ~ "POSE",
    "OPUNT SP." ~ "CYEC3", # Mikaela mapped to CYEC, but this seems more correct
    "Opuntia" ~ "OPUNT", # Mainly for consistency, change in codes doc
    "DPCR" ~ "SPCR",
    "YUCC" ~ "YUCCA"))
  )

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
f_out2 <- file.path(out_path, "Xdesert_codes.csv")

# read in data
# Note that there were non-UTF characters here that were removed!
df_in2 <- read_csv(file.path(in_path, "XdesertCodes.csv")) %>%
  rename("vocabulary"="WhichCode") %>%
  mutate(vocabulary = vocabulary |> replace_values(
    "USDA_Codes" ~ "USDA",
    "Custom_Codes" ~ "custom")) %>%
  separate(Codes, into=c("code", "meaning"), sep="=|=\\s") %>%
  mutate(meaning=trimws(meaning),
         slcode = str_length(code)) # For re-assigning custom vocab
#		  skip = 12, na = c('nan', '.', ''))

# We know a few of these codes are misspelled or were standardized to a 
# new value in the LPI data file
df.export2 <- df_in2 |> mutate(
  code = code |> replace_values(
    "ERJOG.sp" ~ "ERIOG.sp",
    "Arist" ~ "ARIST",
    "Opuntia" ~ "OPUNT"),
  # assign short codes to custom vocab
  vocabulary = ifelse(slcode < 4, "custom", vocabulary)) |>
  select(vocabulary, code, meaning)

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

# Some of these mystery codes can be solved with feedback from Mikaela (see 
# SolvingLPIprobelm.xlsx). Add the missing codes here 
add.codes <- tibble(vocabulary = c(rep("USDA", 3),rep("custom", 9)), 
  code = mystery_codes$lpi_codes,
  meaning=c("Peraphyllum ramosissimum",
            "Cylindropuntia echinocarpa (Engelm. & J.M. Bigelow) F.M. Knuth",
            "Acourtia nana (A. Gray) Reveal & R.M. King","Dalea formosa",
            "no plant present","Herbaceous litter","Woody litter <2.5 cm",
            "Unknown grass","Gravel rock >2<64mm","incipient/physical crust",
            "dark cyanobacterial/physical crust","Psora decipiens"))

df.export2 <- bind_rows(df.export2, add.codes)

# Get the taxonomic merge code
## The chdir argument lets the sourced script use relative paths
# source('../juntar-core/R/taxa_code_merge.R', chdir=TRUE)
# # Match lter field codes to the missing codes
# tm <- match_lter_codes(mystery_codes, 'lpi_codes', im_path)
# # Pull out unmapped codes and a merged table
# unmappedlter <- tm$unmapped_codes
# mergedlter <- tm$merged %>% filter(!is.na(lpi_codes))

# # Match lter field codes to the missing codes
# tm2 <- match_usda_codes(mystery_codes, 'lpi_codes', im_path)
# # Pull out unmapped codes and a merged table
# unmappedusda <- tm2$unmapped_codes
# mergedusda <- tm2$merged %>% filter(!is.na(lpi_codes))
# # Join the two into one and write
# test <- full_join(mergedlter, mergedusda, by="lpi_codes")
# write.csv(test, file.path(out_path, "lpi_mysterycodes_test.csv"), quote=F, row.names=F)

# Export df.export as a csv to current directory (no rownames or quoting)
options(scipen=999)   # turns off scientific notation
write.csv(df.export2, f_out2, quote=T, row.names=F)
## NOTE - there is a comma in one citation/binomial name - put that value in quotes

# Move some files
file.copy(file.path(in_path, 'XdesertLPI.R'),
          file.path(out_path,'XdesertLPI.R'), overwrite = TRUE)
file.copy(file.path(in_path, "Cross Desert All Sites.kmz"),
          file.path(out_path, "Xdesert_All_Sites.kmz"), overwrite = TRUE)

#### Publish?
library(jerald)
publish_dataset(210467002, "edi.staging", out_path, "~/Desktop", dry_run=TRUE, s3_upload=TRUE)