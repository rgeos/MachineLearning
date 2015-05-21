# load necessary libraries
library(caret)
library(randomForest)
library(corrplot)

# set working dir
setwd("MachineLearning/")

# download the data
download.file(url = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", 
              destfile = "pml-training.csv", 
              method = "curl")
download.file(url = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",
              destfile = "pml-testing.csv",
              method = "curl")

# load the data, it seems that there are some invalid entries
# we'll use the 'na.strings' option

dataTrain = read.csv("pml-training.csv", na.strings = c("", "NA", "N/A", "#DIV/0!"))
dataTest  = read.csv("pml-testing.csv", na.strings = c("", "NA", "N/A", "#DIV/0!"))
dim(dataTrain)
dim(dataTest)

# cleanup of the training data, the first 7 variables and those who's entries are NA should be removed
dataTrain = (dataTrain[,colSums(is.na(dataTrain)) == 0])[,-c(1:7)]
dim(dataTrain)

# find the variables with the highest correlation
# the last variable is classes, so we will remove it from the matrix
corMatrix = abs(cor(dataTrain[,-53]))
diag(corMatrix) = 0
which(corMatrix > .95, arr.ind = T)

# correlation plot
corrplot(corMatrix, tl.pos = "ld", type = "lower", method = "shade")

# we will remove coloms for reducing pair-wise correlations
dataTrain = dataTrain[,-c(findCorrelation(corMatrix))]
dim(dataTrain)

# slice the dataTrain in dataTrain_training and dataTrain_testing
set.seed(1234)
partition = createDataPartition(dataTrain$classe, p = .7, list = F)
dataTrain_training  = dataTrain[partition, ]
dataTrain_testing   = dataTrain[-partition, ]

# Random Forests
set.seed(1234)
fit = randomForest(formula = classe ~ ., data = dataTrain_testing)

# predict
pred = predict(fit, dataTrain_testing)
predMatrix = table(pred, dataTrain_testing$classe)
sum(diag(predMatrix))/sum(sum(predMatrix)) # wow 100% accuracy

# validation data
answers = predict(fit, dataTest)


pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(answers)
