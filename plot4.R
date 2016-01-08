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

#this time we need all columns
powerSubDF <- subset(powerDF, Date %in% c("1/2/2007", "2/2/2007"))

#change the class of the columns

powerSubDF[, 1] <- as.POSIXct(powerSubDF[, 1], format="%d/%m/%Y")

powerSubDF[, 2] <- as.POSIXct(powerSubDF[, 2], format="%H:%M:%S")

powerSubDF[, 3] <- as.numeric(powerSubDF[, 3])

powerSubDF[, 4] <- as.numeric(powerSubDF[, 4])

powerSubDF[, 5] <- as.numeric(powerSubDF[, 5])

powerSubDF[, 6] <- as.numeric(powerSubDF[, 6])

powerSubDF[, 7] <- as.numeric(powerSubDF[, 7])

powerSubDF[, 8] <- as.numeric(powerSubDF[, 8])

powerSubDF[, 9] <- as.numeric(powerSubDF[, 9])


#now concatenate the date and time column
dateTime <- strptime( paste(subDF$Date, subDF$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
#str(dateTime)


#open file
png("plot4.png", width=480, height=480)

#set the parameters
par(mfrow=c(2,2))

#add first plot
plot(dateTime,powerSubDF$Global_active_power, type="l", xlab ="", ylab="Global Active Power", cex=0.2)

#add second plot
plot(dateTime,powerSubDF$Voltage, type="l", xlab ="datetime", ylab="Voltage")

#add third plot
plot(dateTime,powerSubDF$Sub_metering_1, type="n", xlab="", ylab="Energy Sub Metering")
lines(dateTime,powerSubDF$Sub_metering_1, type="l", col="black")
lines(dateTime,powerSubDF$Sub_metering_2, type="l", col="red")
lines(dateTime,powerSubDF$Sub_metering_3, type="l", col="blue")
legend("topright",  lty=1, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="o")


#add fourth plot
plot(dateTime,powerSubDF$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# close file
dev.off()
