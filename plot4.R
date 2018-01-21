##Plot4.R
##ExData_plotting1
library(lubridate)
library(dplyr)

##Import data
if(!file.exists("data")){
        dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household")
dateDownloaded <- date()

##Read element from new zip file
household<-read.csv(unzip("./data/household",exdir ="./data/"), header=TRUE, sep=";")

##Conversion
household$Date<-dmy(household$Date)
household$Time<-as.POSIXct(strptime(household$Time,format="%H:%M:%S"))
household$Global_active_power <-as.numeric(as.character(household$Global_active_power))
household$Sub_metering_1 <-as.numeric(as.character(household$Sub_metering_1))
household$Sub_metering_2 <-as.numeric(as.character(household$Sub_metering_2))
household$Sub_metering_3 <-as.numeric(as.character(household$Sub_metering_3))
household$Voltage <-as.numeric(as.character(household$Voltage))
household$Global_reactive_power <-as.numeric(as.character(household$Global_reactive_power))

##Filter on dates 2017-02-01 and 2017-02-02
household.filtered <- household %>% 
        filter(Date >="2007-02-01", Date <="2007-02-02") %>%
        arrange(Date,Time)

##Multiple Base Plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(household.filtered,plot(Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="",xaxt="n"))
with(household.filtered,axis(1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat")))

with(household.filtered,plot(Voltage,type="l",ylab="Voltage",xlab="datetime",xaxt="n"))
with(household.filtered,axis(1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat")))

with(household.filtered,plot(Sub_metering_1,type="l",ylab="Energy sub metering",,xlab="",xaxt="n"))
with(household.filtered,lines(Sub_metering_2,type="l",col="red"))
with(household.filtered,lines(Sub_metering_3,type="l",col="blue"))
with(household.filtered,axis(1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat")))
legend("topright",lty=1,lwd=1.5,col=c("black","red","blue"),cex=0.5,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


with(household.filtered,plot(Global_reactive_power,type="l",,xlab="datetime",xaxt="n"))
with(household.filtered,axis(1,at=c(1,1440,2880),labels=c("Thu","Fri","Sat")))


##Create PNG File
dev.copy(png,width = 480, height = 480,file="plot4.png")
dev.off()