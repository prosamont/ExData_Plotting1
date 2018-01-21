##Plot1.R
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

##Filter on dates 2017-02-01 and 2017-02-02
household.filtered <- household %>% 
        filter(Date >="2007-02-01", Date <="2007-02-02") %>%
        arrange(Date,Time)
##-----------------------------
##Hist
##-----------------------------
hist(household.filtered$Global_active_power,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

##Create PNG File
dev.copy(png,width = 480, height = 480,file="plot1.png")
dev.off()
