
library(dplyr)
library(here)
library(tidyverse)
library(skimr)
library(naniar)
library(ggplot2)

mydata3<-read_delim(here("DATA", "mydata_joined2024-09-12.txt"))


# Does the aspirin usage depend on the age?

#must combine asa81 and asa325 to one new variable, level 0 =no, 81 or 325 =1


mydata3<- mydata3%>%
mutate(ASA = 
        if_else(asa81 ==1 |  asa325==1,
                true = 1,
                false = 0))
mydata3%>%
count(ASA)

mydata3%>%
  count(asa81)

mydata3%>%
  count(asa325)

#Select only patients with ASA=1

mydata3%>%
  filter(ASA==1)



#making plot:

ggplot(data = mydata3) +
  aes(
    x = as.factor(ASA),
    y = age
  ) +
  geom_boxplot() 
)