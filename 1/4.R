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

# Plot 4
png("plot4.png", width=480, height=480)
par(mfrow= c(2,2))
plot(powerDT[, dateTime], powerDT[,Global_reactive_power], type= "l", xlab= "datetime", ylab= "Global_reactive_power")

dev.off()
