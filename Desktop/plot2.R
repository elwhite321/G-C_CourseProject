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
copysub <- powerDatsub

##Make Column with combined Date and Time
powerDatsub$DateTime <- paste(powerDatsub$Date, powerDatsub$Time)
copyDateTime <- powerDatsub$DateTime
library(lubridate) ## need to install; not a basic R package; not included in code
powerDatsub$DateTime <- ymd_hms(powerDatsub$DateTime)

##Plot 2

png(file="plot2.png", width=480, height=480) ## open png file
par(mar = c(4,4,2,2))
with(powerDatsub, plot(DateTime, Global_active_power, type = "l", ylab = 
       "Global Active Power (kilowats)", xlab = ""))
dev.off()

