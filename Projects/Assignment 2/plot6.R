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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?
library(dplyr)
motor_vehicle_filter <- filter(SCC, grepl("On-Road", EI.Sector))

# Baltimore motor vehicle emissions by year
ba_motor_vehicle_emissions <- filter(NEI, fips == "24510" & NEI$SCC %in% motor_vehicle_filter$SCC)
ba_motor_vehicle_emissions_by_year <- ba_motor_vehicle_emissions %>%
group_by(year) %>%
summarise(emission = sum(Emissions))
names(ba_motor_vehicle_emissions_by_year) = c("year", "ba_emission")

# LA motor vehicle emissions by year
la_motor_vehicle_emissions <- filter(NEI, fips == "06037" & NEI$SCC %in% motor_vehicle_filter$SCC)
la_motor_vehicle_emissions_by_year <- la_motor_vehicle_emissions %>%
group_by(year) %>%
summarise(emission = sum(Emissions))
names(la_motor_vehicle_emissions_by_year) = c("year", "la_emission")

# Merge the baltimore & la datasets
comp_table <- left_join(ba_motor_vehicle_emissions_by_year, la_motor_vehicle_emissions_by_year, by = "year")

# Reshape from wide to long
library(tidyr)
final_data <- gather(comp_table, city, emission, ba_emission:la_emission)

# Plotting using ggplot2
library(ggplot2)
png("plot6.png", 
	width=480, 
	height=480)
qplot(year, emission, 
	data = final_data,
	geom = "line",
	color = city) + 
    ggtitle(expression("Total Emissions from PM "[2.5]*" from motor vehicles in Baltimore & LA cities")) +
    xlab("Year") + 
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)")) + 
    facet_wrap(~ city, scales = "free") + 
    theme(legend.position = "none")
dev.off()