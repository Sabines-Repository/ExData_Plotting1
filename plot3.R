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

## plot 3
png("plot3.png", width=480, height=480, units="px")
plot(data$DateTime, data[,8],type="n",ylab="Energy sub metering",xlab="")
lines(data$DateTime, data[,8],type="l", col="black")
lines(data$DateTime, data[,9],type="l",col="red")
lines(data$DateTime, data[,10],type="l",col="blue")
legend("topright", "(x,y)", legend=names[8:10],cex=0.8, lty=1,col=c("black", "red", "blue"))
dev.off()