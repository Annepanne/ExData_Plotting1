#Reading data (only want the relevant data, so I use the package sqldf where one ca specify rows)
install.packages("sqldf")
library(sqldf)
powerCons <- read.csv.sql("household_power_consumption.csv", 
                          sql = "select * from file where Date = '1/2/2007' or Date ='2/2/2007'", 
                          header = T, sep = ";")


#First converting missing values (=?) to NA
powerCons[ powerCons == "?"] <- NA

#Converting to date and time format
powerCons$DateTime <- strptime(paste(powerCons[,1], powerCons[,2], sep = " "), format = "%d/%m/%Y %H:%M:%S")

#plot 3
with(powerCons, plot(DateTime, Sub_metering_1, main = "Plot 3", type = "n", ylab = "Energy sub metering"))
with(powerCons, lines(DateTime, Sub_metering_1, col = "black"))
with(powerCons, lines(DateTime, Sub_metering_2, col = "red"))
with(powerCons, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", pch = 95, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()
