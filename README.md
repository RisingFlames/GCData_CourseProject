# GCData_CourseProject

For the Getting and Cleaning Data Course Project I have created a single R file with
all of the steps performed to create a tidy data set.

Each step is a simple command so that it is easy to follow along with and understand
the process that I followed to create my tidy data set.

I started with each text file and imported them into their own data frames. Then I 
added column names manually to the data frames that only had one or two columns.

To add column names for the x_test and x_train data frames I first created a data frame
of the features text file, extracted out the second column of the feature names into a 
vector, and then assigned that entire vector to each of the X Files (sorry, had to make
that reference since it is coming back to TV. :)) This assignment then created column 
names for each of the columns in the file.

I then added the Subject data frames to each of their corresponding test/train files 
with the cbind function. Then I used the same data frame to add the Y files using the 
cbind function again. 

I then used the merge function to combine the activityLabels data frame to the larger
data frame so that there would be the names of the activites added to the data frame.

The next step was to order the testData and trainData data frames by the Subject and
ActivityID and the combine them together into the allData data frame using the rbind
function.

The allData data frame was then ordered once again by the Subject and ActivityID to
ensure the subjects were aligned correctly.

The next to last step was to pull out only the columns that were needed, in this case
the Activity, Subject, Means, and Standard Deviations, into their own data frame. This
process includes all columns that include the strings "mean" or "std" in the column
name.

The final step was to use the group_by function to group by Subject, ActivityID, and
ActivityName and then pipe that to the summarize_each function that called the mean 
function to create the tidy data frame. 

This final data frame lists each subject, and the six activites they participated in, 
with the average of each of the features that were extracted out of the full data frames.
It is then written to a text file.