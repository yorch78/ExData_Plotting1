## Download dataset and unzip it
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

download.file(fileURL, fileName, method="curl")
unzip(fileName)

## Load the dataset from file
allData <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

## Read the dataset filtered by date
filteredData <- allData[allData[, "Date"] %in% c("1/2/2007","2/2/2007") ,]

## Convert columns into their proper types
datetime <- strptime(paste(filteredData[, "Date"], filteredData[, "Time"], sep=" "), "%d/%m/%Y %H:%M:%S")
filteredData[,"Global_active_power"] <- as.numeric(filteredData[,"Global_active_power"])
filteredData[,"Global_reactive_power"] <- as.numeric(filteredData[,"Global_reactive_power"])
filteredData[,"Voltage"] <- as.numeric(filteredData[,"Voltage"])
filteredData[,"Sub_metering_1"] <- as.numeric(filteredData[,"Sub_metering_1"])
filteredData[,"Sub_metering_2"] <- as.numeric(filteredData[,"Sub_metering_2"])
filteredData[,"Sub_metering_3"] <- as.numeric(filteredData[,"Sub_metering_3"])

## Plot the dataset in a PNG graphical device and annotate it (matrix 2x2)
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(
    datetime,
    filteredData[, "Global_active_power"],
    type = "l",
    main ="",
    xlab = "",
    ylab = "Global Active Power",
  )
  
plot(
    datetime,
    filteredData[, "Voltage"],
    type = "l",
    main = "",
    ylab = "Voltage",
  )

plot(
    datetime,
    filteredData[, "Sub_metering_1"],
    type = "l",
    main = "",
    xlab = "",
    ylab = "Energy sub metering",
  )
  
lines(datetime, filteredData[, "Sub_metering_2"], col = "red")
lines(datetime, filteredData[, "Sub_metering_3"], col = "blue")

legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lty = 1,
    bty = "n",
  )

plot(
    datetime,
    filteredData[, "Global_reactive_power"],
    type = "l",
    main = "",
    ylab = "Global_reactive_power",
  )

## Close graphical device
dev.off()