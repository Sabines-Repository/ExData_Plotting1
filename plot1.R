original_data = read.table("household_power_consumption.txt", sep=";", 
                           strip.white=TRUE, header=TRUE, dec=".", stringsAsFactors=FALSE)
lapply(original_data, class)
## trim white space, otherwise as.numeric does not work correctly!
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
original_data$Global_active_power <-as.numeric(trim(original_data$Global_active_power))
head(original_data)

## subset the two days of interest for the subsequent operations
index <- grep("^(1|2)/2/2007",original_data$Date)
data <- original_data[index,]

DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
## x <- as.Date(x) ## removes time?
data <- cbind(DateTime, data)

names <-names(data)

## plot 1
png("plot1.png", width=480, height=480, units="px")
plot(data$Global_active_power)
summary(data$Global_active_power)
hist(data$Global_active_power, col="red", xlab="Global Activity Power (kilowatts)",
     main="Global Active Power", ylim=c(0,1200))
ytic <- seq(0,1200,200)
axis(2,at=ytic,labels=ytic)
dev.off()