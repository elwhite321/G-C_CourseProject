

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
 
powerDat$Date <- as.Date(powerDat$Date, format = "%d/%m/%Y")

##Subset
powerDatsub <- subset(powerDat, Date > "2007-01-31" & Date < "2007-02-03")
copysub <- powerDatsub

## Plot 1
powerDatsub$Global_active_power <- as.numeric(paste(powerDatsub$Global_active_power))
      ## make used data the right class (numeric)
par(mar = c(4, 4, 4, 4)) ## set margins
if(!file.exists("project1")) {dir.create("project1")}
png(file="./project1/plot1.png", width=480, height=480) ## open png file
hist(powerDatsub$Global_active_power, xlab="Global Acitive Power (kilowatts)", 
ylab="Frequency", col = "red", freq = TRUE, main = "Global Active Power") ## plot
axis(2, at =c(400, 800, 1200)) ## annotate axis
dev.off() ## close png file



