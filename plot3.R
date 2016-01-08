#for running this file, it is necessary to set the working directory 
#to point to the directory where household_power_consumption.txt is located

#read in the data from household_power_consumption.txt
#delimiter=";"

#getwd()
#setwd("/Users/Bea/Documents/coursera/coursera-R-Programming/course-exploratory-data-analysis/proj-W1")

fileName <- "household_power_consumption.txt"

powerDF <- read.table(file=fileName, header=TRUE, sep=";", stringsAsFactors = FALSE)
#str(powerDF)
#dim(powerDF)


#first subset the DF to speed up further processing
#We will only be using data from the dates 2007-02-01 and 2007-02-02 and some columns

mycols <- c("Date","Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
subDF <- subset(powerDF, Date %in% c("1/2/2007", "2/2/2007"), select = mycols)

#str(subDF)

#now concatenate the date and time column
dateTime <- strptime( paste(subDF$Date, subDF$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
#str(dateTime)
# POSIXlt[1:2880], format: "2007-02-01 00:00:00" 

Sub_metering_1 <- as.numeric(subDF$Sub_metering_1)
Sub_metering_2 <- as.numeric(subDF$Sub_metering_2)
Sub_metering_3 <- as.numeric(subDF$Sub_metering_3)

#open file
png("plot3.png", width=480, height=480)

#empty plot()
plot(dateTime,Sub_metering_1, type="n", xlab="", ylab="Energy Sub Metering")
lines(dateTime,Sub_metering_1, type="l", col="black")
lines(dateTime,Sub_metering_2, type="l", col="red")
lines(dateTime,Sub_metering_3, type="l", col="blue")
legend("topright",  lty=1, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close file
dev.off()
