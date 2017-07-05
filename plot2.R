powerdt <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
## Format date to Type Date
powerdt$Date <- as.Date(powerdt$Date, "%d/%m/%Y")
## Subset of data - 2007-2-1 and 2007-2-2
powersubsetdt <- subset(powerdt,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
## Eliminate NA
powersubsetdt <- powersubsetdt[complete.cases(powersubsetdt),]
## Combine Date and Time column
dateTime <- paste(powersubsetdt$Date, powersubsetdt$Time)
dateTime <- setNames(dateTime, "DateTime")
powersubsetdt <- powersubsetdt[ ,!(names(powersubsetdt) %in% c("Date","Time"))]
powersubsetdt <- cbind(dateTime, powersubsetdt)
powersubsetdt$dateTime <- as.POSIXct(dateTime)

##Plot2
png(file = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(powersubsetdt$Global_active_power~powersubsetdt$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()