library(tidyverse)
library(here)
library(dplyr)
library(skimr)
library(naniar)

mydata <- read_delim(here("DATA", "exam_dataset.txt"))
mydata


#  Does the outcome depend on the site where the procedure was performed?

chisq_test <- chisq.test(table(mydata$gender, mydata$outcome))
print(chisq_test)

 #RESULTS X-squared = 0.083733, df = 1, p-value = 0.7723