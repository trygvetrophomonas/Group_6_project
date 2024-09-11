library(tidyverse)
library(here)

library(skimr)
library(naniar)

mydata <- read_delim(here("DATA", "exam_dataset.txt"))
mydata

#initial exploration of data ----

tail(mydata)
head(mydata)
view(mydata)
mydata %>% count(id)
glimpse(mydata)
skimr::skim(mydata)
naniar::gg_miss_var(mydata)


# 602 "ids" are duplicated
# two colomn names start with a number
# one colomn name with a space
# variable types wrong, some should be changed from "character" to "factor"
# many missing values in "bleed"
# colomn missing: sod, pep
# column to delete: feature type, feature_value

mydata <- mydata %>%
  rename(feature_type = `feature type`)
mydata

# changed column name with space

mydata <- mydata %>%
  select(-c(feature_type, feature_value))

# removed unnessesary columns

mydata <- mydata %>%
  rename(asa81 = "81asa")
mydata

mydata <- mydata%>%
  rename(asa325 = "325asa")

# changed names ov columns witch started wit a number

mydata <- mydata %>%
  distinct()

# removed dupolicate rows

mydata2 <- read_delim(here("DATA", "exam_joindata.txt"))
mydata2

# leste inn additional data

mydata_joined <- mydata %>%
  full_join(mydata2, join_by("id"))

mydata_joined$gender <- as.factor(mydata_joined$gender)
class(mydata_joined$gender)   

# Joined mydata with mydata2
# Changed the type of "gender" to factor
# There are two column names in the codebook that we do not have. 
# Since we dont have any observations for these two columns we did not add them

mydata_joined %>%
  naniar::gg_miss_var()

mydata_joined %>%
  count(bleed)

# exploring data: 575 NA in "bleed",

tidy_data_group6 <- paste0("mydata_joined", Sys.Date(), ".txt")
write_delim(mydata_joined, 
            file = here("DATA", tidy_data_group6), delim="\t")

