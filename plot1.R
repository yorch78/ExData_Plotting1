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
filteredData[,"Date"] <- as.Date(filteredData[, "Date"], "%d/%m/%Y")
filteredData[,"Time"] <- strptime(filteredData[, "Time"], "%H:%M:%S", tz = "GMT")
filteredData[,"Global_active_power"] <- as.numeric(filteredData[,"Global_active_power"])

## Plot the dataset in a PNG graphical device and annotate it
png("plot1.png", width=480, height=480)
hist(
    filteredData[, "Global_active_power"],
    main ="Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red",
  )

## Close graphical device
dev.off()