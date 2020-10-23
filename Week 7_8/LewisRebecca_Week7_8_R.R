#Rebecca Lewis
#DSC 640


crime <- read.csv(file = 'C:/Users/rvick/OneDrive/Bellevue/DSC 640/Week 7_8/ex4-2/crimerates-by-state-2005.csv', header=TRUE)



crime <- crime[crime$state != 'District of Columbia',]
crime <- crime[crime$state != 'United States',]

head(crime)

#scatter plot

x <- crime$burglary
y <- crime$aggravated_assault

plot(x, y, xlim=c(0,1200), ylim=c(0,700), 
     main = 'Correlation between Burglaries and Aggravated Assaults in the U.S.', 
     xlab = '# of Burglaries', ylab='# of Agg. Assaults')

#bubble chart
radius = sqrt(crime$population / pi)
symbols(x, y, xlim=c(0,1200), ylim=c(0,700), circles = radius, inches = .25, fg="white", bg="cornflower blue", 
        xlab='# of Burglaries', ylab="# of Agg. Assault", main = 'Correlation between Burglaries and Aggravated Assaults in the U.S.')
text(x, y, crime$state, cex=.6)

#density plot
dens_burglary = density(crime$burglary)
plot(dens_burglary, main = 'Burglary Distribution Among Individual States', 
     xlab = '# of Burglaries')
