# MachineLearning
This repository hosts the source code of the Machine Learning Coursera assignment

## Description
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively.

This document will describe the analysis performed on a dataset containing 5 classes of physical exercises collected over a period of 8 hours for multiple subjects. Details of the experiment can be found at this [link](http://groupware.les.inf.puc-rio.br/har).

We will first load the data locally and clean it up of invalid observation. The data is composed of:
- Training set [dataTrain](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv): 70% of which will be used to create the model and 30% will be used for testing the model before applying it to the given testing set
- Testing set [dataTest](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv)

We will apply a “RandomForest” method to build our prediction. At the end we will run the model on the testing set.
