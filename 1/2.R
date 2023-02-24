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


# Plot 2
png("plot2.png", width=480, height=480)
plot(x= powerDT[, dateTime]
     , y= powerDT[, Global_active_power]
     , type= "l", xlab= "", ylab= "Global Active Power (kilowatts)")

dev.off()
