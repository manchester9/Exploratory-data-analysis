# Dwonload the file
if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile <- "./data/exdata-data-NEI_data.zip"
download.file(fileUrl, destfile)

# Read in the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
dim(NEI)
str(NEI)
dim(SCC)
str(SCC)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
library(dplyr)
ba_city_emissions <- filter(NEI, fips == "24510")
ba_emissions_by_type_year <- ba_city_emissions %>%
group_by(type, year) %>%
summarise(emission = sum(Emissions))

# Plotting using ggplot2
library(ggplot2)
png("plot3.png", 
	width=480, 
	height=480)
qplot(year, emission, 
	color = type, 
	data = ba_emissions_by_type_year,
	geom = "path") + 
	ggtitle(expression("Total Emissions from PM"[2.5]*" in Baltimore city by Type")) +
	xlab("Year") + 
	ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
dev.off()
