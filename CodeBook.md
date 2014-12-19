##CookBook
###Introduction

The script run_analysis.R performs the 5 steps described in the course project's definition.
The data is present in 2 directory, train and test, which have been randomly partitioned, where 70% of the volunteers was selected for generating the training data and 30% the test data.
Both Test datasets and Train datasets have been combined into a single data frame with volunteer and Activity Code data added to datasets. 
Then the two datasets have been combined together in a large dataset using rbind().
The mean and std variables are filtered out with Subject and Activity into a new dataset, all.mean_std. This dataset is then merged with Activity labels to create a new data frame. 
This new data frame is melted and broken down using dcast function to get the required results. 

###Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
test.all variable has merged datasets: X_test, y_test and subject_test
train.all variable has merged datasets: X_train, y_train and subject_train
all: merged test and train datasets
all.mean_std: mean and std extracted from all datasets including subject and activity.
all.merged: merged datasets all.mean_std and activityLabels to include activity description in the dataset.
mean_data: has transformed (melt and dcast) to get the desired ourput. 
