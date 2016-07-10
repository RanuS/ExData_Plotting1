######to make the data tidy#####

data <- "power.zip" 

if (!file.exists(data)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, data,method = 'libcurl')
  
  unzip(data) 
}


req<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", na="?")

colnames(req) <- c("Date", "Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")

req$Time <- strptime(paste(req$Date,req$Time), "%d/%m/%Y %H:%M:%S")
req$Date <- as.Date(req$Date, "%d/%m/%Y")

dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
req<- subset(req, Date %in% dates)


######to make the plot#####
par(mfcol=c(1,1))
plot.new()
plot(req$Time,req$GlobalActivePower,type = "l",xlab ="",ylab="Global Active Power (kilowatts)" )
dev.copy(png,file="plot2.png",height=480,width=480)
dev.off()