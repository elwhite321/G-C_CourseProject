## Code to get data from web Url
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


## Subset Data
powerDatsub <- subset(powerDat, Date > "2007-01-31" & Date < "2007-02-03")
powerDatsub$Global_active_power <- as.numeric(paste(powerDatsub$Global_active_power))


##Make Column with combined Date and Time
powerDatsub$DateTime <- paste(powerDatsub$Date, powerDatsub$Time)
copyDateTime <- powerDatsub$DateTime
library(lubridate) ## need to install; not a basic R package; not included in code
powerDatsub$DateTime <- ymd_hms(powerDatsub$DateTime)

## Set Class as numeric for used data.frame columns
powerDatsub$Sub_metering_1 <- as.numeric(paste(powerDatsub$Sub_metering_1))
powerDatsub$Sub_metering_2 <- as.numeric(paste(powerDatsub$Sub_metering_2))
powerDatsub$Sub_metering_3 <- as.numeric(paste(powerDatsub$Sub_metering_3))
powerDatsub$Voltage <- as.numeric(paste(powerDatsub$Voltage))
powerDatsub$Global_active_power <- as.numeric(paste(powerDatsub$Global_active_power))
powerDatsub$Global_reactive_power <- as.numeric(paste(powerDatsub$Global_reactive_power))

##Plots 4
if(!file.exists("project1")) {dir.create("project1")}
png(file="./project1/plot4.png", width=480, height=480) ## open png file
par(mfrow = c(2,2), mar = c(4,4,2,2))
with(powerDatsub, {
      
      plot(DateTime, Global_active_power, type = "l", ylab = 
           "Global Active Power (kilowats)", xlab = "")

      plot(DateTime, Voltage, type = "l", xlab = "datetime")

      plot(DateTime, Sub_metering_1, type = "l", ylab= "Energy sub metering")
            lines(DateTime, Sub_metering_2, col = "red")
            lines(DateTime, Sub_metering_3, col = "blue")
            legend("topright", lty=c(1,1,1), lwd=c(2,2,2), col = c("black", "red", "blue"),
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  cex = 1, bty = "n")


      plot(DateTime, Global_reactive_power, xlab="datetome", type="l")
      
})
dev.off()
