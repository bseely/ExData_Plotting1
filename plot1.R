## Script to make Plot 1 and save to a PNG file

## Make the /data subdirectory if it doesn't exist
if(dir.exists("./data")==FALSE) dir.create("./data",recursive = FALSE)
if(dir.exists("./figure")==FALSE) dir.create("./figure",recursive = FALSE)

## Download Data File
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./data/ProjectData.zip")

## Unzip the downloaded data
setwd("./data")
unzip("./ProjectData.zip",overwrite = TRUE)
setwd("../")

## Data Field Definitions
##      
##      Date: Date in format dd/mm/yyyy
##      
##      Time: time in format hh:mm:ss
##      
##      Global_active_power: household global minute-averaged active power (in kilowatt)
##      
##      Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
##      
##      Voltage: minute-averaged voltage (in volt)
##      
##      Global_intensity: household global minute-averaged current intensity (in ampere)
##      
##      Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen,
##      containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
##      
##      Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room,
##      containing a washing-machine, a tumble-drier, a refrigerator and a light.
##      
##      Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
##      It corresponds to an electric water-heater and an air-conditioner.
##
##


## Read in raw data from semi-colon separated file with header
raw_data_in <- read.table("./data/household_power_consumption.txt", header=TRUE,sep=";",na.strings = "?")

## Drop rows outside the desired date range (2007-02-01, 007-02-02)
working_data <- subset(raw_data_in, Date=="1/2/2007"|Date=="2/2/2007")

## Get rid of raw data file
remove(raw_data_in)

## Add a POSIXlt date/time column named timeStamp
working_data$timeStamp <- as.POSIXlt(strptime(paste(working_data$Date, working_data$Time), "%d/%m/%Y %H:%M:%S"))

## For numeric variables, factors to numeric
working_data$Global_active_power<-as.numeric(working_data$Global_active_power)  ## converts this to kilowatts
working_data$Global_reactive_power<-as.numeric(working_data$Global_reactive_power)
working_data$Voltage<-as.numeric(working_data$Voltage)
working_data$Global_intensity<as.numeric(working_data$Global_intensity)
working_data$Sub_metering_1<as.numeric(working_data$Sub_metering_1)
working_data$Sub_metering_2<as.numeric(working_data$Sub_metering_2)
working_data$Sub_metering_3<as.numeric(working_data$Sub_metering_3)

## Drop unneeded columns
working_data <- working_data[,3:10]
## head(working_data)
## str(working_data)

## Make histogram, export to PNG
dev.new(width=480, height=480, units="px")
hist(working_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="./figure/plot3.png",width = 480, height = 480,units = "px", pointsize = 12, bg = "white", res = 72,
         restoreConsole = TRUE)
dev.off()
