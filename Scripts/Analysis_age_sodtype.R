library(tidyverse)
library(here)
mydata3 <- read_delim(here("DATA", "finaldata2.txt"))
mydata3

# Plot Does the age distribution depend on `sod_type`?

ggplot(data = mydata3) +
  aes(
    x = sod_type,
    y = age,
      ) +
  geom_boxplot()




