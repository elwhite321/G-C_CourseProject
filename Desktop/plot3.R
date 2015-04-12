

## Code to get data into R from web Url
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data")) {dir.create("data")}
datFile<- file("./data" )
download.file(fileUrl, destfile = "./data/power.zip", method = "curl")
datFile<- unzip("./data/power.zip", )
powerDat<- read.table(datFile, sep=";", header=TRUE)
unlink(datFile)
copyPowerDat <- powerDat ## copy of original data frame

## Clean Data (enough)
powerDat <- powerDat[!powerDat == "?", ]
powerDat$Date <- as.Date(powerDat$Date, format = "%d/%m/%Y")

##Subset
powerDatsub <- subset(powerDat, Date > "2007-01-31" & Date < "2007-02-03")
copysub <- powerDatsub

##Make Column with combined Date and Time
powerDatsub$DateTime <- paste(powerDatsub$Date, powerDatsub$Time)
copyDateTime <- powerDatsub$DateTime
library(lubridate) ## need to install; not a basic R package; not included in code
powerDatsub$DateTime <- ymd_hms(powerDatsub$DateTime)

##Plot
powerDatsub$Sub_metering_1 <- as.numeric(paste(powerDatsub$Sub_metering_1))
powerDatsub$Sub_metering_2 <- as.numeric(paste(powerDatsub$Sub_metering_2))
powerDatsub$Sub_metering_3 <- as.numeric(paste(powerDatsub$Sub_metering_3))

png(file="plot3.png", width=480, height=480)
with(powerDatsub,{ plot(DateTime, Sub_metering_1, type = "l", ylab= "Energy sub metering")
lines(DateTime, Sub_metering_2, col = "red")
lines(DateTime, Sub_metering_3, col = "blue")
})
legend("topright", lty=c(1,1,1), lwd=c(2,2,2), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
