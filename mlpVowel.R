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

#checking the summary statistics
summary(vowel.train)


#train data
train_x<-vowel.train[-1]#the inputs or predictors
train_y<-vowel.train[1]#the class labels of target vector

#the class labels are the 11 steady state vowels used in British English


#Test data
test_x<-vowel.test[-1]
test_y<-vowel.test[1]

#converting to matrix format
train_x<-as.matrix(train_x)
test_x<-as.matrix(test_x)
train_y<-as.matrix(train_y)
test_y<-as.matrix(test_y)

#comverting Target values to one-hot encoding i.e binary class matrix
train_y<-to_categorical(train_y,num_classes = 12) 
test_y<-to_categorical(test_y,num_classes = 12)


#-----------------------

#defining the keras model

mlp<-keras_model_sequential() # a keras sequqntial model








