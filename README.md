JH-course3-project
==================

This repo contains the script, data sets and supporting material for the project assignment of the course 3 of JH course.

The script requires that the following packages be loaded:
- stringr 
- pplyr

The script goes through several steps, which are described here and in comments in the script itself

1. we set up the correct working environment - where the data files are located
2. we load the data in several tables:
  - featuresList
  - testData
  - trainData
3. we do a 1st cleaning of this initial set by
  - adding the names
  - adding a column with the subject who has generated the observation
4. we merge the tarin and test data sets in a single data set (called MergedData)
5. we look for columns which represent means or std (using a word search function from the stringr package), and we subset the dataset with only these values
6. we clculate the mean per subject for each column (using the plyr package)
7. we generate the output files
