#for running this file, it is necessary to set the working directory 
#to point to the directory where household_power_consumption.txt is located

#read in the data from household_power_consumption.txt
#delimiter=";"

#getwd()
#setwd("/Users/Bea/Documents/coursera/coursera-R-Programming/course-exploratory-data-analysis/proj-W1")
#list.files()

fileName <- "household_power_consumption.txt"

powerDF <- read.table(file=fileName, header=TRUE, sep=";", stringsAsFactors = FALSE)
#str(powerDF)
#dim(powerDF)


#first subset the DF to speed up further processing
#We will only be using data from the dates 2007-02-01 and 2007-02-02 and the 3 first columns

subDF <- subset(powerDF, Date %in% c("1/2/2007", "2/2/2007"), select = c("Date","Time", "Global_active_power" ))

#str(subDF)

#now concatenate the date and time column
dateTime <- strptime( paste(subDF$Date, subDF$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
#str(dateTime)
# POSIXlt[1:2880], format: "2007-02-01 00:00:00" 

numActivePower <- as.numeric(subDF$Global_active_power)
#str(numActivePower)
# num [1:2880] 0.326 0.326

#open file
png("plot2.png", width=480, height=480)
plot(dateTime,numActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)" )
# close file
dev.off()



