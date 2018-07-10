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
#Make plot 2
par(mar = c(3,4,2,1))
with(powerCons, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()