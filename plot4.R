#Plot4
# Created by Shailesh Nair, 07 November 2015
# Coursera- Exploratory Data Analysis Course- Assignment1
# This r-Script reads in data from Local Working Directory and create cluster plots of "Global Active Power", Volatge 
# "Sub Metering 1,Sub Metering 2 and Sub metering 3"  and Global reactive Power over a time span of 2 days 
# from First Feb 2007 to 02 Feb 2007.
# Data Source : https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# Dataset: Electric power consumption [20Mb]
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.

# Read data and assign to m, missing data denoted by "?"
m<-read.csv("/home/shailesh/Coursera_R/household_power_consumption.txt",header=T,sep=";",na.strings = "?")

# Combine data and time data
newdate<-paste(m$Date,m$Time)

# convert to  date time format
datetime<-strptime(newdate,"%d/%m/%Y %H:%M:%S")

# Commbine with original data set
n<-cbind(m,datetime)

# Create a subset of dataset for dates from 2007-02-01 to 2007-02-02
o<-subset(n,as.POSIXct(n$datetime)>=as.POSIXct("2007-02-01") & as.POSIXct(n$datetime)<as.POSIXct("2007-02-03"))

# activate graphics file device png of resolution 480x480
png(file="plot4.png", width=480, height=480)

# Generate cluster plot
par(mfrow=c(2,2))
par(mar=c(4,5,3,2))
with(o,{
  plot(datetime,Global_active_power,type="l",xlab="", ylab="Global Active Power")
  plot(datetime,Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(datetime,Sub_metering_1,type="l", col="black", ylab="Energy sub metering", xlab="")
    lines(o$datetime,o$Sub_metering_2,col="red")
    lines(o$datetime,o$Sub_metering_3,col="blue")
  legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),lwd=c(2,2,2),col=c("blue","red","black"), cex=0.5,bty="n")
  plot(datetime,Global_reactive_power,type="l")
}
)
# close graphics device
dev.off()