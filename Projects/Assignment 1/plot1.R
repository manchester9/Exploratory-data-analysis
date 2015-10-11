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
global_active_power <- as.numeric(subset_data$Global_active_power)

# Plotting the dataset
png("plot1.png", 
	width = 480, 
	height = 480)
hist(global_active_power, 
	col = "red", 
	main = "Global Active Power", 
	xlab="Global Active Power (kilowatts)")
dev.off()