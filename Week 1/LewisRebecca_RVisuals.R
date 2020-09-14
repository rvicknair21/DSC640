
datapath = 'C:/Users/rvick/OneDrive/Bellevue/DSC 640/Week 1/ex1-2'

HDFile = file.path(datapath, 'hotdog-places_csv.csv')

hotdog <- read.csv(HDFile, header = TRUE)

head(hotdog)

#colnames(hotdog) <- c("Place", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010")

head(hotdog)

library(tidyr)

hotdog_long <- gather(hotdog, year, quantity, X2000:X2010)

hotdog_long$year <- gsub("[a-zA-Z ]", "", hotdog_long$year)

hotdog_long

library(dplyr)
library(ggplot2)
library(reshape)

##barplot
hotdog_by_year <- hotdog_long %>% group_by(year) %>% mutate(total = sum(quantity, year))
table(hotdog_by_year)

ggplot(hotdog_by_year, aes(x=year, y=total)) +
  geom_bar(stat = 'identity', fill="cornflower blue") +
  labs(title = 'Hot Dogs Consumed by Year', ylab('Count')) +
  theme(axis.title.x = element_blank())



hotdog_place_year <- hotdog_long %>% group_by(year) %>% mutate(pct= quantity / sum(quantity))

##stacked bar chart
ggplot(hotdog_place_year, aes(fill=Place, x=year, y=quantity)) +
  geom_bar(position="stack", stat = 'identity') +
  geom_text(aes(label = scales::percent(pct)), position = position_stack(vjust= .5), color="white") +
  labs(title = 'Hot Dogs Consumed by Year and Place', ylab('Count')) +
  theme(axis.title.x = element_blank())


#Pie Chart
#Distribution of first second and third place hotdogs consumed
hotdog_place <- hotdog_long %>% group_by(Place) %>% 
  summarise(total = sum(quantity)) 

hotdog_place$total <- as.integer(hotdog_place$total)

#hotdog_place <- hotdog_place %>% spread(Place, total)

hotdog_place

slices <- hotdog_place$total
colors <- c('cornflower blue', 'navy', 'gray')
labels <- paste0(hotdog_place$Place, " Place\n ", hotdog_place$total, ' Hot Dogs')



pie(slices, main="Distribution of Hot Dogs Consumed by Place", labels = labels)

#pie(table(hotdog_place$total), 
 #     main = "Distribution of Hot Dogs Consumed by Place", labels = hotdog_place$total,
  #  legend(.9, .1, legend = hotdog_place$Place, cex = 0.7))


#donut chart

# Compute percentages
hotdog_place$fraction = hotdog_place$total / sum(hotdog_place$total)

# Compute the cumulative percentages (top of each rectangle)
hotdog_place$ymax = cumsum(hotdog_place$fraction)

# Compute the bottom of each rectangle
hotdog_place$ymin = c(0, head(hotdog_place$ymax, n=-1))

# Compute label position
hotdog_place$labelPosition <- (hotdog_place$ymax + hotdog_place$ymin) / 2

# Compute a good label
hotdog_place$label <- paste0(hotdog_place$Place, " Place\n ", hotdog_place$total, ' Hot Dogs')

# Make the plot
ggplot(hotdog_place, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=Place)) +
  geom_rect() +
  geom_label(x=2, aes(y=labelPosition, label=label), size=4, color='white') +
  coord_polar(theta="y") + # Try to remove that to understand how the chart is built initially
  xlim(c(-1, 4)) + # Try to remove that to see how to make a pie chart
  labs(title='Distribution of Hot Dogs Consumed by Place') +
  theme_void() + 
  theme(legend.position = "none", plot.title = element_text(hjust = 0.5))
