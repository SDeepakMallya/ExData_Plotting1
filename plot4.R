plot4 <- function() {
  #Download the data set from the given url
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "power_consumption.zip")
  
  #Unzip the file in the working directory
  unzip(zipfile = "power_consumption.zip")
  
  #Read the data set into a variable named 'data'
  data <- read.table(file = "household_power_consumption.txt", 
                     header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
  
  #Convert the class of 'Date' column into Date()
  data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")
  
  #Subset the required data of 1st and 2nd January 2007 into a new variable called 'data_req'
  data_req <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",] 
  
  #Create a new column in 'data_req' called 'DateTime' with both 'Date' and 'Time' in it
  data_req$DateTime <- paste(data_req$Date, data_req$Time)
  
  #Convert the class of 'DateTime' into POSIXlt
  data_req$DateTime <- strptime(x = data_req$DateTime, format = "%Y-%m-%d %H:%M:%S")
  
  #Creating plot 4
  #Dividing layout into 4 parts and re-specifying margins
  par(mfrow = c(2,2), mar = c(3, 5, 1, 1))
  
  #Subplot 1
  plot(x = data_req$DateTime, y = data_req$Global_active_power, xlab = "",
       ylab = "Global Active Power", type = "l")
  
  #Subplot 2
  plot(x = data_req$DateTime, y = data_req$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  
  #Subplot 3
  plot(x = data_req$DateTime, y = data_req$Sub_metering_1, type = "l", xlab = "", 
       ylab = "Energy sub metering")
  lines(x = data_req$DateTime, y = data_req$Sub_metering_2, col = "red")
  lines(x = data_req$DateTime, y = data_req$Sub_metering_3, col = "blue")
  legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lwd = 1, lty = 1)
  
  #Subplot 4
  plot(x = data_req$DateTime, y = data_req$Global_reactive_power, xlab = "datetime", 
       ylab = "Global_reactive_power", type = "l")
  
  #Copying the plot into a png file called 'plot4.png'. Width was increased due to necessity
  dev.copy(device = png, file = "plot4.png", width = 640, height = 480)
  
  #Closing the png graphics device
  dev.off()
}
