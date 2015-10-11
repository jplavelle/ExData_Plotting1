#Read in the data.
hpc<-fread("household_power_consumption.txt",na.strings = "?")

#Subset and combine necessary subsets into a single data table.
hpc2<-hpc[hpc$Date=="1/2/2007",]
hpc3<-hpc[hpc$Date=="2/2/2007",]
hpc4DT<-rbind(hpc2,hpc3)

#Convert 'Date' field from 'character' to 'date' class.
hpc4DT$Date<-as.Date(hpc4DT$Date,format="%d/%m/%Y")

#Create temporary date/time field for purposes of converting 'Time' field.
hpc4DT$TempTime<-paste(hpc4DT$Date,hpc4DT$Time)

#Convert data table to data frame.
hpc4<-as.data.frame(hpc4DT)

#Convert 'Time' field from 'character' to 'POSIXct' class.
hpc4$Time<-strptime(hpc4$TempTime,format="%Y-%m-%d %H:%M:%S")

#Draw Plot 3.
png(file="plot3.png")

plot(hpc4$Time,hpc4$Sub_metering_1,xlab = "",ylab = "Energy sub metering",
     type = "s",ylim = c(0,38))

par(new=T)

plot(hpc4$Time,hpc4$Sub_metering_2,xlab = "",ylab = "Energy sub metering",
     type = "s",col="red",ylim=c(0,38))

par(new=T)

plot(hpc4$Time,hpc4$Sub_metering_3,xlab = "",ylab = "Energy sub metering",
     type = "s",col="blue",ylim=c(0,38))

legend("topright",lty=1,col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()