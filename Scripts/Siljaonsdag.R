
#creating a new variable where pep 1 =yed, pep 0 =no
mydata_joined <- mydata3 %>% 
  mutate(pep_cat = 
           if_else(pep =="yes" ,
                   true = 1,
                   false = 0))
library(dplyr)
mydata3<-mydata3 %>% 
  mutate(pep_cat = case_when(pep = 1 ~ "yes",
                             pep= 0 ~ "no" ))

#separating IDs into different sites
mydata_joined$id

mydata_joined %>% 
  separate_wider_delim(id, delim="_", names = c("site_1", "site_2", "site_3", "site_4"))

too_few = "debug"
"align_start"/"align_end"

#creating a variable that is a product of age and risk
mydata_joined<-mydata_joined %>% 
  mutate (age_and_risk = age*risk)
view(mydata_joined$age_and_risk)

#rearranging the columns. works. add site as nr 2
mydata_joined %>% 
select(id,age, everything())
