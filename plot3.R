library(data.table)

plot3<- function()
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
        
        
        
        png("plot3.png", width = 480, height = 480)
        with(data, {
                        plot(y=Sub_metering_1, x=data$datetime, type="l", col = "black", 
                             ylab = "Energy sub metering", xlab ="",
                             ylim = range(Sub_metering_1, Sub_metering_2,Sub_metering_3, na.rm = TRUE))
                        par(new=TRUE)
                        plot(y=Sub_metering_2, x=data$datetime, type="l", col = "red",
                             ylab = "Energy sub metering", xlab ="",
                             ylim = range(Sub_metering_1, Sub_metering_2,Sub_metering_3, na.rm = TRUE))
                        par(new=TRUE)
                        plot(y=Sub_metering_3, x=data$datetime, type="l", col = "blue",
                             ylab = "Energy sub metering", xlab ="",
                             ylim = range(Sub_metering_1, Sub_metering_2,Sub_metering_3, na.rm = TRUE))

                        })
        legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        dev.off()
        
}