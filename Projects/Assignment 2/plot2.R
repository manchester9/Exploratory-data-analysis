# Dwonload the file
if (!file.exists("data")) {dir.create("data")}
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile = "./data/exdata-data-NEI_data.zip"
download.file(fileUrl, destfile)

# Read in the data
NEI = readRDS("./data/summarySCC_PM25.rds")
SCC = readRDS("./data/Source_Classification_Code.rds")
dim(NEI)
str(NEI)
dim(SCC)
str(SCC)

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
library(dplyr)
ba_city_emissions <- filter(NEI, fips == "24510" )
ba_emissions_by_year <- ba_city_emissions %>%
group_by(year) %>%
summarise(emission = sum(Emissions))

# Resize the margin
par(mar = rep(2, 4))

# Plotting with the base plotting system
png("plot2.png", 
	width=480, 
	height=480)
plot(ba_emissions_by_year$year, ba_emissions_by_year$emission/10^6, 
	type= "l", 
	main = expression("Total Emissions from PM"[2.5]*" in Baltimore City"), 
	xlab= "Year", 
	ylab= expression('Total PM'[2.5]*" Emission"))
dev.off()