# Mario Kart 8 Deluxe Analysis: Who and What is the Fastest?

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
    * [Analyze the Effect of Weight on Overall Speed](#analyze-the-effect-of-weight-on-overall-speed)  
    * [Visualizing Who and What is the "Fastest"](#visualizing-who-and-what-is-the-fastest)
        * [Breakdown of the "Fastest" Karts](#breakdown-of-the-fastest-karts)
        * [Breakdown of the "Fastest Drivers](#breakdown-of-the-fastest-drivers)
          * [Breakdown of the "Fastest" Heavy Drivers](#breakdown-of-the-fastest-heavy-drivers) 
          * [Breakdown of the "Fastest" Medium Drivers](#breakdown-of-the-fastest-medium-drivers) 
          * [Breakdown of the "Fastest" Light Drivers](#breakdown-of-the-fastest-light-drivers)
        * [Breakdown of the "Fastest Gliders](#breakdown-of-the-fastest-gliders)
        * [Breakdown of the "Fastest Tires](#breakdown-of-the-fastest-tires)
<br><br>
* [**Rankings for Top-Scoring Selections**](#rankings-for-top-scoring-selections)
    * [Top 3 Scores for Karts](#top-3-scores-for-karts)
    * [Top 3 Scores for Drivers (per Weight-Class)](#top-3-scores-for-drivers-per-weight-class)
        * [Light-Weight Drivers](#light-weight-drivers)
        * [Medium-Weight Drivers](#medium-weight-drivers)
        * [Heavy-Weight Drivers](#heavy-weight-drivers)
    * [Top 3 Scores for Gliders](#top-3-scores-for-gliders)
    * [Top 3 Scores for Tires](#top-3-scores-for-tires)
<br><br>
* [**Conclusion**](#conclusion)

<br><br>

## What Makes a Character, Kart, Glider, or Tire Fast?

Each character, kart, glider, and tire is composed of several different factors that have an effect on how "fast" it is in a given race. All selections are composed of values for "weight", "acceleration", "on-road traction", "off-road traction", "mini turbo", "ground speed", "water speed", "anti-gravity speed", "air speed", "ground handling", "water handling", "anti-gravity handling", and "air handling".  

These values are not explicitly stated in the actual game, however, the values have been interpreted as a point-based system by a collective group of players from the [Mario Wiki](https://www.mariowiki.com/Mario_Kart_8_Deluxe) based on the selection's statistics scale provided by the game.
 
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

<br>

## How Do We Find the "Fastest" Combination of Character, Kart, Glider, and Tire?

### Analyze the Effect of Weight on Overall Speed
Based on the descriptions of different components of every selection, all components represented a clear positive contribution to overall speed except the "weight" component. If the game mimics real-world physics, weight should decrease overall speed. Based on the description of "weight" according to the [Mario Wiki](https://www.mariowiki.com/Mario_Kart_8_Deluxe), the effect of weight on overall speed was not described.
With this in mind, I decided to first analyze the effect of weight on overall speed before moving on.

<br>

![Effect of Weight Multi-Plot](https://user-images.githubusercontent.com/56329600/158035668-e1276657-719b-4873-9a0c-83880bf61d80.png)

<br>

Since each visualization showed that there was a negative trend between weight and each selection, it's clear that weight negatively impacts overall speed. With this finding, I subtracted the "weight" values from each "speed score".

<br>

### Visualizing Who and What is the "Fastest"

**NOTE:** Each plot shown is intended to show the distribution of component values between the karts/drivers/gliders/tires. The karts/drivers/gliders/tires included in each "all selections" plot are distribution comparisons of all selections together. The karts/drivers/gliders/tires included in each "top selections" plot are the result of having the same maximum total speed score. The "Weight" attribute is included in each plot to aid in decision-making when it comes to selecting which kart/driver/glider/tire to use. As mentioned earlier, weight was subtracted from the speed score and these are the top selections as a result of that calculation. The speed score can be found from each plot by adding each attribute value together (disregarding the weight attribute), and then subtracting the weight value.

<br>

#### Breakdown of the "Fastest" Karts  

The plot below shows the breakdown of the attributes for all kart bodies in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440447707' style='position: relative'><noscript><a href='#'><img alt='Dashboard 1 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllKarts&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllKarts&#47;Dashboard1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllKarts&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

The kart bodies with the highest score were extracted for a more focused comparison. The plot below shows that the kart bodies with the same maximum total speed scores are the Flame Rider, Standard Bike, W 25 Silver Arrow, and the Wild Wiggler. Each of these kart bodies shared the maximum total speed score of 42 as well as a weight value of 1. Based on the distribution of each component's value, each of these bodies has the same distribution; the weight, acceleration, mini turbo, overall traction, overall speed, and overall handling are the same for each of these kart bodies.

<br>

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

![Top Heavy Drivers Plot](https://user-images.githubusercontent.com/56329600/176249076-c97148a5-a7ff-4fea-9142-b9280b9a8e97.png)

<br>

#### Breakdown of the "Fastest" Medium Drivers  

The plot below shows the breakdown of the attributes for all medium drivers in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656439967456' style='position: relative'><noscript><a href='#'><img alt='Medium Drivers Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllMediumDrivers&#47;MediumDriversDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllMediumDrivers&#47;MediumDriversDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllMediumDrivers&#47;MediumDriversDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

<br>

The medium drivers with the highest score were extracted for a more focused comparison. The drivers in the medium-weight class with the highest speed scores are Cat Peach, Inkling Boy, Inkling Girl, Tanooki Mario, Village (Female), and Villager (Male). Each of these medium-weight drivers shares the maximum total speed score of 49. Of the 6 top medium-weight drivers, Cat Peach, Inkling Girl, and Villager (Female) share the same distribution of attribute values, while Inkling Boy, Tanooki Mario, and Villager (Male) share the same distribution. Based on the plot below, half the drivers have a higher acceleration and overall handling while the other half of drivers have higher weight, overall traction, and overall speed.

<br>

![Top Medium Drivers Plot](https://user-images.githubusercontent.com/56329600/176249134-af8a6d4f-f4d6-424a-847b-bdb9a5306189.png)

<br>

#### Breakdown of the "Fastest" Light Drivers  

The plot below shows the breakdown of the attributes for all light drivers in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440028039' style='position: relative'><noscript><a href='#'><img alt='Light Drivers Dashboard ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllLightDrivers&#47;LightDriversDashboard&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllLightDrivers&#47;LightDriversDashboard' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllLightDrivers&#47;LightDriversDashboard&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /></object></div>

<br>

The light drivers with the highest score were extracted for a more focused comparison. For the top light-weight drivers, there were only two drivers that shared the same maximum speed score of 57 and a weight value of 0. Based on the plot below, both Baby Daisy and Baby Peach share the same distribution of attribute values.

<br>

![Top Light Drivers Plot](https://user-images.githubusercontent.com/56329600/176249167-fd32e051-f658-425a-bf78-cff17d86d1e4.png)

<br>

#### Breakdown of the "Fastest" Gliders 

The plot below shows the breakdown of the attributes for all gliders in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440102113' style='position: relative'><noscript><a href='#'><img alt='Dashboard 1 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllGliders&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllGliders&#47;Dashboard1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllGliders&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

The gliders with the highest score were extracted for a more focused comparison. The top four gliders with the maximum speed score are Cloud Glider, Flower Glider, Paper Glider, and Parachute. Each of these four gliders share the same maximum speed score of 13 and a weight value of 0. These gliders also share the same distribution of attribute values.

<br>

![Top Gliders Plot](https://user-images.githubusercontent.com/56329600/176249218-53ec91e0-29b8-4875-b3e7-6045a78405cf.png)

<br>

#### Breakdown of the "Fastest" Tires  

The plot below shows the breakdown of the attributes for all gliders in the game. The reference line on each bar indicates the total speed score as a result of the calculation mentioned earlier. This visualization was created in Tableau using the data frames created in R.

<div class='tableauPlaceholder' id='viz1656440151240' style='position: relative'><noscript><a href='#'><img alt='Dashboard 1 ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllTires&#47;Dashboard1&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='BreakdownofAllTires&#47;Dashboard1' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Br&#47;BreakdownofAllTires&#47;Dashboard1&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='language' value='en-US' /><param name='filter' value='publish=yes' /></object></div>

<br>

The tires with the highest score were extracted for a more focused comparison. There were only two tires that shared the maximum speed score value: Azure Roller and Roller. Both tires also share the same maximum total speed score of 38 and a weight value of 0. They also share the same distribution of attribute values as one another.

<br>

![Top Tires Plot](https://user-images.githubusercontent.com/56329600/176249257-35cbbc06-e803-4e90-9dc6-2313077f40c9.png)

<br><br>

## Rankings for Top-Scoring Selections

### Top 3 Scores for Karts
| **Rank** | **Total Speed Score** | **Kart(s)** |
|:--------:|:---------------------:|:--------:|
|  **1**   |        **42**         | ![1 flame_rider](https://user-images.githubusercontent.com/56329600/176318498-45168815-45d9-46ca-ae92-30ca400fe48d.png) ![1 standard_bike](https://user-images.githubusercontent.com/56329600/176318777-85b3269b-7127-4230-be3a-0c7ebc2c860b.png) ![1 W25_silver_arrow](https://user-images.githubusercontent.com/56329600/176318782-0eff26d1-71e7-47a4-940e-0065ace26e1c.png) ![1 wild_wiggler](https://user-images.githubusercontent.com/56329600/176318793-b7934f7a-da25-4f97-885a-6dbffe448e53.png) |
|  **2**   |        **41**         | ![2 biddybuggy](https://user-images.githubusercontent.com/56329600/176318934-befd78af-5751-49de-99c8-22795dff66ef.png) ![2 mrscooty](https://user-images.githubusercontent.com/56329600/176318937-9b2fe557-ecb0-4e29-8d28-221196192077.png) |
|  **3**   |        **40**         | ![3 landship](https://user-images.githubusercontent.com/56329600/176318979-0a9aebc6-2d2c-44dc-b54d-7c7d300aa848.png) ![3 streetle](https://user-images.githubusercontent.com/56329600/176318986-e8f700dd-1aca-4c00-a012-a977205bb114.png) |

<br>

### Top 3 Scores for Drivers (per Weight-Class)

#### Light-Weight Drivers
| **Rank** | **Total Speed Score** | **Driver(s)** |
|:--------:|:---------------------:|:--------:|
|  **1**   |        **57**         | ![1 baby_daisy](https://user-images.githubusercontent.com/56329600/176320073-a8e84954-9868-4281-b9ec-a178b6d1b147.png) ![1 baby_peach](https://user-images.githubusercontent.com/56329600/176320084-373ac6f1-34f6-4cf9-9be6-24c26ebe2932.png) |
|  **2**   |        **53**         | ![2 baby_rosalina](https://user-images.githubusercontent.com/56329600/176320094-0641e314-e18b-4967-a850-b012808bc14a.png) ![2 lemmy](https://user-images.githubusercontent.com/56329600/176320102-56b5e554-657a-4342-bd41-137b773e95e7.png) |
|  **3**   |        **52**         | ![3 bowser_jr](https://user-images.githubusercontent.com/56329600/176320114-9a93153e-2554-4c72-944f-dd5cdb54fa53.png) ![3 koopa_troopa](https://user-images.githubusercontent.com/56329600/176320124-a5df7acd-7f92-4450-83d9-45181cd8fa5b.png) ![3 lakitu](https://user-images.githubusercontent.com/56329600/176320130-652d7d3f-7a9e-48f7-9b56-b315eccde08e.png) |

<br>

#### Medium-Weight Drivers
| **Rank** | **Total Speed Score** | **Driver(s)** |
|:--------:|:---------------------:|:--------:|
|  **1**   |        **49**         | ![1 cat_peach](https://user-images.githubusercontent.com/56329600/176319785-2fe25784-c388-4725-8885-0a07de9b641a.png) ![1 inkling_boy](https://user-images.githubusercontent.com/56329600/176319800-fe8cd766-c283-45af-a065-370d6336dd5e.png) ![1 inkling_girl](https://user-images.githubusercontent.com/56329600/176319808-e618519a-2158-4af6-8f23-8893631a6d82.png) ![1 tanooki_mario](https://user-images.githubusercontent.com/56329600/176319817-ca44f894-a9f8-4638-8d08-957b9f27bbfb.png) ![1 villager_female](https://user-images.githubusercontent.com/56329600/176319829-5a7c927a-becd-49e1-bd7d-bc8853b6180b.png) ![1 villager_male](https://user-images.githubusercontent.com/56329600/176319834-db25a7ef-7805-49bd-afba-0f60b0424156.png) |
|  **2**   |        **48**         | ![2 daisy](https://user-images.githubusercontent.com/56329600/176319843-5724c1fe-5a02-4f3a-a38f-682c2d6c1582.png) ![2 iggy](https://user-images.githubusercontent.com/56329600/176319848-b928089f-0b5b-42f6-b776-3e99d345c66b.png) ![2 luigi](https://user-images.githubusercontent.com/56329600/176319863-ea70d7e5-d4ba-47ca-8dc1-f3261aea7888.png) ![2 peach](https://user-images.githubusercontent.com/56329600/176319876-b95d230a-c301-4d92-8755-0f1704c5d605.png) ![2 yoshi](https://user-images.githubusercontent.com/56329600/176319881-43a20b91-5fab-45d2-ac42-07f175404988.png) |
|  **3**   |        **44**         | ![3 ludwig](https://user-images.githubusercontent.com/56329600/176319890-2f1c7743-7500-42c5-ada2-a3b42f4a0bba.png) ![3 mario](https://user-images.githubusercontent.com/56329600/176319895-672ea55a-7760-4c1e-af5a-0a5f9c8e2c63.png) ![3 mii](https://user-images.githubusercontent.com/56329600/176319900-89ee9064-50b6-4a8a-8840-da4d6da1a63f.png) |

<br>

#### Heavy-Weight Drivers
| **Rank** | **Total Speed Score** | **Driver(s)** |
|:--------:|:---------------------:|:--------:|
|  **1**   |        **48**         | ![1 DK](https://user-images.githubusercontent.com/56329600/176319309-ed957d50-a7b0-4e21-8a0a-19522d3ac3d3.png) ![1 king_boo](https://user-images.githubusercontent.com/56329600/176319317-4b467850-284e-41bf-b0b1-17cbc7d0f177.png) ![1 link](https://user-images.githubusercontent.com/56329600/176319325-619ed3b0-237e-40bf-8cc2-5348526ca42b.png) ![1 rosalina](https://user-images.githubusercontent.com/56329600/176319333-02847fa2-be0a-4367-9da1-1c0fa1c9ef3c.png) ![1 roy](https://user-images.githubusercontent.com/56329600/176319342-ce9399e4-a906-4cfc-8e3a-e9547356f63a.png) ![1 waluigi](https://user-images.githubusercontent.com/56329600/176319346-f45ad16f-1eb8-48b1-9441-60b31b026490.png) |
|  **2**   |        **45**         | ![2 gold_mario](https://user-images.githubusercontent.com/56329600/176319471-9367e343-da2e-465a-a5a6-67c2bd947147.png) ![2 metal_mario](https://user-images.githubusercontent.com/56329600/176319479-db140aba-9b98-4a26-b73b-2a38dd585965.png) ![2 pink_gold_peach](https://user-images.githubusercontent.com/56329600/176319487-dada9152-5225-42d7-a26f-71444e12de91.png) |
|  **3**   |        **41**         | ![3 dry_bowser](https://user-images.githubusercontent.com/56329600/176319524-61aa16fd-86ee-4d72-94e4-0ce433f3d468.png) ![3 wario](https://user-images.githubusercontent.com/56329600/176319532-1946a45d-df43-44c3-b057-8efdab11ea98.png) |

<br>

### Top 3 Scores for Gliders
| **Rank** | **Total Speed Score** | **Glider(s)** |
|:--------:|:---------------------:|:--------:|
|  **1**   |        **13**         | ![1 cloud_glider](https://user-images.githubusercontent.com/56329600/176320359-e049e4c5-4be7-40fc-ac0b-348b737cc07e.png) ![1 flower_glider](https://user-images.githubusercontent.com/56329600/176320370-bdb457dd-572e-48ee-920f-139652e19746.png) ![1 paper_parachute](https://user-images.githubusercontent.com/56329600/176320374-94796763-3766-4422-afed-1b1f8fa7023f.png) ![1 parachute](https://user-images.githubusercontent.com/56329600/176320378-7d7e6969-4941-4e2e-ba67-af29e5a0b0dc.png) |
|  **2**   |        **11**         | ![2 bowser_kite](https://user-images.githubusercontent.com/56329600/176320394-1bf025d3-c21f-4eba-a4f1-0f58d382f4e3.png) ![2 MKTV_parafoil](https://user-images.githubusercontent.com/56329600/176320401-fefe7cde-715c-4f28-bb64-ccf80a63cc14.png) ![2 parafoil](https://user-images.githubusercontent.com/56329600/176320412-4e2f2307-9bcd-4337-8f3a-ec54c7b35069.png) ![2 peach_parasol](https://user-images.githubusercontent.com/56329600/176320420-15a4f029-61f5-44d2-b426-f2f346bddf02.png) |
|  **3**   |        **10**         | ![3 hylian_kite](https://user-images.githubusercontent.com/56329600/176320432-f7edb7df-f2d1-4bda-bcef-fe8494f8c3cf.png) ![3 super_glider](https://user-images.githubusercontent.com/56329600/176320435-f193c157-7bea-4c6e-99a6-63210d6e7c3c.png) ![3 waddle_wing](https://user-images.githubusercontent.com/56329600/176320445-4e0904f8-fa96-4c9f-b273-c59ad790e6d2.png) |

<br>

### Top 3 Scores for Tires
| **Rank** | **Total Speed Score** | **Glider(s)** |
|:--------:|:---------------------:|:--------:|
|  **1**   |        **38**         | ![1 azure_roller](https://user-images.githubusercontent.com/56329600/176320573-188ddb12-85c4-47f4-a0c7-ebafe27f3270.png) ![1 roller](https://user-images.githubusercontent.com/56329600/176320579-5f121cae-baba-4cc2-b2aa-663d7d9c448a.png) |
|  **2**   |        **34**         | ![2 blue_standard](https://user-images.githubusercontent.com/56329600/176320590-af7a5122-3668-441f-a457-82740cb1cc1f.png) ![2 GLA](https://user-images.githubusercontent.com/56329600/176320599-6ded59b5-d24e-4847-ab67-e1314dd23fb0.png) ![2 standard](https://user-images.githubusercontent.com/56329600/176320609-cc9475e4-4abc-4d8f-ab86-9222c1b1a802.png) |
|  **3**   |        **33**         | ![3 button](https://user-images.githubusercontent.com/56329600/176320628-c4dc6ce4-3c59-4a90-83a5-174612d7f3bb.png) ![3 crimson_slim](https://user-images.githubusercontent.com/56329600/176320639-43f5bc1a-8f4e-4c31-ad17-291b1ba802b4.png) ![3 leaf](https://user-images.githubusercontent.com/56329600/176320642-36a30e5c-5805-4727-bde0-a7b2d9867f4a.png) ![3 slim](https://user-images.githubusercontent.com/56329600/176320646-1ba23f8f-33d7-47a3-9307-f806b9a08bc9.png) ![3 wood](https://user-images.githubusercontent.com/56329600/176320654-69571019-cf74-485e-b6ca-e51b358df8d7.png) |

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



<br><br><br><br>
