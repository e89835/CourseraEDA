library("data.table")
setwd("~/Desktop/Coursera/EDA/project/data")

# Reads in data 
powerDT <- data.table::fread(input= "household_power_consumption.txt", na.strings= "?")

# Prevents histogram from printing in scientific notation
powerDT[, Global_active_power:= lapply(.SD, as.numeric), .SDcols= c("Global_active_power")]

# Change Date Column to Date Type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols= c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]


# Plot 3
png("plot3.png", width=480, height=480)
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type= "l", xlab= "", ylab= "Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2],col= "red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col= "blue")
legend("topright"
       , col= c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty= c(1,1), lwd= c(1,1))

dev.off()
