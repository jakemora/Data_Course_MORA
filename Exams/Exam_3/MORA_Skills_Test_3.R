library(tidyverse)
library(modelr)
library(broom)

# Part 1
fsal <- read_csv("./FacultySalaries_1995.csv")

colnames <- c("FedID",
              "UnivName", 
              "State", 
              "Tier", 
              "AvgSal",
              "AvgComp",
              "ProfCount",
              "ProfRank")
full <- select(fsal, 
               matches("Full|UnivName|FedID|State|Tier")) %>% 
    mutate(profrank = "Full") %>% 
    setNames(colnames)
assoc <- select(fsal, 
                matches("Assoc|UnivName|FedID|State|Tier")) %>%
  mutate(profrank = "Assoc") %>% 
  setNames(colnames)
assis <- select(fsal, 
                matches("Assist|UnivName|FedID|State|Tier")) %>% 
  mutate(profrank = "Assis") %>% 
  setNames(colnames)
nsal <- bind_rows(full,assoc,assis)

p1 <- nsal %>% 
  subset(Tier != "VIIB") %>% 
ggplot(aes(x=ProfRank, y=AvgSal,
             fill = ProfRank)) +
  geom_boxplot() +
  facet_wrap(~Tier) +
  theme_bw() 

ggsave("./MORA_Fig_1.jpg",
       p1,
       width = 4,
       height = 4,
       dpi = 300) 

# Part 2
saov <- aov(data = nsal,
            formula = AvgSal ~ Tier + ProfRank + State)
sal_aov <- tidy(saov)
tidy(saov)
write.table(sal_aov, 
            file = "./Salary_Anova_Summary.txt",
            row.names = TRUE,
            col.names = TRUE)


# Part 3
joils <- read_csv("./Juniper_Oils.csv")

njoils <- joils %>% 
  pivot_longer(cols =  c("alpha-pinene","para-cymene",
                         "alpha-terpineol","cedr-9-ene",
                         "alpha-cedrene","beta-cedrene",
                         "cis-thujopsene","alpha-himachalene",
                         "beta-chamigrene","cuparene","compound 1",
               "alpha-chamigrene","widdrol","cedrol",
               "beta-acorenol","alpha-acorenol",
               "gamma-eudesmol","beta-eudesmol",
               "alpha-eudesmol","cedr-8-en-13-ol",
               "cedr-8-en-15-ol",
               "compound 2","thujopsenal"),
               names_to = "chemID",
               values_to = "concentration")

# Part 4
p2 <- njoils %>% 
  ggplot(aes(x=YearsSinceBurn, 
             y=concentration,)) +
  geom_smooth() +
  facet_wrap(~chemID,
             scales = "free_y")

ggsave("./MORA_Fig_2.jpg",
       p2,
       width = 8,
       height = 6,
       dpi = 300)

# Part 5
mod2 <- glm(data=njoils,
            concentration ~ YearsSinceBurn * chemID)
jsig <- tidy(mod2) %>% 
  filter(p.value<0.05)

write.table(jsig, 
            file = "./Juniper_Oils_Summary.txt",
            row.names = TRUE,
            col.names = TRUE)


