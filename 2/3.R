library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile= paste(path, "dataFiles.zip", sep= "/"))
unzip(zipfile = "dataFiles.zip")

NEI <- data.table::as.data.table(x= readRDS(file= "summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x= readRDS(file= "Source_Classification_Code.rds"))

# Baltimore subset NEI
baltimoreNEI <- NEI[fips== "24510",]


png(filename='plot3.png')
ggplot(baltimoreNEI,aes(factor(year),Emissions,fill= type)) +
  geom_bar(stat= "identity") +
  theme_bw() + guides(fill= FALSE)+
  facet_grid(.~type,scales= "free",space= "free") + 
  labs(x= "year", y= expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title= expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()