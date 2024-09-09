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
# variable types wrong, some should be changed from character to "factor"
# no missing values
