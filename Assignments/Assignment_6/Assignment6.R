dat <- read.csv("./BioLog_Plate_Data.csv")
library(tidyverse)

dat_long <- dat %>% 
  pivot_longer(cols = starts_with("Hr_"),
               names_to = "Time",
               values_to = "Absorbance") %>% 
  mutate(Time = substring(Time,4,)%>% as.numeric()) %>% 
  mutate(Environment = case_when(Sample.ID == "Soil_1" ~ "Soil",
                                 Sample.ID == "Soil_2" ~ "Soil",
                                 TRUE ~ "Water")) 
  
dat_long %>% 
  filter(Dilution == 0.1) %>% 
  group_by(Environment,Substrate,Time) %>% 
  summarize(Absorbance = mean(Absorbance)) %>% 
  ggplot(aes(x = Time, y = Absorbance,
             color = Environment)) +
  facet_wrap(~Substrate) +
  geom_smooth() +
  geom_blank()

library(gganimate)

dat_long %>% 
  filter(Substrate == "Itaconic Acid") %>% 
  group_by(Time,Sample.ID,Dilution) %>% 
  summarize(Mean_Absorbance = mean(Absorbance)) %>% 
  ggplot(aes(x = Time, y = Mean_Absorbance,
             color = Sample.ID)) +
  geom_line() +
  facet_wrap(~Dilution) +
  transition_reveal(Time)
