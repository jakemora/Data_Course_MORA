# ugly plot
library(tidyverse)
df <- iris

p <- df %>% 
  ggplot(aes(x=Sepal.Length,y=Species,
             color = Petal.Length)) +
  labs(title = "CoOl GrApH",
       x= "sePAL LENgth",
       y= "SPeecees") +
  theme(axis.text.x = element_text(size = 20,
                                   face = "bold.italic",
                                   color = "#0adaf5",
                                   angle = 200),
        axis.text.y = element_text(face = "italic",
                                   size = 12,
                                   angle = 200,
                                   color = "#0adaf5"),
        axis.ticks.y = element_line(size = 30),
        panel.grid = element_line(color = "#b87c4b"),
        axis.ticks.x = element_line(size = 17),
        line = element_line(size = 3, 
                            colour = "Yellow",
                            lineend = "butt"),
        axis.title.x = element_text(face = "bold.italic",
                                    size = 22,
                                    color = "#cef542"),
        panel.background = element_rect(fill = "#42f5da"),
        axis.title.y = element_text(face = "bold.italic",
                                    size = 10,
                                    color = "#cef542",
                                    angle = 165),
        plot.background = element_rect(color = "#fcf803",
                                       fill = "#49f20c"),
        title = element_text(face = "italic",
                             color = "#99680e",
                             angle = -165)) +
  geom_boxplot(notchwidth = 3,
               notch = TRUE,
               outlier.shape = 6,
               outlier.size = 33,
               outlier.color = "#611229",
               outlier.fill = "#61400b",
               fill = "#f542f2") 

ggsave("./figures/ugly_plot.png",p,width = 8,height = 8,dpi = 300)
