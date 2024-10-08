library(tidyverse)
library(here)
library(dplyr)
library(skimr)
library(naniar)
library(ggplot2)
mydata3 <- read_delim(here("DATA", "finaldata2.txt"))

# Does the age distribution of the patients depend on their sex (`gender`)???-

ggplot(data=mydata3) +
  aes(x= gender, 
      y= age) +
  geom_boxplot() 


  