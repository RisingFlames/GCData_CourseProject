library(dplyr)
#Read each of the necessary text files into their own separate data frames
#using the read.table function
xtest = read.table(file="./CleanData/x_test.txt")
ytest = read.table(file="./CleanData/y_test.txt")
xtrain = read.table(file="./CleanData/x_train.txt")
ytrain = read.table(file="./CleanData/y_train.txt")
activityLabels = read.table(file="./CleanData/activity_labels.txt")
featureLabels = read.table(file="./CleanData/features.txt")
subjectTest = read.table(file="./CleanData/subject_test.txt")
subjectTrain = read.table(file="./CleanData/subject_train.txt")

#Assign column names to each of the created data frames to provide
#meangingful descriptions
names(ytest)[1] = "ActivityID"
names(ytrain)[1] = "ActivityID"
names(activityLabels)[1] = "ActivityID"
names(activityLabels)[2] = "ActivityName"
names(subjectTest)[1] = "Subject"
names(subjectTrain)[1] = "Subject"

#Create a veftor from the featureLables data frame
featureLabelsVector = featureLabels[,2]

#Assign the vector created above to each of the following data
#frames to assign column names for the entire data set
colnames(xtest) = featureLabelsVector
colnames(xtrain) = featureLabelsVector

#Combine the subjectTest and xtest data frames together
testData = cbind(subjectTest,xtest)

#Combine the subjectTrain and xtrain data frames together
trainData = cbind(subjectTrain,xtrain)

#Combine the data frame created above with the ytest data frame
testData = cbind(ytest,testData)

#Combine the data frame created above with the ytrain data frame
trainData = cbind(ytrain,trainData)

#Separately merge the training and test data frames to the activityLabels
#data frame to include the ActivityName
testData = merge(x=activityLabels,y=testData,by.x="ActivityID",by.y="ActivityID",all=TRUE)
trainData = merge(x=activityLabels,y=trainData,by.x="ActivityID",by.y="ActivityID",all=TRUE)

#Order the testData and trainData data frames by the Subject and ActivityID
orderedTestData = testData[order(testData$Subject,testData$ActivityID),]
orderedTrainData = trainData[order(trainData$Subject,trainData$ActivityID),]

#Combine the training and test data frames together to create a single data
#repository
allData = rbind(orderedTrainData,orderedTestData)

#Order the new, larger data frame by Subject and ActivityID
orderedAllData = allData[order(allData$Subject,allData$ActivityID),]

#Create a new data frame that pulls out only the columns we want to report on. This
#process includes all columns that include the strings "mean" or "std" in the column
#name.
allMeansStd = orderedAllData[,grepl("Activity|Subject|mean|std",colnames(orderedAllData))]

#Create a final, tidy, data frame that groups the Subject and Activity information with the
#means of each of the individual features we are reporting on
tidyDF = allMeansStd %>% group_by(Subject,ActivityID,ActivityName) %>% summarize_each(funs(mean))

#Write the data frame to a text file
write.table(tidyDF,file="GCData_CourseProject.txt", row.names=FALSE)