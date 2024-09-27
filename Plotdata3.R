library(tidyverse)
library(here)
mydata3 <- read_delim(here("DATA", "mydata_joined2024-09-12.txt"))
mydata3

# Plot the risk score change with age of the patients?

ggplot(data = mydata3) +
  aes(
    x = risk,
    y = age,
  ) +
  geom_boxplot()

