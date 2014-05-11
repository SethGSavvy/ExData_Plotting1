# See Assignment1.R for code to get the file, etc. 
# We start out with transformed data in my working directory.

setwd ('C:\\Users\\SethG\\Documents\\Coursera\\ExploratoryDataAnalysis\\ExData_Plotting1')
#load("powerdf.rda")
#######################################We'll get the data here for submission
#install.packages("data.table")
library(data.table)
MyFile <- "..\\household_power_consumption.txt"
tempDT <- fread(MyFile, 
                colClasses = c("character", "character", "character", 
                               "character", "character", "character", 
                               "character", "character", "character"))

fromdate <- as.Date("02/01/2007", format='%m/%d/%Y')
todate <- as.Date("02/02/2007", format='%m/%d/%Y')

powerdf <- as.data.frame.matrix(
    subset(tempDT, 
           as.Date(tempDT$Date, format='%d/%m/%Y') >= fromdate 
           & as.Date(tempDT$Date, format='%d/%m/%Y') <= todate
    )
)
rm(tempDT)
#small enough that I can now use an inefficient method...
powerdf <- transform(powerdf, Date = as.Date(Date, format='%d/%m/%Y'))
powerdf <- transform(powerdf, 
                     Time = strptime(paste(powerdf$Date, powerdf$Time),
                                     format="%Y-%m-%d %H:%M:%S")
)
powerdf[, c(3:9)] <- sapply(powerdf[, c(3:9)], as.numeric)
###################################### I've got data!

attach(powerdf)


png(filename="plot1.png",
    width = 480,
    height = 480,
    bg = "transparent") ## Open png device; create 'plot1.png' in my working dir

hist(Global_active_power,
     breaks = seq(0, 7.5, by=.5),
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0, 1200)
)

#clean up
dev.off() ## close the png device
detach(powerdf)

