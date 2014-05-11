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

png(filename="plot4.png",
    width = 480,
    height = 480,
    bg = "transparent") ## Open png device; create 'plot1.png' in my working dir


par(mfrow = c(2, 2)) #set up a 2x2 grid

#first graph is the same as plot2 with a slightly different y label
plot(Time, ## x
     Global_active_power, ## y
     type = "n",
     xlab = "",
     ylab = "Global Active Power"
)

lines(Time, ## x
      Global_active_power, ## y
      type = "l" ## lines
)    

#second graph
plot(Time, ## x
     Voltage, ## y
     type = "n",
     xlab = "datetime",
     ylab = "Voltage"
)

lines(Time, ## x
      Voltage, ## y
      type = "l", ## lines
      lwd = 0.2 ## try for thinner
)    


#third is the same as plot3 (with no box around the legend)
plot(Time, ## x
     Sub_metering_1, ## y
     type = "n",
     xlab = "",
     ylab = "Energy sub metering",
     yaxp = c(0, 30, 3)
)

lines(Time, ## x
      Sub_metering_1, ## y
      type = "l", ## lines
      col = "black"
)    

lines(Time, ## x
      Sub_metering_2, ## y
      type = "l", ## lines
      col = "red"
)    

lines(Time, ## x
      Sub_metering_3, ## y
      type = "l", ## lines
      col = "blue"
)    

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # puts text there
       lty = c(1,1), #gives appropriate symbols (lines)
       col = c("black", "red", "blue"),
       bty = "n"
)

#fourth graph
plot(Time, ## x
     Global_reactive_power, ## y
     type = "n",
     xlab = "datetime",
)

lines(Time, ## x
      Global_reactive_power, ## y
      type = "l", ## lines
      lwd = 0.2 ## try for thinner
)    


#clean up
dev.off() ## close the png device
detach(powerdf)

