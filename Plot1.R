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

#make plot 1
hist(powerCons$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
