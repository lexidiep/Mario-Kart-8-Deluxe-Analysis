# install all packages
install.packages("tidyverse")
install.packages("dplyr")
install.packages("skimr")
install.packages("janitor")
install.packages("ggplot2")
install.packages("patchwork")
install.packages("reshape")
install.packages("rmarkdown")
# load all packages
library(tidyverse)
library(dplyr)
library(skimr)
library(janitor)
library(ggplot2)
library(patchwork)
library(reshape)
library(rmarkdown)

# save .csv data into separate data frames
bodies_karts <- read_csv("Mario_Kart_8_Deluxe_bodies_karts.csv")
drivers <- read_csv("Mario_Kart_8_Deluxe_drivers.csv")
gliders <- read_csv("Mario_Kart_8_Deluxe_gliders.csv")
tires <- read_csv("Mario_Kart_8_Deluxe_tires.csv")

# review summaries of data
head(bodies_karts)
colnames(bodies_karts)
head(drivers)
colnames(drivers)
head(gliders)
colnames(gliders)
head(tires)
colnames(tires)

# clean columns in each data frame for analysis
bodies_karts <- clean_names(bodies_karts)
drivers <- clean_names(drivers)
gliders <- clean_names(gliders)
tires <- clean_names(tires)

# ANALYZE EFFECT OF WEIGHT ON SPEED
# create new column for speed score (disregarding weight)
bodies_karts <- mutate(bodies_karts, speed_score = acceleration + on_road_traction + off_road_traction + mini_turbo + ground_speed + water_speed + anti_gravity_speed + air_speed + ground_handling + water_handling + anti_gravity_handling + air_handling)
bodies_karts %>%
  drop_na() %>%
  summarize(body, speed_score)

drivers <- mutate(drivers, speed_score = acceleration + on_road_traction + off_road_traction + mini_turbo + ground_speed + water_speed + anti_gravity_speed + air_speed + ground_handling + water_handling + anti_gravity_handling + air_handling)
drivers %>%
  group_by(weight_class) %>%
  drop_na() %>%
  summarize(driver, speed_score)

gliders <- mutate(gliders, speed_score = acceleration + on_road_traction + off_road_traction + mini_turbo + ground_speed + water_speed + anti_gravity_speed + air_speed + ground_handling + water_handling + anti_gravity_handling + air_handling)
gliders %>%
  drop_na() %>%
  summarize(glider, speed_score)

tires <- mutate(tires, speed_score = acceleration + on_road_traction + off_road_traction + mini_turbo + ground_speed + water_speed + anti_gravity_speed + air_speed + ground_handling + water_handling + anti_gravity_handling + air_handling)
tires %>%
  drop_na() %>%
  summarize(tire, speed_score)

