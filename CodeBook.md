This CodeBook File describes the variables and steps used for data transformation used in the run_analysis.R file.

**Preparation Phase:**

-   *Samsung.zip*: downloaded dataset from "<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>";

    unzipped to "UCI HAR Dataset"

-   *features*: features read from "UCI HAR Dataset/features.txt"; the 2nd column given name "feature_code"

-   *activities*: activities read from "UCI HAR dataset/activity_labels.txt"; the 1st column given name "class_label", the 2nd column given name "activity

-   *subject_train*: subjects read from "UCI HAR dataset/train/subject_train.txt"; given column name "subject_id"

-   *x_train*: a table read from "UCI HAR dataset/train/X_train.txt", columns are named by the feature_code in the *features* table.

-   *y_train*: read from "UCI HAR dataset/train/y_train.txt", column given name "label"

-   *subject_test*, *x_test* and *y_test* are constructed in the same way above using test data read from "UCI HAR dataset/test"

**Step 1: Merges the training and the test sets to create one data set.**

-   *mergedSubject*: merged subject_train and subject_test

-   *mergedx*: merged x_train and x_test

-   *mergedy*: merged y_train and y_test

-   *merged_data*: (10299 rows, 563 columns) merged *mergedSubject*, *mergedx* and *mergedy*

**Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.**

-   *extractedHAR*: (10299 rows, 88 columns) extracted from *merged_data* to contain only measures on mean and standard deviation.

**Step 3: Uses descriptive activity names to name the activities in the data set**

-   the class labels of activity in the *label* column of *extractedHAR* was matched to the *activity* column in *activities*.

**Step 4: Appropriately labels the data set with descriptive variable names.**

-   the column name of "label" changed to "activity"

-   "mean()" in all column names were changed to "mean"

-   "std()" in all column names were changed to "standard deviation"

-   "BodyAcc" in all column names were changed to "body acceleration"

-   "GravityAcc" in all column names were changed to "gravity acceleration"

-   "BodyGyro" in all column names were changed to "body gyroscope"

-   "Jerk" in all column names were changed to " jerk signal"

-   "Mag" in all column names were changed to " magnitude"

-   "gravityMean" in all column names were changed to " gravity mean"

-   "Bodybody" in all column names were changed to "body"

-   "t" at the beginning of column names were changed to "time "

-   "f" at the beginning of column names were changed to "frequency "

**Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

-   *groupeddata*: data grouped by *subject_id* and *activity* from *extractedHAR*

-   *tidydata*: average of each variable from *groupeddata*.

-   final tidy data.txt: final exported .txt file from *tidydata*
