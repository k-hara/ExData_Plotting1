if (!file.exists("./data"))
{dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data/exdata-data-household_power_consumption.zip"))
{download.file(fileUrl, destfile="./data/exdata-data-household_power_consumption.zip", method="curl")}
if(!file.exists("./data/household_power_consumption.txt"))
{unzip("./data/exdata-data-household_power_consumption.zip", exdir="./data/")}
library(dplyr)
library(lubridate)
epc <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = TRUE)
hpc <- tbl_df(epc)
hpc2 <- mutate(hpc, Date = as.character(hpc$Date), Time = as.character(hpc$Time))
hpc3 <-filter(hpc2, Date == "1/2/2007"|Date == "2/2/2007")
hpc4 <- mutate(hpc3, Date_Time = paste(hpc3$Date, hpc3$Time))
DT <- dmy_hms(hpc4$Date_Time, "%d%m%y %H:%M:%S")
hpc4$Date_Time<- DT[1:2880]
Sys.setlocale("LC_ALL","C")
png(filename = "plot3.png")
with(hpc4, plot(Date_Time, Sub_metering_1, xlab ="", ylab = "Energy Sub Metering", type ="l"))
with(hpc4, lines(Date_Time, Sub_metering_2, ,  col = "red"))
with(hpc4, lines(Date_Time, Sub_metering_3, ,  col = "blue"))
legend("topright", lwd =1, col =c("black", "red", "blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
Sys.getlocale()
