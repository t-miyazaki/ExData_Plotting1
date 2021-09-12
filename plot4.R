setwd("~/Desktop/Coursera") # Set working directory
library(tidyverse)
library(lubridate)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- dmy_hms(df$DateTime)
df <- filter(df, date(DateTime) == as.Date("2007-02-01") | 
                     date(DateTime) == as.Date("2007-02-02")) %>%
        select(DateTime, everything()) %>%
        mutate(Global_active_power = as.numeric(Global_active_power)) %>%
        mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
        mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
        mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
        mutate(Sub_metering_3 = as.numeric(Sub_metering_3))
ymax <- max(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
par(mfrow = c(2,2))
# Plot 4-1
with(df, plot(DateTime, Global_active_power, type = "l",
              xlab = "", ylab = "Global Active Power"))
# Plot 4-2
with(df, plot(DateTime, Voltage, type = "l",
              xlab = "datetime", ylab = "Voltage"))
# Plot 4-3
with(df, plot(DateTime, Sub_metering_1, type = "l", ylim = c(0, ymax),
              xlab = "", ylab = "", axes = F, ann = F))
par(new = T)
with(df, plot(DateTime, Sub_metering_2, type = "l", ylim = c(0, ymax), 
              xlab = "", ylab = "", axes = F, ann = F, col = "red"))
par(new = T)
with(df, plot(DateTime, Sub_metering_3, type = "l", ylim = c(0, ymax),
              xlab = "", ylab = "Energy sub metering", col = "blue"))
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
cols <- c("black", "red", "blue")
legend("topright", legend = labels, col = cols, lty = 1, 
       y.intersp = 0.2, bty = "n")

# Plot 4-4
with(df, plot(DateTime, Global_reactive_power, type = "l",
              xlab = "datetime", ylab = "Global_reactive_power"))
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
