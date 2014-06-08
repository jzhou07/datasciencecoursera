PlotOne <- function() {

    ## Download original file
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "./data/exdata_data_household_power_consumption_0.zip", mode = "wb")
    DateDownloaded <- date()

    ## Unzip file to txt file
    unzip(zipfile = "./data/exdata_data_household_power_consumption_0.zip", exdir = "./data")
    
    filename <- "./data/household_power_consumption.txt"
    
    ## Read data, filter it and get data that we need to process
    result <- read.table(filename, header = TRUE, nrow = 0, sep = ";", skip = 0, na.strings = "?")
    result <- result[which(result$Date == "1/2/2007" | result$Date == "2/2/2007"), ]
    
    ## set device to PNG
    png(file = "./Exploratory_Data_Analysis/Project_One/Plot1.png")
    
    hist(as.numeric(as.character(result$Global_active_power)), col = "red", xlab = "Gloabl Active Power (kilowatts)", main = "Gloabl Active Power")
    
    ## Remember to close
    dev.off()
}