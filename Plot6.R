# Course 4: Exploratory Data Analysis Project 2

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

library(ggplot2)

# Question 6
# Compare emissions from motor vehicle sources in Baltimore City(fips == "24510") 
# with emissions from motor vehicle sources in Los Angeles County, California(fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

subsetNEI <- NEI[(NEI$fips == "24510"|NEI$fips == "06037") & NEI$type=="ON-ROAD", ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")+xlab("Year")+ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicles in Baltimore City, MD vs. Los Angeles, CA from 1999 to 2008')
print(g)
dev.off()