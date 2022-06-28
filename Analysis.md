# Mario Kart 8 Deluxe Analysis: Who and What is the Fastest?

### Lexi Diep

### 12/30/2021

<br>

There are many combinations of karts, drivers, gliders, and tires to select from when playing Mario Kart 8 Deluxe, but which combination of these options are structurally the "fastest"? The drivers will be categorized into different weight classes and each driver, kart, glider, and tire is going to be broken down into their core components to analyze who and what is the "fastest" combination. The result of the analysis will provide helpful insight to aid players in their decision when selecting their lineup.

<br>

**DISCLAIMER:** All data used in this analysis can be found on [Kaggle](https://www.kaggle.com/marlowspringmeier/mario-kart-8-deluxe-ingame-statistics). Some minor changes were made in Microsoft Excel while some visualizations were created using Tableau; a majority of this analysis was performed in R.

<br>

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

### Analyze the effect of weight on overall speed
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
