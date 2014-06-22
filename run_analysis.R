#The run_analysis function takes no arguments and returns a combined tidy data set.

run_analysis <- function() {
  library(plyr)
  library(car)
  X_train <- read.delim(paste(getwd(), "/UCI_HAR_Dataset/train/X_train.txt", sep=""), header=F, sep="")
  Y_train <- read.delim(paste(getwd(), "/UCI_HAR_Dataset/train/y_train.txt", sep=""), header=F, sep="")
  X_test <- read.delim(paste(getwd(), "/UCI_HAR_Dataset/test/X_test.txt", sep=""), header=F, sep="")
  Y_test <- read.delim(paste(getwd(), "/UCI_HAR_Dataset/test/y_test.txt", sep=""), header=F, sep="")
  varNames <- read.table(paste(getwd(), "/UCI_HAR_Dataset/features.txt", sep=""), header=F, stringsAsFactors=F)
  subject_train <- read.table(paste(getwd(), "/UCI_HAR_Dataset/train/subject_train.txt", sep=""), header=F, stringsAsFactors=F)
  subject_test <- read.table(paste(getwd(), "/UCI_HAR_Dataset/test/subject_test.txt", sep=""), header=F, stringsAsFactors=F)
  
  varNames <- subset(varNames, select=-c(V1))  #remove sequential numbering of features.
  
  subjData <- rbind(subject_train, subject_test)
  colnames(subjData)[1] <- "subject_id"
  
  YData <- rbind(Y_train, Y_test)
  colnames(YData)[1] <- "activity"
  
  XData <- rbind(X_train, X_test)
  for(i in 1:ncol(XData)) {
    colnames(XData)[i] <- as.character(varNames[i,])
  }
  
  allData <- cbind(subjData, YData, XData)  #combines all data into one data.frame 
  allData$activity <- recode(allData$activity, '1="WALKING"; 2="WALKING_UPSTAIRS"; 3="WALKING_DOWNSTAIRS"; 4="SITTING"; 5="STANDING"; 6="LAYING"')
  data_wanted <- allData[,grep("mean\\(\\)|std\\(\\)|activity|subject_id", names(allData))] 
}
