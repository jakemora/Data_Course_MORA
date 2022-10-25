# packages
library(tidyverse)
library(modelr)
library(easystats)
library(broom)

#1 reading in the data
df <- read.csv("./mushroom_growth.csv")

#2 exploring with plots
df %>% names()

df %>% 
  ggplot(aes(x=Humidity,y=GrowthRate)) +
  geom_boxplot() +
  facet_wrap(~Species)

df %>% 
  ggplot(aes(x=Nitrogen,y=GrowthRate)) +
  geom_boxplot() +
  facet_wrap(~Temperature)

df %>% 
  ggplot(aes(x=Humidity,y=GrowthRate)) +
  geom_boxplot() +
  facet_wrap(~Light)

df %>% 
  ggplot(aes(x=Nitrogen,GrowthRate)) +
  geom_boxplot() +
  facet_wrap(~Humidity)

#3 Making models
mod1 <- glm(data=df, 
            formula = GrowthRate ~ Nitrogen + Temperature)

mod2 <- glm(data=df,
            formula = GrowthRate ~ Nitrogen + Temperature + Species + Humidity)

mod3 <- glm(data = df,
            formula = GrowthRate ~ Nitrogen * Temperature * Species * Humidity)

mod4 <- glm(data=df,
            formula = GrowthRate ~ .^2)

#4 & 5 calculating mean sq area and selecting best model
compare_performance(mod1,mod2,mod3,mod4, 
                    rank = TRUE)
# mod 4 is the best and this is the best and simplest formula for it
step <- MASS::stepAIC(mod4) # best thing ever
step$formula 

#6
add_predictions(df,mod4) %>% 
  ggplot(aes(x=Humidity,y=pred)) +
  geom_boxplot() +
  facet_wrap(~Species)
