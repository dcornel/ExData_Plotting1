library(data.table)

plot2<- function()
{
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        temp <-tempfile()
        download.file(fileURL,temp)
        
        data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE, na.strings ="?", stringsAsFactors = FALSE)
        #data <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE, na.strings ="?", stringsAsFactors = FALSE)
        unlink(temp)
        
        data$Date<- as.Date(data$Date,"%d/%m/%Y")
        
        data<- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
        data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
        data$Global_active_power<- as.numeric(data$Global_active_power)
        
        
        
        png("plot2.png", width = 480, height = 480)
        myplot <- plot(y=data$Global_active_power,
                       x=data$datetime, type="l", 
                       ylab ="Global Active Power (kilowatts)",
                       xlab= "")
        dev.off()
        
}