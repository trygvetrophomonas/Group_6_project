library(dplyr)
library(here)
library(tidyr)

finaldata <- read_delim(here("DATA", "finaldata.txt"))

#creating a variable that is a product of age and risk. 

finaldata<-finaldata %>% 
  mutate (age_and_risk = age*risk)

view(finaldata$age_and_risk)

#separating IDs into different sites-



finaldata_separated <- finaldata %>%
  separate_wider_delim(col = id, delim = "_", names = c("Site", "ID"))

print(finaldata_separated)


#rearranging the columns. 
finaldata_separated%>% 
select(ID, Site, age, everything())
