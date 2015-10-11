# Download the file
if (!file.exists("data")) {dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/power_consumption.zip"
download.file(fileUrl, destfile)

# Unzip the file
dataset <- unzip(destfile, exdir = "./data")

# Read the file
data <- read.table(dataset, header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE)
dim(data) # 2,075,259 * 9 
str(data)

# Subset the file
subset_data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
global_active_power <- as.numeric(subSetData$Global_active_power)
datetime <- strptime(paste(subset_data$Date, subset_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# Plotting the dataset
png("plot2.png", 
	width=480, 
	height=480)
plot(datetime, global_active_power, 
	type="l", 
	xlab="", 
	ylab="Global Active Power (kilowatts)")
dev.off()