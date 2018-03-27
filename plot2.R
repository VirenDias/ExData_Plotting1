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

# Creating the plot and saving it to a PNG file
png(filename = "plot2.png", height = 480, width = 480)
plot(requiredData$Date_time, requiredData$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()