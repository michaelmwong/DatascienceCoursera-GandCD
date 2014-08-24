Course Project for Getting and Cleaning Data
============================================
Script: run_analysis.R
* Initial code
	Download dataset into local directory
	After dataset package is uncompressed, the relevant files are loaded into R.
	There are 3 files from both the "train" and the "test" folders.
* Step 1
	The training and the test sets are merged into a single data file.
	First the 3 files from each folder are combined using column binding (cbind)
	The two resulting files are combined using row binding (rbind)
	Finally the columns are labelled appropriately, with the measurement headings from the "features" file
* Step 2
	Only the measurements on the mean and standard deviation are extracted.
	These were the from the set of variables with mean value "mean()" and standard deviation "std()".
	There are a total of 66 variables.
* Step 3
	Descriptive activity names were added, based on the original numeric code.
	The names are from the "activity-labels" file, which is merged with the single data file.
* Step 4
	The variables are labelled with the appropriate descriptive name.
	To maintain the integrity of the original name, and to update the name for R-compatibility, only
	hyphens "-" and parentheses "()" were removed.
	The list of names can be found in the CodeBook.
* Step 5
	A tidy data set is created, using the average of each variable for each activity and each subject.
	As there are 30 subjects and 6 activities, the total number of rows is 30*6 = 180.
	The final step is to write out the tidy dataset.

