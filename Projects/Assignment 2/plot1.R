# Dwonload the file
if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile <- "./data/exdata-data-NEI_data.zip"
download.file(fileUrl, destfile)

# Unzip the files
dataset <- unzip(destfile, exdir = "./data")

# Read in the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
dim(NEI) # 6,497,651 * 6
str(NEI)
dim(SCC) # 11,717 * 15
str(SCC)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make 
# a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Summary of emission by year
library(dplyr)
emissions_by_year <- NEI %>%
group_by(year) %>%
summarise(emission = sum(Emissions))

# Resize the margin
par(mar = rep(2, 4))

# Plotting with the base plotting system
png("plot1.png", 
	width=480, 
	height=480)
plot(emissions_by_year$year, emissions_by_year$emission/10^6, 
	type= "l", 
	main = expression("Total Emissions of PM "[2.5]*" in the United States from 1999 to 2008"), 
	xlab= "Year", 
	ylab= expression('Total PM'[2.5]*" Emission"))
dev.off()

