# Mario Kart 8 Deluxe Analysis: Technical Details

### Lexi Diep

### 12/30/2021

<br>

There are many combinations of karts, drivers, gliders, and tires to select from when playing Mario Kart 8 Deluxe, but which combination of these options are structurally the "fastest"? The drivers will be categorized into different weight classes and each driver, kart, glider, and tire is going to be broken down into their core components to analyze who and what is the "fastest" combination. The result of the analysis will provide helpful insight to aid players in their decision when selecting their lineup.

<br>

**DISCLAIMER:** All data used in this analysis can be found on [Kaggle](https://www.kaggle.com/marlowspringmeier/mario-kart-8-deluxe-ingame-statistics). Some minor changes were made in Microsoft Excel while some visualizations were created using Tableau; a majority of this analysis was performed in R.

<br>

## Table of Contents
* [**What Makes a Character, Kart, Glider, or Tire Fast?**](#what-makes-a-character-kart-glider-or-tire-fast)  
    * [What Are These Components?](#what-are-these-components)
<br><br>
* [**How Do We Find the "Fastest" Combination of Character, Kart, Glider, and Tire?**](#how-do-we-find-the-fastest-combination-of-character-kart-glider-and-tire) 
    * [Loading the necessary packages](#loading-the-necessary-packages)
    * [Setting up the data](#setting-up-the-data)
    * [Analyze the Effect of Weight on Overall Speed](#analyze-the-effect-of-weight-on-overall-speed)  
    * [Finding the "Fastest" Character (per Weight-Class), Kart, Glider, and Tire](#finding-the-fastest-character-per-weight-class-kart-glider-and-tire)
    * [Visualizing Who and What is the "Fastest"](#visualizing-who-and-what-is-the-fastest)
        * [Breakdown of the "Fastest" Karts](#breakdown-of-the-fastest-karts)
        * [Breakdown of the "Fastest Drivers](#breakdown-of-the-fastest-drivers)
          * [Breakdown of the "Fastest" Heavy Drivers](#breakdown-of-the-fastest-heavy-drivers) 
          * [Breakdown of the "Fastest" Medium Drivers](#breakdown-of-the-fastest-medium-drivers) 
          * [Breakdown of the "Fastest" Light Drivers](#breakdown-of-the-fastest-light-drivers)
        * [Breakdown of the "Fastest Gliders](#breakdown-of-the-fastest-gliders)
        * [Breakdown of the "Fastest Tires](#breakdown-of-the-fastest-tires)
<br><br>
* [**Conclusion**](#conclusion)

<br><br>

## What Makes a Character, Kart, Glider, or Tire Fast?

Each character, kart, glider, and tire is composed of several different factors that have an effect on how "fast" it is in a given race. All selections are composed of values for "weight", "acceleration", "on-road traction", "off-road traction", "mini turbo", "ground speed", "water speed", "anti-gravity speed", "air speed", "ground handling", "water handling", "anti-gravity handling", and "air handling".  

These values are not explicitly stated in the actual game, however, the values have been interpreted as a point-based system by a collective group of players from the [Mario Wiki](https://www.mariowiki.com/Mario_Kart_8_Deluxe) based on the selection's statistics scale provided by the game.
  
<br>
  
#### What Are These Components?  

According to the [Mario Wiki](https://www.mariowiki.com/Mario_Kart_8_Deluxe):  

* **Weight** is the value representing how heavy the selection (character, kart, tire, glider) is
  * Selections with a higher weight value can knock away selections with a lower weight value more easily  
* **Acceleration** is the value representing how fast the speed increases until the top speed has been reached (while holding the acceleration button)  
* **Traction** is the value representing the grasp of the selection
  * Selections with a higher traction value slip less on certain terrain and can stay stable on the road better
  * Traction consists of *"on-road traction"* (for driving on the main course path) and *"off-road traction"* (for driving off the main course path)  
* **Mini Turbo** is the value representing the length of the selection's mini-turbo speed boosts and how fast mini turbos can be charged
  * This component also affects the length of jump boosts from tricks  
* **Speed** is the value representing the top speed of a selection
  * *"ground speed"* is the top speed of a selection while driving on land
  * *"water speed"* is the top speed of a selection while driving underwater
  * *"anti-gravity speed"* is the top speed of a selection while driving in anti-gravity mode
  * *"air speed"* is the top speed of a selection while gliding  
* **Handling** is the value representing the turning ability of a selection
  * Selections with a higher handling value mean that it will turn sharper, and will continue turning normally for longer before automatically initiating a drift  
  * *"ground handling"* is the turning ability of a selection while driving on land
  * *"water handling"* is the turning ability of a selection while driving underwater
  * *"anti-gravity handling"* is the turning ability of a selection while driving in anti-gravity mode
  * *"air handling"* is the turning ability of a selection while gliding  

**NOTE:** Each of these components exists to essentially mimic real-world physics in a video game.

<br><br>

## How Do We Find the "Fastest" Combination of Character, Kart, Glider, and Tire?

**DISCLAIMER:** Using the "Mario_Kart_8_Deluxe_drivers.csv" in  Microsoft Excel, I added an extra column to indicate the weight class of each character (heavy, medium, and light).

<br>

### Loading the necessary packages
To complete this analysis, I needed several packages to complete the cleaning, analysis, and the creation of visualizations.
```{r Package Loading, message=FALSE, warning=FALSE}
library(tidyverse)
library(dplyr)
library(skimr)
library(janitor)
library(ggplot2)
library(patchwork)
library(reshape)
library(rmarkdown)
```


### Setting up the data
This data set included four .csv files that contained values for each component for each selection, which were saved into separate data frames. To keep the columns consistent among each data frame, each column in every data frame was cleaned.
```{r Reading and Cleaning, message=FALSE, warning=FALSE}
bodies_karts <- read_csv("Mario_Kart_8_Deluxe_bodies_karts.csv")
drivers <- read_csv("Mario_Kart_8_Deluxe_drivers.csv")
gliders <- read_csv("Mario_Kart_8_Deluxe_gliders.csv")
tires <- read_csv("Mario_Kart_8_Deluxe_tires.csv")

bodies_karts <- clean_names(bodies_karts)
drivers <- clean_names(drivers)
gliders <- clean_names(gliders)
tires <- clean_names(tires)
```

<br><br>

### Analyze the effect of weight on overall speed
Based on the descriptions of different components of every selection, all components represented a clear positive contribution to overall speed except the "weight" component. If the game mimics real-world physics, weight should decrease overall speed. Based on the description of "weight" according to the [Mario Wiki](https://www.mariowiki.com/Mario_Kart_8_Deluxe), the effect of weight on overall speed was not described.
With this in mind, I decided to first analyze the effect of weight on overall speed before moving on.

<br>

First, I created a new column in each data frame to store the "speed score" of each selection. The speed score was a calculation of all the components' values added together, disregarding the "weight" value itself.
```{r Speed Score Column Addition, message=FALSE, warning=FALSE}
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
```

<br>

Then, I created separate visualizations to show the relationship between weight and each selection's speed score.
```{r Effect of Weight Multi-Plot Creation, message=FALSE, warning=FALSE}
karts_weight_plot <- ggplot(data = bodies_karts, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Karts: Weight vs. Speed Score", x = "Weight", y = "Speed Score")

drivers_weight_plot <- ggplot(data = drivers, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Drivers: Weight vs. Speed Score", x = "Weight", y = "Speed Score")

gliders_weight_plot <- ggplot(data = gliders, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Gliders: Weight vs. Speed Score", x = "Weight", y = "Speed Score")

tires_weight_plot <- ggplot(data = tires, aes(x = weight, y = speed_score)) + geom_point() + geom_smooth() + labs(title = "Tires: Weight vs. Speed Score", x = "Weight", y = "Speed Score")
```
![Effect of Weight Multi-Plot](https://user-images.githubusercontent.com/56329600/158035668-e1276657-719b-4873-9a0c-83880bf61d80.png)

<br>

Since each visualization showed that there was a negative trend between weight and each selection, it's clear that weight negatively impacts overall speed. With this finding, I subtracted the "weight" values from each "speed score".
```{r Speed Score Calculation}
bodies_karts <- mutate(bodies_karts, speed_score = speed_score - weight)
drivers <- mutate(drivers, speed_score = speed_score - weight)
gliders <- mutate(gliders, speed_score = speed_score - weight)
tires <- mutate(tires, speed_score = speed_score - weight)
```

<br><br>

### Finding the "Fastest" Character (per Weight Class), Kart, Glider, and Tire

For the fastest drivers, I split the "drivers" data frame into three separate data frames to categorize characters of the same weight class.
```{r Driver Categorization, warning=FALSE}
heavy_drivers <- subset(drivers, weight_class == "Heavy")
medium_drivers <- subset(drivers, weight_class == "Medium")
light_drivers <- subset(drivers, weight_class == "Light")
```

Selections with the maximum speed score were found and stored into separate data frames, since there would likely be multiple drivers/karts/gliders/tires with the same maximum speed score.
```{r Selections with Maximum Speed Score, warning=FALSE}
top_karts <- bodies_karts[bodies_karts$speed_score == max(bodies_karts$speed_score),]
top_heavy_drivers <- heavy_drivers[heavy_drivers$speed_score == max(heavy_drivers$speed_score),]
top_medium_drivers <- medium_drivers[medium_drivers$speed_score == max(medium_drivers$speed_score),]
top_light_drivers <- light_drivers[light_drivers$speed_score == max(light_drivers$speed_score),]
top_gliders <- gliders[gliders$speed_score == max(gliders$speed_score),]
top_tires <- tires[tires$speed_score == max(tires$speed_score),]
```

<br>

To simplify the components of each selection, I created columns in each data frame to combine specific metrics into general components. Overall traction contained the on-road and off-road traction values, overall speed contained the ground, water, anti-gravity, and air speed values, and overall handling contained the ground, water, anti-gravity, and air handling values. The mini-turbo, acceleration, and speed score values remained the same.
```{r Generalization of Top Selections, message=FALSE, warning=FALSE}
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
```

Since specific metrics were condensed into general components, I also removed columns that contained those specific metrics to simplify each data frame.
```{r Simplification of Top Selections, message=FALSE, warning=FALSE}
top_karts <- subset(top_karts, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))

top_heavy_drivers <- subset(top_heavy_drivers, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))

top_medium_drivers <- subset(top_medium_drivers, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))

top_light_drivers <- subset(top_light_drivers, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))

top_gliders <- subset(top_gliders, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))

top_tires <- subset(top_tires, select = -c(on_road_traction, off_road_traction, ground_speed, water_speed, anti_gravity_speed, air_speed, ground_handling, water_handling, anti_gravity_handling, air_handling))
```

I also removed the "weight class" column from each of the "top drivers" data frames to keep all data frames consistent with their columns.
```{r Weight Class Removal, message=FALSE, warning=FALSE}
top_heavy_drivers <- subset(top_heavy_drivers, select = -c(weight_class))
top_medium_drivers <- subset(top_medium_drivers, select = -c(weight_class))
top_light_drivers <- subset(top_light_drivers, select = -c(weight_class))
```

<br>

Now, all data frames contain consistent columns:
```{r Overview of Plots, message=FALSE, warning=FALSE, echo=FALSE}
top_karts
top_heavy_drivers
top_medium_drivers
top_light_drivers
top_gliders
top_tires
```

<br><br>

### Visualizing Who and What is the "Fastest"

**NOTE:** Each plot shown is intended to show the distribution of component values between the karts/drivers/gliders/tires. The karts/drivers/gliders/tires included in each "all selections" plot are distribution comparisons of all selections together. The karts/drivers/gliders/tires included in each "top selections" plot are the result of having the same maximum total speed score. The "Weight" attribute is included in each plot to aid in decision-making when it comes to selecting which kart/driver/glider/tire to use. As mentioned earlier, weight was subtracted from the speed score and these are the top selections as a result of that calculation. The speed score can be found from each plot by adding each attribute value together (disregarding the weight attribute), and then subtracting the weight value.

<br>

#### Breakdown of the "Fastest" Karts  

The plot below shows the breakdown of the attributes for all kart bodies in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440447707' style='position: relative'><noscript><a href='#'><img alt='Dashboard 1 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllKarts&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllKarts&#47;Dashboard1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllKarts&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

The kart bodies with the highest score were extracted for a more focused comparison. The plot below shows that the kart bodies with the same maximum total speed scores are the Flame Rider, Standard Bike, W 25 Silver Arrow, and the Wild Wiggler. Each of these kart bodies shared the maximum total speed score of 42 as well as a weight value of 1. Based on the distribution of each component's value, each of these bodies has the same distribution; the weight, acceleration, mini turbo, overall traction, overall speed, and overall handling are the same for each of these kart bodies.

<br>

```{r Breakdown of Top Karts, message=FALSE, warning=FALSE}
top_karts <- data.frame(top_karts)
new_top_karts <- melt(subset(top_karts, select = -c(speed_score)), id.vars = "body")
top_karts_plot <- ggplot(new_top_karts, aes(x = body, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Kart Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Karts", x = "Body", y = "Total Speed Score (with Weight)", fill = "Kart Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 45), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
```

![Top Karts Plot](https://user-images.githubusercontent.com/56329600/176249019-167424e3-04b8-4a25-9f88-e4cc772acd05.png)

<br>

### Breakdown of the "Fastest" Drivers

The following plot shows the breakdown of all the drivers categorized by their respective weight-classes. It is a general overview of all the drivers for comparison altogether and for comparison within each weight-class in perspective. The following sections will focus on the scope of each weight-class separately.

<div class='tableauPlaceholder' id='viz1656441684715' style='position: relative'><noscript><a href='#'><img alt='All Drivers Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofDrivers&#47;AllDriversDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofDrivers&#47;AllDriversDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofDrivers&#47;AllDriversDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

#### Breakdown of the "Fastest" Heavy Drivers  

The plot below shows the breakdown of the attributes for all heavy drivers in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656439847887' style='position: relative'><noscript><a href='#'><img alt='Heavy Drivers Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllHeavyDrivers&#47;HeavyDriversDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllHeavyDrivers&#47;HeavyDriversDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllHeavyDrivers&#47;HeavyDriversDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

<br>

The heavy drivers with the highest score were extracted for a more focused comparison. The drivers in the heavy-weight class with the top speed scores are Donkey Kong, King Boo, Link, Rosalina, Roy, and Waluigi. Each of these heavy-weight drivers shared the maximum total speed score of 48. Of the 6 top heavy-weight drivers, Donkey Kong, Roy, and Waluigi have the same distribution of attribute values, while King Boo, Link, and Rosalina share the same distribution. Half of the top heavy-weight drivers contain a higher weight and overall speed, while the other half has a higher mini turbo, overall traction, and overall handling. While the plot below shows two different distributions of attribute values, the total speed score (minus the weight attribute) is the same for all 6 of these drivers.

<br>

```{r Breakdown of Top Heavy Drivers, message=FALSE, warning=FALSE}
top_heavy_drivers <- data.frame(top_heavy_drivers)
new_top_heavy_drivers <- melt(subset(top_heavy_drivers, select = -c(speed_score)), id.vars = "driver")
top_heavy_drivers_plot <- ggplot(new_top_heavy_drivers, aes(x = driver, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Driver Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Heavy Drivers", x = "Driver", y = "Total Speed Score (with Weight)", fill = "Driver Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 65), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
```

![Top Heavy Drivers Plot](https://user-images.githubusercontent.com/56329600/176249076-c97148a5-a7ff-4fea-9142-b9280b9a8e97.png)

<br>

#### Breakdown of the "Fastest" Medium Drivers  

The plot below shows the breakdown of the attributes for all medium drivers in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656439967456' style='position: relative'><noscript><a href='#'><img alt='Medium Drivers Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllMediumDrivers&#47;MediumDriversDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllMediumDrivers&#47;MediumDriversDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllMediumDrivers&#47;MediumDriversDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

<br>

The medium drivers with the highest score were extracted for a more focused comparison. The drivers in the medium-weight class with the highest speed scores are Cat Peach, Inkling Boy, Inkling Girl, Tanooki Mario, Village (Female), and Villager (Male). Each of these medium-weight drivers shares the maximum total speed score of 49. Of the 6 top medium-weight drivers, Cat Peach, Inkling Girl, and Villager (Female) share the same distribution of attribute values, while Inkling Boy, Tanooki Mario, and Villager (Male) share the same distribution. Based on the plot below, half the drivers have a higher acceleration and overall handling while the other half of drivers have higher weight, overall traction, and overall speed.

<br>

```{r Breakdown of Top Medium Drivers, message=FALSE, warning=FALSE}
top_medium_drivers <- data.frame(top_medium_drivers)
new_top_medium_drivers <- melt(subset(top_medium_drivers, select = -c(speed_score)), id.vars = "driver")
top_medium_drivers_plot <- ggplot(new_top_medium_drivers, aes(x = driver, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Driver Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Medium Drivers", x = "Driver", y = "Total Speed Score (with Weight)", fill = "Driver Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
```

![Top Medium Drivers Plot](https://user-images.githubusercontent.com/56329600/176249134-af8a6d4f-f4d6-424a-847b-bdb9a5306189.png)

<br>

#### Breakdown of the "Fastest" Light Drivers  

The plot below shows the breakdown of the attributes for all light drivers in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440028039' style='position: relative'><noscript><a href='#'><img alt='Light Drivers Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllLightDrivers&#47;LightDriversDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllLightDrivers&#47;LightDriversDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllLightDrivers&#47;LightDriversDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

<br>

The light drivers with the highest score were extracted for a more focused comparison. For the top light-weight drivers, there were only two drivers that shared the same maximum speed score of 57 and a weight value of 0. Based on the plot below, both Baby Daisy and Baby Peach share the same distribution of attribute values.

<br>

```{r Breakdown of Top Light Drivers, message=FALSE, warning=FALSE}
top_light_drivers <- data.frame(top_light_drivers)
new_top_light_drivers <- melt(subset(top_light_drivers, select = -c(speed_score)), id.vars = "driver")
top_light_drivers_plot <- ggplot(new_top_light_drivers, aes(x = driver, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Driver Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Light Drivers", x = "Driver", y = "Total Speed Score (with Weight)", fill = "Driver Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 60), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
```

![Top Light Drivers Plot](https://user-images.githubusercontent.com/56329600/176249167-fd32e051-f658-425a-bf78-cff17d86d1e4.png)

<br>

#### Breakdown of the "Fastest" Gliders 

The plot below shows the breakdown of the attributes for all gliders in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440102113' style='position: relative'><noscript><a href='#'><img alt='Dashboard 1 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllGliders&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllGliders&#47;Dashboard1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllGliders&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

The gliders with the highest score were extracted for a more focused comparison. The top four gliders with the maximum speed score are Cloud Glider, Flower Glider, Paper Glider, and Parachute. Each of these four gliders share the same maximum speed score of 13 and a weight value of 0. These gliders also share the same distribution of attribute values.

<br>

```{r Breakdown of Top Gliders, message=FALSE, warning=FALSE}
top_gliders <- data.frame(top_gliders)
new_top_gliders <- melt(subset(top_gliders, select = -c(speed_score)), id.vars = "glider")
top_gliders_plot <- ggplot(new_top_gliders, aes(x = glider, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  scale_fill_discrete(name = "Glider Attribute", labels = c("Weight", "Acceleration", "Mini Turbo", "Overall Traction", "Overall Speed", "Overall Handling")) +
  labs(title = "Breakdown of Attributes for Top Gliders", x = "Glider", y = "Total Speed Score (with Weight)", fill = "Glider Attribute") +
  geom_text(aes(label = value), size = 3, position = position_stack(vjust = 0.5)) +
  scale_y_continuous(limits = c(0, 14), expand = c(0, 0)) +
  theme(axis.title.y = element_text(margin = margin(r = 8)), axis.title.x = element_text(margin = margin(t = 8)), plot.title = element_text(margin = margin(b = 8)),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
```
![Top Gliders Plot](https://user-images.githubusercontent.com/56329600/176249218-53ec91e0-29b8-4875-b3e7-6045a78405cf.png)

<br>

#### Breakdown of the "Fastest" Tires  

The plot below shows the breakdown of the attributes for all gliders in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440151240' style='position: relative'><noscript><a href='#'><img alt='Dashboard 1 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllTires&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllTires&#47;Dashboard1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllTires&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

The tires with the highest score were extracted for a more focused comparison. There were only two tires that shared the maximum speed score value: Azure Roller and Roller. Both tires also share the same maximum total speed score of 38 and a weight value of 0. They also share the same distribution of attribute values as one another.

<br>

```{r Breakdown of Top Tires, message=FALSE, warning=FALSE}
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
```

![Top Tires Plot](https://user-images.githubusercontent.com/56329600/176249257-35cbbc06-e803-4e90-9dc6-2313077f40c9.png)

<br><br>

## Conclusion

**DISCLAIMER:** The result of this analysis is not intended to describe what combination of selections will guarantee a player to win. Winning a race includes personal skill or play style and events that occur during a race such as when and what items are used and whether or not errors have been made during a race (i.e. falling off the course).  

Based on this analysis, there are several options to choose from when it comes to selecting the "fastest" kart, driver, glider, and tire. Every option shown in each plot resulted in the same speed score respectively. For selections that share the same distribution, the choice of which to choose from narrows down to the player's *preference of looks*. 

<br>

The **"fastest" kart bodies** came down to the *Flame Rider*, *Standard Bike*, *W 25 Silver Arrow*, and the *Wild Wiggler*. Each of these 4 kart bodies shared a speed score of **42** as well as the same distribution of attribute values.   

The **"fastest" heavy-weight drivers** included *Donkey Kong*, *King Boo*, *Link*, *Rosalina*, *Roy*, and *Waluigi*. Although all 6 of these heavy-weight drivers share the same speed score of **48**, there are 2 differing distributions that each half of the drivers share. The optimal choice ultimately depends on the distribution of attribute values that best suits the player's personal play style.  

The **"fastest" medium-weight drivers** were *Cat Peach*, *Inkling Boy*, *Inkling Girl*, *Tanooki Mario*, *Villager (Female)*, and *Villager (Male)*. All 6 of these medium-weight drivers share the same speed score of **49**, however, half of the drivers share the same distribution of attribute values while the other half of drivers share a different distribution. The choice of who to select narrows down which driver has a distribution that, again, best suits the player's play style.  

The **"fastest" light-weight drivers** resulted in *Baby Daisy* and *Baby Peach*. Both of these drivers have the same total speed score of **57** and share the same distribution of attribute values.

The **"fastest" gliders** include the *Cloud Glider*, *Flower Glider*, *Paper Glider*, and the *Parachute*. These 4 gliders share the same total speed score of **13** and the same distribution. 

The 2 choices in the **"fastest" tires**, the *Azure Roller* and the *Roller*, also share the same total speed score of **38** as well as the same distribution of attribute values.  

<br>

The purpose of this analysis was to reveal who and what is structurally the "fastest". Many of the choices with a different distribution depend on the player's play style while choices with the same distribution depend on their preference of looks.

<br><br><br>
[**Back to top**](#mario-kart-8-deluxe-analysis-who-and-what-is-the-fastest)
<br>
