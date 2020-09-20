##Rebecca Lewis
##DSC 640 - Weeks 3 & 4

library(readxl)


population <- read_excel('ex2-2/world-population.xlsm')


#line chart

plot(type="l", population$Year, population$Population, xlab='Year',
     ylab='Population (in Billions)', 
     main='Growth in World Population: 1960-2009', col='blue', lwd=5,
     xaxt="n", yaxt="n", ylim=c(3000000000,8000000000), xlim=c(1959, 2009))
ytick<-seq(3000000000, 8000000000, by=1000000000)
axis(2, at=ytick, labels=c(3,4,5,6,7,8))
xtick<-seq(1960, 2010, by=5)
axis(1, at=xtick, labels=c(1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010))

#step chart

plot(type="s", population$Year, population$Population, xlab='Year',
     ylab='Population (in Billions)', 
     main='Growth in World Population: 1960-2009', col='blue', lwd=5,
     xaxt="n", yaxt="n", ylim=c(3000000000,8000000000), xlim=c(1959, 2009))
ytick<-seq(3000000000, 8000000000, by=1000000000)
axis(2, at=ytick, labels=c(3,4,5,6,7,8))
xtick<-seq(1960, 2010, by=5)
axis(1, at=xtick, labels=c(1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010))