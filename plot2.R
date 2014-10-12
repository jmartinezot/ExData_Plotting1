
# Download the file to the working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "download.zip", method = "curl")

# Unzip the downloaded file; now there is a file called "household_power_consumption.txt" in the working directory
unzip("download.zip")

# The next two commands might be dependent of the operating system, but are useful if you are in a linux system
# and not sure about the capacity of your RAM memory
# First a table is read into memory (household_data), only containing the two dates we are interested in
# Then the column names are extracted from the whole downloaded file (household_data_names), but without loading it into memory
# Finally the column names are assigned to the household_data data.frame
household_data <- read.table(file = pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), colClasses=c(rep ("character",2),rep("numeric",6)), sep=";", na.strings ="?")
household_data_names <- read.table(file = pipe('head -1 "household_power_consumption.txt"'), sep=";", header = T)
names(household_data) <- names(household_data_names)

# New data field
household_data$FullDate <- strptime(paste(household_data$Date,household_data$Time), "%d/%m/%Y %H:%M:%S")

# Plotting procedure
png("plot2.png", width=480, height=480)
plot(household_data$FullDate, household_data$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.off() 



