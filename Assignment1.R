## R file for Assignment 1.

setwd ('C:\\Users\\SethG\\Documents\\Coursera\\ExploratoryDataAnalysis\\ExData_Plotting1')
# if (!file.exists("data")) {
#     dir.create("data")
# }
# datadir = './data'

# grabfile <- function(filesource, filename, directory = datadir, mode = "w") {
#     ## if the file doesn't exist, download it.
#     #thefile <- paste(directory, "/", filename, sep = "")
#     thefile <- filename #unnecessary, but I'll keep in case I uncomment above
#     if (!file.exists(thefile)) {
#         download.file(filesource, destfile = thefile, mode = mode)
#     }
# }

## files to work with
# MyZip <- 
#     'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
# grabfile(MyZip, "ElectricPowerConsumption.zip", mode = "wb")
# unzip("ElectricPowerConsumption.zip")  #contains household_power_consumption.txt

#install.packages("data.table")
library(data.table)
tempDT <- fread("household_power_consumption.txt", 
                colClasses = c("character", "character", "character", 
                               "character", "character", "character", 
                               "character", "character", "character"))

fromdate <- as.Date("02/01/2007", format='%m/%d/%Y')
todate <- as.Date("02/02/2007", format='%m/%d/%Y')

PowerDF <- as.data.frame.matrix(
                subset(tempDT, 
                       as.Date(tempDT$Date, format='%d/%m/%Y') >= fromdate 
                       & as.Date(tempDT$Date, format='%d/%m/%Y') <= todate
                       )
                )
rm(tempDT)
#small enough that I can now use an inefficient method
PowerDF <- transform(PowerDF, Date = as.Date(Date, format='%d/%m/%Y'))
PowerDF <- transform(PowerDF, 
                     Time = strptime(paste(PowerDF$Date, PowerDF$Time),
                                     format="%Y-%m-%d %H:%M:%S")
                     )
PowerDF[, c(3:9)] <- sapply(PowerDF[, c(3:9)], as.numeric)

#my data is set up!
save(PowerDF, file = "powerdf.rda")
