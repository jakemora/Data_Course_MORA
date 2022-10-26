# Exam 2

#packages 
library(tidyverse)
library(modelr)
library(broom)
library(easystats)

#1 read in the data
df <- read.csv("./unicef-u5mr.csv")

#2 Making the data tidy
df1 <- df %>% 
  pivot_longer(cols = starts_with("U5MR."),
               names_to = "Year",
               values_to = "U5MR",
               names_prefix = "U5MR.") %>% 
  mutate(Year = as.numeric(Year))

#3 plotting U5MR for each country over time 

p1 <- df1 %>% 
  filter(!is.na(U5MR)) %>% 
  ggplot(aes(x=Year,y=U5MR,
             group = CountryName)) +
  geom_line() +
  facet_wrap(~Continent)

#4 save plot
ggsave("./Mora_Plot_1.png",p1,width = 4, height = 4,dpi = 300)

#5 Plot numero dos
p2 <- df1 %>% 
  filter(!is.na(U5MR)) %>% 
  group_by(Continent,Year) %>% 
  summarize(Mean_U5MR = mean(U5MR)) %>% 
  ggplot(aes(x=Year,y=Mean_U5MR,
             color = Continent)) +
    geom_line()

#6 save plot 2
ggsave("./Mora_Plot_2.png",p2,width = 4, height = 4, dpi = 300)

#7 Creating models
mod1 <- glm(data = df1, formula = U5MR ~ Year)
mod2 <- glm(data = df1, formula = U5MR ~ Year + Continent)
mod3 <- glm(data = df1, formula = U5MR ~ Year * Continent)

#8 Comparing models
compare_performance(mod1,mod2,mod3, rank = TRUE)
# model 3 seems to be the best with the highest R2, lowest RMSE and 
# Highest AIC weight and lowest standard deviation. It also got ranked
# as the highest by the compare_performance() function

#9 Plotting models
p3 <- gather_predictions(df1,mod1,mod2,mod3) %>% 
  ggplot(aes(x=Year,y=pred,
             color = Continent)) +
  geom_line() +
  facet_wrap(~model) +
  labs(y="U5MR_pred")

p3

ggsave("./MORA_Plot_3.png",p3,width = 4, height = 4, dpi = 300)
