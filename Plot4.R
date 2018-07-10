#Reading data (only want the relevant data, so I use the package sqldf where one ca specify rows)
#install.packages("sqldf")
library(sqldf)
powerCons <- read.csv.sql("household_power_consumption.csv", 
                          sql = "select * from file where Date = '1/2/2007' or Date ='2/2/2007'", 
                          header = T, sep = ";")


#First converting missing values (=?) to NA
powerCons[ powerCons == "?"] <- NA

#Converting to date and time format
powerCons$DateTime <- strptime(paste(powerCons[,1], powerCons[,2], sep = " "), format = "%d/%m/%Y %H:%M:%S")

#plot 4
plot.new()
par(mfrow = c(2,2))
with(powerCons, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power"))
with(powerCons, plot(DateTime, Voltage, type = "l"))
with(powerCons, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering"))
with(powerCons, lines(DateTime, Sub_metering_1, col = "black"))
with(powerCons, lines(DateTime, Sub_metering_2, col = "red"))
with(powerCons, lines(DateTime, Sub_metering_3, col = "blue"))
with(powerCons, plot(DateTime, Global_reactive_power, type = "l"))

