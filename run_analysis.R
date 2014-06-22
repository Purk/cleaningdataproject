#The run_analysis function takes no arguments and returns a combined tidy data set.

run_analysis <- function() {
  library(plyr)
  library(car)
  library(reshape2)
  X_train <- read.delim(getwd(), header=F, sep="")
  Y_train <- read.delim(getwd(), header=F, sep="")
  X_test <- read.delim(getwd(), header=F, sep="")
  Y_test <- read.delim(getwd(), header=F, sep="")
  varNames <- read.table(getwd(), header=F, stringsAsFactors=F)
  subject_train <- read.table(getwd(), sep=""), header=F, stringsAsFactors=F)
  subject_test <- read.table(getwd(), header=F, stringsAsFactors=F)
  
  #remove sequential numbering of features.
  varNames <- subset(varNames, select=-c(V1))
  
  #combine on the rows of training and test data and insert appropriate column headers
  subjData <- rbind(subject_train, subject_test)
  colnames(subjData)[1] <- "subject_id"
  
  YData <- rbind(Y_train, Y_test)
  colnames(YData)[1] <- "activity"
  
  XData <- rbind(X_train, X_test)
  for(i in 1:ncol(XData)) {
    colnames(XData)[i] <- as.character(varNames[i,])
  }
  
  #combine on the columns all the data into one data.frame
  allData <- cbind(subjData, YData, XData)
  
  #change the numeric activities code to something meaningful
  allData$activity <- recode(allData$activity, '1="WALKING"; 2="WALKING_UPSTAIRS"; 3="WALKING_DOWNSTAIRS"; 4="SITTING"; 5="STANDING"; 6="LAYING"')
 
  #Extract only the measurements on the mean and standard deviation for each measurement.
  data_wanted <- allData[,grep("mean\\(\\)|std\\(\\)|activity|subject_id", names(allData))] 
  
  #Create a data set with the average of each variable for each activity and each subject.
  molten <- melt(data_wanted, id.vars=c("activity", "subject_id"))
  molten_mean <- dcast(data=molten, subject_id+activity ~ variable, FUN=mean)
}
