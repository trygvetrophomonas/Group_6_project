# According to the data, was the indomethacin reducing the risk of pancreatitis?


mydata3 %>% 
  wilcox.test(pep~rx, data = .) %>%
  broom::tidy()

ggplot(data=mydata3, aes(rx)) +
  geom_bar(aes(fill = as.factor(pep)), position = "dodge")