# create visualization to see trends in relationship between weight and speed score
karts_weight_plot <- ggplot(data = bodies_karts, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Karts: Weight vs. Speed Score", x = "Weight", y = "Speed Score")
drivers_weight_plot <- ggplot(data = drivers, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Drivers: Weight vs. Speed Score", x = "Weight", y = "Speed Score")
gliders_weight_plot <- ggplot(data = gliders, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Gliders: Weight vs. Speed Score", x = "Weight", y = "Speed Score")
tires_weight_plot <- ggplot(data = tires, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Tires: Weight vs. Speed Score", x = "Weight", y = "Speed Score")
karts_weight_plot + drivers_weight_plot + gliders_weight_plot + tires_weight_plot

# since weight negatively affects speed, subtract weight from speed score
bodies_karts <- mutate(bodies_karts, speed_score = speed_score - weight)
drivers <- mutate(drivers, speed_score = speed_score - weight)
gliders <- mutate(gliders, speed_score = speed_score - weight)
tires <- mutate(tires, speed_score = speed_score - weight)

# create subsets of drivers for different weight classes
heavy_drivers <- subset(drivers, weight_class == "Heavy")
medium_drivers <- subset(drivers, weight_class == "Medium")
light_drivers <- subset(drivers, weight_class == "Light")

# get the karts/drivers/gliders/tires that have the max speed score
top_karts <- bodies_karts[bodies_karts$speed_score == max(bodies_karts$speed_score),]
top_heavy_drivers <- heavy_drivers[heavy_drivers$speed_score == max(heavy_drivers$speed_score),]
top_medium_drivers <- medium_drivers[medium_drivers$speed_score == max(medium_drivers$speed_score),]
top_light_drivers <- light_drivers[light_drivers$speed_score == max(light_drivers$speed_score),]
top_gliders <- gliders[gliders$speed_score == max(gliders$speed_score),]
top_tires <- tires[tires$speed_score == max(tires$speed_score),]

# create new columns for overall traction, speed, and handling for each data frame
top_karts <- top_karts %>%
  mutate(top_karts, overall_traction = on_road_traction + off_road_traction) %>%
  mutate(top_karts, overall_speed = ground_speed + water_speed + anti_gravity_speed + air_speed) %>%
  mutate(top_karts, overall_handling = ground_handling + water_handling + anti_gravity_handling + air_handling)

top_heavy_drivers <- top_heavy_drivers %>%
  mutate(top_heavy_drivers, overall_traction = on_road_traction + off_road_traction) %>%
  mutate(top_heavy_drivers, overall_speed = ground_speed + water_speed + anti_gravity_speed + air_speed) %>%
  mutate(top_heavy_drivers, overall_handling = ground_handling + water_handling + anti_gravity_handling + air_handling)

top_medium_drivers <- top_medium_drivers %>%
  mutate(top_medium_drivers, overall_traction = on_road_traction + off_road_traction) %>%
  mutate(top_medium_drivers, overall_speed = ground_speed + water_speed + anti_gravity_speed + air_speed) %>%
  mutate(top_medium_drivers, overall_handling = ground_handling + water_handling + anti_gravity_handling + air_handling)

top_light_drivers <- top_light_drivers %>%
  mutate(top_light_drivers, overall_traction = on_road_traction + off_road_traction) %>%
  mutate(top_light_drivers, overall_speed = ground_speed + water_speed + anti_gravity_speed + air_speed) %>%
  mutate(top_light_drivers, overall_handling = ground_handling + water_handling + anti_gravity_handling + air_handling)

top_gliders <- top_gliders %>%
  mutate(top_gliders, overall_traction = on_road_traction + off_road_traction) %>%
  mutate(top_gliders, overall_speed = ground_speed + water_speed + anti_gravity_speed + air_speed) %>%
  mutate(top_gliders, overall_handling = ground_handling + water_handling + anti_gravity_handling + air_handling)

top_tires <- top_tires %>%
  mutate(top_tires, overall_traction = on_road_traction + off_road_traction) %>%
  mutate(top_tires, overall_speed = ground_speed + water_speed + anti_gravity_speed + air_speed) %>%
  mutate(top_tires, overall_handling = ground_handling + water_handling + anti_gravity_handling + air_handling)

# remove specific stats to only contain general stats (only applies to traction, handling, speed)
top_karts <- subset(top_karts, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
top_heavy_drivers <- subset(top_heavy_drivers, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
top_medium_drivers <- subset(top_medium_drivers, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
top_light_drivers <- subset(top_light_drivers, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
top_gliders <- subset(top_gliders, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
top_tires <- subset(top_tires, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
# also remove the weight_class column from driver data frames
top_heavy_drivers <- subset(top_heavy_drivers, select = -c(weight_class))
top_medium_drivers <- subset(top_medium_drivers, select = -c(weight_class))
top_light_drivers <- subset(top_light_drivers, select = -c(weight_class))


# create percent stacked bar chart displaying the values of different attributes that contribute to speed score

# TOP KARTS CHART
top_karts <- data.frame(top_karts)
new_top_karts <- melt(subset(top_karts, select = -c(speed_score)), id.vars = "body")
top_karts_plot <- ggplot(new_top_karts, aes(x = body, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Tire Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Karts", x = "Body", y = "Total Speed Score (with Weight)", fill = "Kart Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 45), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
  
# TOP HEAVY DRIVERS CHART
top_heavy_drivers <- data.frame(top_heavy_drivers)
new_top_heavy_drivers <- melt(subset(top_heavy_drivers, select = -c(speed_score)), id.vars = "driver")
top_heavy_drivers_plot <- ggplot(new_top_heavy_drivers, aes(x = driver, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Tire Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Heavy Drivers", x = "Driver", y = "Total Speed Score (with Weight)", fill = "Driver Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 65), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# TOP MEDIUM DRIVERS CHART
top_medium_drivers <- data.frame(top_medium_drivers)
new_top_medium_drivers <- melt(subset(top_medium_drivers, select = -c(speed_score)), id.vars = "driver")
top_medium_drivers_plot <- ggplot(new_top_medium_drivers, aes(x = driver, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Tire Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Medium Drivers", x = "Driver", y = "Total Speed Score (with Weight)", fill = "Driver Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# TOP LIGHT DRIVERS CHART
top_light_drivers <- data.frame(top_light_drivers)
new_top_light_drivers <- melt(subset(top_light_drivers, select = -c(speed_score)), id.vars = "driver")
top_light_drivers_plot <- ggplot(new_top_light_drivers, aes(x = driver, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Tire Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Light Drivers", x = "Driver", y = "Total Speed Score (with Weight)", fill = "Driver Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# TOP GLIDERS CHART
top_gliders <- data.frame(top_gliders)
new_top_gliders <- melt(subset(top_gliders, select = -c(speed_score)), id.vars = "glider")
top_gliders_plot <- ggplot(new_top_gliders, aes(x = glider, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Tire Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Gliders", x = "Glider", y = "Total Speed Score (with Weight)", fill = "Glider Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 14), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

# TOP TIRES CHART
top_tires <- data.frame(top_tires)
new_top_tires <- melt(subset(top_tires, select = -c(speed_score)), id.vars = "tire")
top_tires_plot <- ggplot(new_top_tires, aes(x = tire, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Tire Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Tires", x = "Tire", y = "Total Speed Score (with Weight)", fill = "Tire Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 40), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

top_karts_plot
top_heavy_drivers_plot
top_medium_drivers_plot
top_light_drivers_plot
top_gliders_plot
top_tires_plot

colnames(bodies_karts)