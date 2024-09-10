library(tidyverse)
library(here)
library("skimr")
library("naniar")

#importing and naming the dataset "mydata"
mydata <-read_delim(here("DATA", "exam_dataset.txt"))

#exploring data
tail(mydata)
tail(mydata, n=30)
view("mydata")

#or look in enviroment to se MyData, press arrow or open the file

# coloumns 81ASA 325ASA and feature type need to be renamed
#all variables are in colomns 
#all variables except age and risk should be factor

skimr::skim("mydata")

mydata%>% 
  naniar::gg_miss_var()
#see gg-plot for missing variables:there are almost 600 NA for bleed

# delete these colomns: feature type? feature value?
#add these colomns: sod, pep, 

#dropping variables feature type, feature value
mydata <- mydata %>%
  select(-c(`feature type`, feature_value))

#rename two variables because of started with a number: 
mydata<-mydata%>%
  rename(asa81 = "81asa")

mydata<-mydata%>%
  rename(asa325 = "325asa")

#remove duplicated rows: 
mydata<-mydata%>%
  distinct()

view(mydata)

#importing the Joindata file
mydata2 <-read_delim(here("Data", "exam_joindata.txt"))

#viewing the file
mydata2

#remove duplicates in joindata
mydata2<-mydata2%>%
  distinct()
mydata2

#full join of files: 
mydata_joined<-mydata%>%
  full_join(mydata2, join_by("id"))

#checking for NAs: ca 400 for antibodies
mydata_joined%>% 
  naniar::gg_miss_var()

#Counting NAs: 575 for bleed, works because there are only 3 outcomes
mydata_joined %>%
  count(bleed)
  
#changing the antibody from numeric to factor: 

mydata_joined$antibody<- as.factor(mydata_joined$antibody)
class(mydata_joined$antibody))

#takkforidag
