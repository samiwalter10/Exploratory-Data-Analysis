# Course 4: Exploratory Data Analysis Project 2

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}

library(ggplot2)

# Question 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Baltimore City, MD is fips =="24510"
# Identify motor vehicles by using type = "ON-ROAD"

subsetNEI <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]
agggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png", width = 840, height = 480)
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="Identity")+xlab("Year")+ylab(expression('Total PM'[2.5]*" Emissions"))+ggtitle('Total Emissions from Motor Vehicles in Baltimore City, MD from 1999 to 2008')
print(g)
dev.off()