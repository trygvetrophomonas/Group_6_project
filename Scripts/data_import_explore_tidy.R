library(tidyverse)
library(here)
library(dplyr)
library(skimr)
library(naniar)

mydata <- read_delim(here("DATA", "exam_dataset.txt"))
mydata

#initial exploration of data ----

tail(mydata)
head(mydata)
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
  rename(asa81 = "81asa")
mydata

mydata <- mydata%>%
  rename(asa325 = "325asa")


mydata <- mydata %>%
  pivot_wider(names_from = feature_type, values_from = feature_value)

# tidying the column feature type and feture value to new columns with varriable names

mydata <- mydata %>%
  distinct()


# changed names ov columns witch started wit a number

 mydata <- mydata %>%
  pivot_wider(names_from = feature_type, values_from = feature_value)

 # tidying the column feature type and feture value to new columns with varriable names


# checked if there is duplicate rows removed duplicate rows

mydata2 <- read_delim(here("DATA", "exam_joindata.txt"))
mydata2

# read inn additional data

mydata_joined <- mydata %>%
  full_join(mydata2, join_by("id"))

# Joined mydata with mydata2

mydata_joined$gender <- as.factor(mydata_joined$gender)
class(mydata_joined$gender)   


# Changed the type of "gender" to factor


mydata_joined %>%
  naniar::gg_miss_var()
sum(is.na(mydata_joined$antibody))
mydata_joined %>%
  count(bleed)


# exploring data: 575 NA in "bleed", 402 NA in antibody

# Create a new column showing whether age is higher than 35 or not: values High/Low

library(dplyr)
mydata_joined<-mydata_joined %>% 
  mutate(age_cat = case_when(age >= 36 ~ "High",
                             age <= 35 ~ "Low" ))


# Remove unnecessary columns from your dataframe: `acinar, train, amp, pdstent`

mydata_joined <- mydata_joined %>%
  select(-c(acinar, train, amp, pdstent))

mydata_joined <- mydata_joined %>%
  mutate(rx = 
           case_when(rx == "placebo"~ 0,
                     rx == "indomethacin" ~ 1))

mydata_joined$rx <- factor(mydata_joined$rx, levels = c(0,1))

# changed the varriable rx to a factor with 2 levels, 0 and 1 "




