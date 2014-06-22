cleaningdataproject
===================

getting and cleaning data class project

run_analysis() will pull in from the working directory the required data sets.  
Cleaning the data will consist of checking for NA's, combing the seperate data sets
and renaming the variables to something more appropriate.  Activity categories are 
given descriptive names.  The mean and standard deviation data is then extracted into 
a data frame and reshaped along the activity and subject_id variables.  The average 
is then calculated for each subject, activity and variable.
