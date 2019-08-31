#Initialize libraries
library(lubridate)
library(dplyr)

##Begin by pulling data set into data.frame
db <- read.delim("~/household_power_consumption.txt", sep=";", as.is = TRUE)

#Convert Date format
db$Date <- paste(db$Date,db$Time)
db$Date <- strptime(db$Date,format = "%d/%m/%Y %H:%M:%S", tz = "GMT")

#Subset Data by desired Date range (2/1/2007-2/2/2007)
subdb <- 
db[with(db, Date >= ymd_hms("2007-02-01 00:00:00") & Date < ymd_hms("2007-02-03 00:00:00")),]

#Change the type of all columns that are character to numeric
#NOTE: disregard warning message "NAs introduced by coercion"
#Time is incorperated in Date field now
subdb <- lapply(subdb, function(x) if(is.character(x)) as.numeric(x) else x)

#Open png device
png(filename = "plot1.png")
#Generate plot
hist(subdb$Global_active_power, col = 2, freq = TRUE, xlim = c(0,6), ylim = c(0,1200), main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Turn device off
dev.off()


