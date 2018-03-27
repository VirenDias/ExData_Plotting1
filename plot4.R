## Downloading the data (if required)
zipname <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.txt"
if(!file.exists(zipname)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = paste(getwd(), "/", zipname, sep = ""))
}
if(!file.exists(filename)) {
    unzip(zipname)
}

# Reading in the data and subsetting the required data
data <- read.table(filename, header = TRUE, 
                   sep = ';', na.strings = "?", stringsAsFactors = FALSE)
requiredData <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

# Converting the Date and Time variables to a new variable of date/time class
requiredData$Date_time <- strptime(paste(requiredData$Date, requiredData$Time, 
                                         sep=" "), "%d/%m/%Y %H:%M:%S")

# Initiating the graphics device and setting the parameters
png(filename = "plot4.png", height = 480, width = 480)
par(mfrow = c(2,2))

# Plotting the upper left plot
plot(requiredData$Date_time, requiredData$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# Plotting the upper right plot
plot(requiredData$Date_time, requiredData$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

# Plotting the lower left plot
plot(requiredData$Date_time, requiredData$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(requiredData$Date_time, requiredData$Sub_metering_2, type = "l", 
      col = "red")
lines(requiredData$Date_time, requiredData$Sub_metering_3, type = "l",
      col = "blue")
legend("topright", lty = 1, lwd = 2.5, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n")

# Plotting the lower right plot
plot(requiredData$Date_time, requiredData$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")

# Closing the graphics device
dev.off()