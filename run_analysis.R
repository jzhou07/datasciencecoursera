run_analysis <- function()
{
    ## Read all data files
    xtestdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
    ytestdata <- read.table("./UCI HAR Dataset/test/y_test.txt")
    subjecttestdata <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    xtraindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
    ytraindata <- read.table("./UCI HAR Dataset/train/y_train.txt")
    subjecttraindata <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    ## get data feature list, clean up the feature names
    feature <- read.table("./UCI HAR Dataset/features.txt")
    feature1 <- gsub("-", "", feature$V2)
    feature1 <- gsub(",", "and", feature1)
    feature1 <- gsub("\\(", "", feature1)
    feature1 <- gsub("\\)", "", feature1)
    feature1 <- tolower(feature1)
    
    colnames(ytestdata) <- c("activity")
    colnames(ytraindata) <- c("activity")
    colnames(subjecttestdata) <- c("volunteer")
    colnames(subjecttraindata) <- c("volunteer")
    
    colnames(xtestdata) <- feature1
    colnames(xtraindata) <- feature1
    
    testall <- cbind(subjecttestdata, ytestdata, xtestdata)
    trainall <- cbind(subjecttraindata, ytraindata, xtraindata)
    
    ## Get all data (train data + test data)
    dataall <- rbind(trainall, testall)
    
    ## Write to data file.
    write.table(dataall, file = "./UCI HAR Dataset/alldata.txt")
    
    ## Only need columns with mean and standard deviation
    xtestdatasub <- xtestdata[, grep("std|mean", colnames(xtestdata))]
    xtraindatasub <- xtraindata[, grep("std|mean", colnames(xtraindata))]
    
    testallsub <- cbind(subjecttestdata, ytestdata, xtestdatasub)
    trainallsub <- cbind(subjecttraindata, ytraindata, xtraindatasub)
    
    ## Get the total subset of the data
    dataallsub <- rbind(trainallsub, testallsub)
    
    write.table(dataallsub, file = "./UCI HAR Dataset/mean_std.txt")
    
    ## Get the average of each variable
    average <- aggregate(x = dataall, by = list(dataall$volunteer, dataall$activity), FUN = "mean")
    
    average1 <- merge(activity, average, by.x = "V1", by.y = "activity", all = TRUE)
    
    write.table(average1, file = "./UCI HAR Dataset/average.txt")
    
}