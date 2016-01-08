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

#'data.frame':	2075259 obs. of  9 variables:
#  $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
#$ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
#$ Global_active_power  : chr  "4.216" "5.360" "5.374" "5.388" ...
#$ Global_reactive_power: chr  "0.418" "0.436" "0.498" "0.502" ...
#$ Voltage              : chr  "234.840" "233.630" "233.290" "233.740" ...
#$ Global_intensity     : chr  "18.400" "23.000" "23.000" "23.000" ...
#$ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
#$ Sub_metering_2       : chr  "1.000" "1.000" "2.000" "1.000" ...
#$ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...

#The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
  
#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatt)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
#Voltage: minute-averaged voltage (in volt)
#Global_intensity: household global minute-averaged current intensity (in ampere)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.



#first subset the DF to speed up further processing
#We will only be using data from the dates 2007-02-01 and 2007-02-02

idxRows <- grep("1/2/2007|2/2/2007", powerDF$Date)
#str(idxRows)


powerSubDF <- powerDF[idxRows, ]
#str(powerSubDF)
#'data.frame':	8640 obs. of  9 variables:
#  $ Date                 : chr  "1/2/2007" "1/2/2007" "1/2/2007" "1/2/2007" ...
#$ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...#
#$ Global_active_power  : chr  "0.326" "0.326" "0.324" "0.324" ...
#$ Global_reactive_power: chr  "0.128" "0.130" "0.132" "0.134" ...
#$ Voltage              : chr  "243.150" "243.320" "243.510" "243.900" ...
#$ Global_intensity     : chr  "1.400" "1.400" "1.400" "1.400" ...
#$ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
#$ Sub_metering_2       : chr  "0.000" "0.000" "0.000" "0.000" ...
#$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...



#dim(powerSubDF)
#[1] 8640    9

#convert the columns to appropriate Date, Time or Numeric classes
#as it is a data.frame, we cannot use the $ sign to address columns

powerSubDF[, 1] <- as.POSIXct(powerSubDF[, 1], format="%d/%m/%Y")

powerSubDF[, 2] <- as.POSIXct(powerSubDF[, 2], format="%H:%M:%S")

powerSubDF[, 3] <- as.numeric(powerSubDF[, 3])

powerSubDF[, 4] <- as.numeric(powerSubDF[, 4])

powerSubDF[, 5] <- as.numeric(powerSubDF[, 5])

powerSubDF[, 6] <- as.numeric(powerSubDF[, 6])

powerSubDF[, 7] <- as.numeric(powerSubDF[, 7])

powerSubDF[, 8] <- as.numeric(powerSubDF[, 8])

powerSubDF[, 9] <- as.numeric(powerSubDF[, 9])


#plot1.png is a histogram of Global_active_power
#open a png file
png(file="plot1.png")

with(powerSubDF, hist(Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)"))

#close the file
dev.off()
