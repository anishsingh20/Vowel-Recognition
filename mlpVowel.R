#requireing the data and the packages to build a multi layer preceptron Model

require(ElemStatLearn)#contains the dataset
require(keras)#a deep learning package which uses tensorflow as a backend
#mathematical computation engine .
#tensorflow is a package which consists of data flow graphs , to perform mathematical
#ops , where each node represents a math operator and and edge represents a tensor
#A tensor is simply a multi-dimentional array.


#checking the dimentions of test and train data

cat("The dimentions of Train data set is:",dim(vowel.train))
cat("The dimentions of Test data set is:",dim(vowel.test))

#train data
train_x<-vowel.train[-1]#the inputs or predictors
train_y<-vowel.train[1]#the class labels of target vector

head(vowel.train)

#converting the data to matrix format to feed it to a MLP 

