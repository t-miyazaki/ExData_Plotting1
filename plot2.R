setwd("~/Desktop/Coursera") # Set working directory
library(tidyverse)
library(lubridate)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- dmy_hms(df$DateTime)
df <- filter(df, date(DateTime) == as.Date("2007-02-01") | 
                     date(DateTime) == as.Date("2007-02-02")) %>%
        select(DateTime, everything()) %>%
        mutate(Global_active_power = as.numeric(Global_active_power))
with(df, plot(DateTime, Global_active_power, type = "l",
              xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
