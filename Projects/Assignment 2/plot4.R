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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(dplyr)
coal_filter <- filter(SCC, grepl("Coal", EI.Sector) | grepl("Coal", Short.Name))

# Subsetting the emissions data
coal_emissions <- filter(NEI, NEI$SCC %in% coal_filter$SCC)

coal_emissions_year <- coal_emissions %>%
group_by(year) %>%
summarise(emission = sum(Emissions))

# Plotting using ggplot2
library(ggplot2)
png("plot4.png", 
	width=480, 
	height=480)
qplot(year, emission, 
	data = coal_emissions_year,
	geom = "line") + 
    ggtitle(expression("Total Emissions from PM"[2.5]*" from Coal in the US")) +
    xlab("Year") +
    ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tonnes)"))
dev.off()