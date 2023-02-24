library("data.table")
path <- getwd()

setwd("~/Desktop/Coursera/EDA/project/data")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile= paste(path, "dataFiles.zip", sep= "/"))
unzip(zipfile = "dataFiles.zip")

# Load  NEI & SCC
NEI <- data.table::as.data.table(x= readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x= readRDS("Source_Classification_Code.rds"))

# Gather the subset of the NEI data to vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city
vehiclesBaltimoreNEI <- vehiclesNEI[fips == "24510",]
vehiclesBaltimoreNEI[, city := c("Baltimore City")]
vehiclesLANEI <- vehiclesNEI[fips == "06037",]
vehiclesLANEI[, city := c("Los Angeles")]

# Combine data.tables into one 
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

png("plot6.png")
ggplot(combustionNEI,aes(x= factor(year),y= Emissions/10^5, fill= city)) +
  geom_bar(fill= "year", stat = "#identity", width= 0.75) +
  facet_grid(scales= "free", space= "free", .~city)
  labs(x= "year", y= expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title= expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()