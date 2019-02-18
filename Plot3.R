# Course 4: Exploratory Data Analysis Project 2

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)

# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# Which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot to answer this question.

# Baltimore City, MD is fips =="24510"
subsetNEI <- subset(NEI, fips == "24510")

aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)

png('plot3.png', width = 640, height = 480)
g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
g <- g+geom_line()+xlab("Year")+ylab(expression('Total PM'[2.5]*' Emissions'))+ggtitle('Baltimore City Total Emissions by Year')
print(g)
dev.off()