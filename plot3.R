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

##Plot3
png(file = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
with(powersubsetdt, {
        plot(Sub_metering_1~dateTime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()