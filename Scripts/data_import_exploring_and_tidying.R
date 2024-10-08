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
# two column names start with a number
# one column name with a space
# variable types wrong, some should be changed from "character" to "factor"
# many missing values in "bleed"
# column missing: sod, pep
# columns to delete: feature type, feature_value

#changing column name with space: 
mydata <- mydata %>%
  rename(feature_type = `feature type`)
mydata %>% select(id, feature_type, feature_value)


#changing column name starting with numbers: 

mydata <- mydata %>%
  rename(asa81 = "81asa")
mydata

mydata <- mydata%>%
  rename(asa325 = "325asa")

# tidying the column feature type and feature value to new columns with variable names

mydata <- mydata %>%
  distinct()


mydata <- mydata %>%
  pivot_wider(names_from = feature_type, values_from = feature_value)

glimpse(mydata)


# checked if there are duplicate rows, removed duplicate rows


# read in additional data

mydata2 <- read_delim(here("DATA", "exam_joindata.txt"))
mydata2
mydata2 <- mydata2 %>%
  distinct()

glimpse(mydata2)
glimpse(mydata)

length(unique(mydata2$id))
length(unique(mydata$id))

# Joined mydata with mydata2

mydata_joined <- mydata %>%
  full_join(mydata2, join_by("id"))
mydata_joined %>% glimpse()


# Changed the type of "gender" to factor

mydata_joined$gender <- as.factor(mydata_joined$gender)
class(mydata_joined$gender)   



# exploring data: 575 NA in "bleed", 402 NA in antibody
mydata_joined %>%
  naniar::gg_miss_var()
sum(is.na(mydata_joined$antibody))
mydata_joined %>%
  count(bleed)




# Create a new column showing whether age is higher than 35 or not: values High/Low

library(dplyr)
mydata_joined<-mydata_joined %>% 
  mutate(age_cat = case_when(age >= 36 ~ "High",
                             age <= 35 ~ "Low" ))

glimpse(mydata_joined)
mydata_joined %>%
  mutate(age_cat = as.factor(age_cat)) %>%
  count(age_cat)

# Remove unnecessary columns from dataframe: `acinar, train, amp, pdstent`

mydata_joined <- mydata_joined %>%
  select(-c(acinar, train, amp, pdstent))

glimpse(mydata_joined)
# changed the variable rx to a factor with 2 levels, 0 and 1 

mydata_joined <- mydata_joined %>%
  mutate(rx = 
           case_when(rx == "placebo"~ 0,
                     rx == "indomethacin" ~ 1))

mydata_joined$rx <- factor(mydata_joined$rx, levels = c(0,1))


glimpse((mydata_joined))

#adding a column where pep 1=yes, 0=no
mydata_joined<-mydata_joined %>% 
  mutate(pep_cat = case_when(pep == 1 ~ "yes",
                             pep== 0 ~ "no" ))


glimpse(mydata_joined)



#storing dataset cleaned so far
write_delim()
