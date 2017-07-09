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
filteredData[,"Sub_metering_1"] <- as.numeric(filteredData[,"Sub_metering_1"])
filteredData[,"Sub_metering_2"] <- as.numeric(filteredData[,"Sub_metering_2"])
filteredData[,"Sub_metering_3"] <- as.numeric(filteredData[,"Sub_metering_3"])

## Plot the dataset in a PNG graphical device and annotate it
png("plot3.png", width=480, height=480)
plot(
    datetime,
    filteredData[, "Sub_metering_1"],
    type = "l",
    main ="",
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
  )

## Close graphical device
dev.off()