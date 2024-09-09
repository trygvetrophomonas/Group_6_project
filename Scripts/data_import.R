library(tidyverse)
library(here)
library("skimr")
library("naniar")
mydata <-read_delim(here("DATA", "exam_dataset.txt"))
tail(mydata)
tail(mydata, n=30)
view("mydata")

#or look in enviroment to se MyData, press arrow or open the file
# coloumns 81 ASSA 325 ASA feature type need to be renamed
#all variables are in coloumns 
#all variables except age and risk should be factor

skimr::skim("mydata")

naniar::gg_miss_var("mydata")
#see gg-plot for missing variables:there are none missing 

