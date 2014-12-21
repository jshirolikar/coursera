
The code in run_analysis.R reads the training set, test set, training labels, test labels and binds them together with the cbind function. The rbind function is then used to join training set and test set rows.

The numbers in the Activity column are now replaced with the names WALKING, SITTING, LAYING, STANDING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS using gsub. 

The mean and std columns are extracted to form the finalset data frame. The subset function is used to get Activity, Subject, mean and standard.  Then the aggregate function is used to calculate the average of all the columns as grouped by Activity and Subject.