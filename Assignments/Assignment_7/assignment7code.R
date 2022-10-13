# assignment 7

library(tidyverse)
library(GGally)
library(ggpubr)

# importing the data set
df <- read.csv("./Utah_Religions_by_County.csv") %>% 
  janitor::clean_names()

names(df)

# making the data tidy
df <- df %>% 
  pivot_longer(-c("county","pop_2010","religious")) 

df$religion <- df$name
df$religion_proportion <- df$value

df1 <- df %>% 
  select(county,religion,religious,religion_proportion,pop_2010)

# Exploring data using figures
df1 %>%  # seeing the relationship between population size and religious ration
  ggplot(aes(x=religious,y=pop_2010)) +
  geom_point() +
  theme_minimal() +
  geom_smooth()

df1 %>% # seeing what religious proportions look like for each religion
  ggplot(aes(x=religion,y=religion_proportion)) +
  geom_boxplot() +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90)) 

df1 %>% # seeing how religious each utah county is
  ggplot(aes(x=religious)) +
  geom_density() +
  theme_minimal() +
  facet_wrap(~county)

# 1
df1 %>% # population vs. religion proportion
  ggplot(aes(x=pop_2010,y=religion_proportion)) +
  geom_point()+
  theme_minimal()+
  facet_wrap(~religion) +
  theme(axis.text.x = element_text(angle = 90)) +
  geom_smooth(method="lm") +
  stat_cor(method="pearson",label.x = 400000,label.y = 0.35)

# from what I can gather I don't see a strong correlation between 
# population with any given religion.
# What we do find is that there is a slight negative correlation 
# with the non-religious and population. There's a high correlation 
# coefficient between population and the muslim religion, however
# this may be due to the small or non-existing proportion of muslims
# in each county. 

# 2 
df1 %>% 
  ggplot(aes(x=religion_proportion,y= 1- religious )) +
  geom_point() +
  theme_minimal() +
  facet_wrap(~religion) +
  labs(x = "religion proportion",
       y = "non-religious proportion") +
  geom_smooth(method = "lm") +
  stat_cor(method="pearson",label.x = 0.5,label.y = 0.4,size=2.5)

# the one correlation that is evident is that the more religious 
# a county is the higher the proportion of the lds religion.
# The correlation coefficient between non-religious proportion and 
# proportion of lds people is -0.87 indicating a strong negative 
# correlation.
  