library(dplyr)
library(lubridate)
library(chron)
mydf <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, header=TRUE)
mydf <- tbl_df(mydf)
data <- mutate(mydf, Date = dmy(Date))
data$Time <- strptime(data$Time, "%T")
data$Time <- times(format(data$Time, "%H:%M:%S"))
dates <- filter(data, Date=="2007-02-01" | Date=="2007-02-02")
dates$Global_active_power <- as.numeric(dates$Global_active_power)

dates$date_time <- strptime(paste(dates$Date, dates$Time), "%Y-%m-%d %H:%M:%S")
dates$date_time <- as.POSIXct(dates$date_time)
png("plot2.png", width = 480, height = 480)
par(bg=NA)
plot(dates$Global_active_power ~ dates$date_time, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
