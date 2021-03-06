######to make the data tidy#####

data <- "power.zip" 

if (!file.exists(data)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, data ,method = 'libcurl')
  
  unzip(data) 
}

req<-read.table("household_power_consumption.txt",header=TRUE, sep = ";", na="?")

colnames(req) <- c("Date", "Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")


req$Time <- strptime(paste(req$Date,req$Time), "%d/%m/%Y %H:%M:%S")
req$Date <- as.Date(req$Date, "%d/%m/%Y")

dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
req<- subset(req, Date %in% dates)


######to make the plots#####


par(mfcol=c(1,1))
plot.new()
par(mfcol = c(2,2))
plot(req$Time,req$GlobalActivePower,type = "l",xlab ="",ylab="Global Active Power" )

plot(req$Time,req$SubMetering1,type = "n",xlab="",ylab="Energy sub metering")
points(req$Time,req$SubMetering1,type = "l")
points(req$Time,req$SubMetering2,type = "l",col="red")
points(req$Time,req$SubMetering3,type = "l",col="blue")
legend("topright",lty=1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.85,bty="n")

plot(req$Time,req$Voltage,xlab="datetime",ylab="Voltage",type="l")

plot(req$Time,req$GlobalReactivePower,xlab="datetime",ylab="Global_reactive_power",type="l")
dev.copy(png,file="plot4.png",height=480,width=480)
dev.off()