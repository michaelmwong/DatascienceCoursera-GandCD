## Code to download data
target_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
target_localfile = "UCI_HAR_Dataset.zip"
if (!file.exists(target_localfile)) {
    download.file(target_url, target_localfile) #may need modifying if binary etc
    library(tools)       # for md5 checksum
    sink("download_metadata.txt")
    print("Download date:")
    print(Sys.time() )
    print("Download URL:")
    print(target_url)
    print("Downloaded file Information")
    print(file.info(target_localfile))
    print("Downloaded file md5 Checksum")
    print(md5sum(target_localfile))
    sink()
}
setwd("~/Coursera/Getting and Cleaning Data/data")
activity_labels=read.table("activity_labels.txt")
X_test=read.table("./test/X_test.txt")
y_test=read.table("./test/y_test.txt")
subject_test=read.table("./test/subject_test.txt")
X_train=read.table("./train/X_train.txt")
y_train=read.table("./train/y_train.txt")
subject_train=read.table("./train/subject_train.txt")
features=read.table("features.txt", stringsAsFactors=FALSE)
#
# Step 1 Merge the training and test sets
#
DataTrain=cbind(subject_train, y_train, X_train)
DataTest=cbind(subject_test, y_test, X_test)
mergedData=rbind(DataTrain, DataTest)
## Add column names
colnames(mergedData)=c("subject", "activity", features$V2)
#
# Step 2 Extract only the measurements on the mean and standard deviation
#
mean_std=mergedData[,c(1:2,grep("mean\\(\\)|std\\(\\)",names(mergedData)))]
#
# Step 3 Use descriptive activity names
#
colnames(activity_labels)=c("activity","Activity")
mean_std_2=merge(activity_labels,mean_std,by.x="activity",by.y="activity",all=TRUE)
mean_std_2$activity=NULL
#
# Step 4 Appropriately label with descriptive variable names
#
colnames(mean_std_2)=gsub("-|\\()","",names(mean_std_2))
#
# Step 5 Create tidy data set with average of each variable for each activity and each subject
#
attach(mean_std_2)
tidy_data <- aggregate(mean_std_2[,3:68], by = list(Activity=mean_std_2$Activity,subject=mean_std_2$subject), FUN = mean)
detach(mean_std_2)
#
# Write out tidy dataset
write.table(tidy_data,"./tidydata.txt",sep=" ",row.names=FALSE)