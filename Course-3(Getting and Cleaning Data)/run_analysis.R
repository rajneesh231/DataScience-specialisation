# download the zipped data file from the given URL and save it as dat.zip
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"dat.zip")

# This line reads the activity_labels.txt file and stores the data in a 
# data frame called activityLabels
activityLabels <- fread(file.path("UCI HAR Dataset/activity_labels.txt"), col.names = c("classLabels", "activityName"))
activityLabels

# reads the features.txt file and stores the data in a data frame called features
features <- fread(file.path("UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))

# This line extracts the indices of the columns that contain the mean and
# standard deviation measurements.
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
featuresWanted

# These lines extract the names of the columns that contain the mean and 
# standard deviation measurements and remove the parentheses from the names.
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)
measurements

# These lines read the training data files and combine them into a single data frame called train.
train <- fread(file.path( "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]
train

data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path( "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
trainActivities

trainSubjects <- fread(file.path( "UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNum"))
trainSubjects

train <- cbind(trainSubjects, trainActivities, train)
train

# These lines read the test data files and combine them into
# a single data frame called test
test <- fread(file.path( "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
test

data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path( "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
testActivities

testSubjects <- fread(file.path( "UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNum"))
testSubjects

test <- cbind(testSubjects, testActivities, test)
test

# This line combines the train and test data frames into a single 
# data frame called combined
combined <- rbind(train, test)
combined

# This line replaces the activity codes in the Activity column with descriptive activity names.
combined[["Activity"]] <- factor(combined[, Activity] , levels = activityLabels[["classLabels"]], labels = activityLabels[["activityName"]])
combined

# This line converts the SubjectNum column to a factor.
combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])

# These lines reshape the data into a tidy format and calculate 
# the mean of each variable for each activity and each subject.
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)
combined

# This line writes the tidy data set to a file called tidyData.txt
# in the current working directory.
data.table::fwrite(x = combined, file = "tidyData.txt", quote = FALSE)
