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

##Plot4
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powersubsetdt, {
        plot(Global_active_power~dateTime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~dateTime, type="l", 
             ylab="Voltage", xlab="datetime")
        plot(Sub_metering_1~dateTime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~dateTime, type="l", 
             ylab="Global_reactive_power",xlab="datetime")
})
dev.off()