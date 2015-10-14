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

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 
library(dplyr)
motor_vehicle_filter <- filter(SCC, grepl("On-Road", EI.Sector))
ba_motor_vehicle_emissions <- filter(NEI, fips == "24510" & NEI$SCC %in% motor_vehicle_filter$SCC)

ba_motor_vehicle_emissions_by_year <- ba_motor_vehicle_emissions %>%
group_by(year) %>%
summarise(emission = sum(Emissions))

# Plotting using ggplot2
library(ggplot2)
png("plot5.png", 
	width=480, 
	height=480)
qplot(year, emission, 
	data = ba_motor_vehicle_emissions_by_year,
	geom = "line") + 
    ggtitle(expression("Total Emissions from PM "[2.5]*" from motor vehicles in Baltimore city")) +
    xlab("Year") + 
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
dev.off()
