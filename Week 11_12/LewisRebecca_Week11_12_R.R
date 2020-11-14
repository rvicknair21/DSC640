#Rebecca Lewis  
#DSC 640
#Histogram, Box Plot and Bullet Graph

#histogram

library(ggplot2)
library(dplyr)

edu <- read.csv("C:\\Users\\rvick\\OneDrive\\Bellevue\\DSC 640\\Week 11_12\\ex6-2\\education.csv",
                  header=TRUE)

head(edu)


edu <- edu %>% filter(state != 'United States')

head(edu)

str(edu)

ggplot(edu, aes(math)) + 
  geom_histogram(binwidth = 8, fill = 'cornflower blue', color='white') +
  labs(title="Histogram", subtitle = "Math Scores in the United States", x='Math Scores', y="# of Scores")



#Box Plot

library(tidyverse)
crime <- read.csv("C:\\Users\\rvick\\OneDrive\\Bellevue\\DSC 640\\Week 11_12\\ex6-2\\crimeratesbystate-formatted.csv",
          header=TRUE)

crime <- crime %>% filter(str_trim(state) != 'United States')

library(tidyr)

crime_long <- gather(crime, crimetype, stat, murder:motor_vehicle_theft, factor_key=TRUE)
crime_long

ggplot(crime_long, aes(crimetype, stat)) + 
  geom_boxplot() +
  labs (title = "Boxplot", subtitle='U.s. Crime Rates', x='Crime', y='Value') +
  scale_x_discrete(labels=c('Murder', 'Forcible Rape', 'Robbery', 'Aggravated Assault', 'Burglary', 'Larceny Theft', 'Motor Vehicl Theft'))


#Bullet Graph
library(forcats)

gs_edu <- edu %>% 
  filter(state %in% c('Texas', 'Louisiana', 'Mississippi', 'Alabama', 'Georgia', 'Florida')) 

gs_edu <- arrange(gs_edu, state)

gs_edu %>% 
  ggplot(aes(math+reading+writing, state))  + 
  geom_bar(stat='identity', fill="grey", width=0.5) +
  geom_bar(stat='identity',aes(math, state), width=0.2) +
  geom_point(stat='identity',aes(math+reading+writing, state), colour="red") + 
  labs(title='Bullet Graph', subtitle = 'Gulf South States: Math Portion of Total SAT Score', 
       x = 'Total Score', y='State')


