

# This is Exam 1 redo


library(tidyverse)
library(dplyr)
#1
df <- read.csv("./cleaned_covid_data.csv")
glimpse(df)

#2
A_states <- df %>% 
  filter(grepl("^A",Province_State))

#3
A_states %>% 
  ggplot(aes(x=as.Date(Last_Update, format='%Y-%m-%d'),
             y=Deaths,
             color = Province_State))+
  facet_wrap(~Province_State, scales = "free") +
  geom_point(color = "Black", size = 0.5) +
  geom_smooth(method = "loess", se = FALSE) +
  theme_bw() +
  labs(x = "Last Update") +
  theme(axis.text.x = element_text(angle = -90))

#4
state_max_fatality_rate <- df %>% 
  select(Province_State,Case_Fatality_Ratio) %>%
  group_by(Province_State) %>% 
  slice_max(n = 1, 
            Case_Fatality_Ratio,
            with_ties = FALSE) %>% 
  arrange(desc(Case_Fatality_Ratio)) %>% 
  drop_na() 

state_max_fatality_rate$Maximum_Fatality_Ratio <- state_max_fatality_rate$Case_Fatality_Ratio

state_max_fatality_rate <- state_max_fatality_rate %>% 
  select(Province_State,Maximum_Fatality_Ratio) 


#5
as.factor(state_max_fatality_rate$Province_State) %>% 
  ggplot(data=state_max_fatality_rate,
         mapping = aes(x=reorder(Province_State, -Maximum_Fatality_Ratio),
                       y=Maximum_Fatality_Ratio)) +
  geom_bar(stat = 'identity') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90), ) +
  labs(y="Max Fatality Ratio",
       x="Province/State",
       title = "Max Fatality Ratio of Each State/Province") 
#6

Cummulative_US_Deaths <- df %>% 
  select(Last_Update,Deaths) %>%
  group_by(Last_Update) %>% 
  summarise(total_deaths = sum(Deaths)) %>% 
  drop_na()   

Cummulative_US_Deaths %>% 
  ggplot(aes(x=as.Date(Last_Update, format='%Y-%m-%d'),
             y=total_deaths)) +
  geom_point() +
  labs(x= "Date",
       y = "Total Deaths",
       title = "Cummulative US COVID Deaths") + 
  theme_bw()


