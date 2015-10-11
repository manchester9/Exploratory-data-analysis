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
datetime <- strptime(paste(subset_data$Date, subset_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
sub_metering_1 <- as.numeric(subset_data$Sub_metering_1)
sub_metering_2 <- as.numeric(subset_data$Sub_metering_2)
sub_metering_3 <- as.numeric(subset_data$Sub_metering_3)

# Plotting the dataset
png("plot3.png", 
	width=480, 
	height=480)
plot(datetime, sub_metering_1, 
	type="l", 
	ylab="Energy sub metering", 
	xlab="")
lines(datetime, sub_metering_2, 
	type="l", 
	col="red")
lines(datetime, sub_metering_3, 
	type="l", 
	col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	lty=1, 
	lwd=2.5, 
	col=c("black", "red", "blue"))
dev.off()


