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

mlp<-keras_model_sequential() # a keras sequential model


#defining the parameters and architecture
#adding layers to the model
mlp %>%
  #hidden layer=8 hidden units
  layer_dense(units=8,activation="relu",input_shape=c(10)) %>%
  #output layer
  layer_dense(units=12,activation="softmax") #to compute probabilities
  #softmax activation = exp(y)/exp(y_i)

summary(mlp) #model has 196 params

get_config(mlp)
mlp$layers
get_layer(mlp,index=1)

#information about the layers added
mlp$input
mlp$output

#defining the optimization strategy and the loss function to be used
mlp %>%compile(loss="categorical_crossentropy",
               optimizer="sgd",metrics="accuracy")

#using stochastic gradient descent as optimization strategy to update weights
#the loss function used in classification tasks is crossentropy function


#---------------Trining 

#fitting the model to the data
history<-mlp %>% fit(train_x,train_y,epochs=100,batch_size=5,
                    validation_split=0.2,
                    verbose=1,callbacks=callback_tensorboard(log_dir = "logs/run_a"))
#training with 100 epochs -i.e 100 iterations over the entire data set
#Output
#loss: 0.4268 - acc: 0.8626 - val_loss: 4.4864 - val_acc: 0.2736


#visualizing the Model's training metrics
plot(history)

tensorboard() #using tensorboard visualization



#testing the Model's perfomance on test data set

#predicting labels of new data

classes<- mlp %>% predict_classes(test_x,batch_size=128,verbose=1)
#predicting classes on test data
classes<-data.frame(classes)
#confusion matrix - between test labels and predicted labels on Test set 
table(pred=classes$classes,actual=test_y$y)
mean(classes$classes==test_y$y) #accuracy of 47 % on Test set,i.e 47% correct classifications


#evaluating the Model on Test Set

score<-mlp %>% evaluate(test_x,test_y,batch_size=128,verbose=1)
score
#accuracy of 47 % only , surely we need some improvemets and fine tuning as well
# as hyperparameter tuning too

#saving the model
save_model_hdf5(mlp,"model1")

load_model_hdf5("model1")



#############################################################################
######################--------MODEL2--------#################################

#now I will fine tune the model and change the hyperparameters to improve the
#accuracy of the MLP model

mlp2<-keras_model_sequential()


#defining the architecture

mlp2 %>%#input layer
  layer_dense(units=20,activation="relu",input_shape=c(10)) %>%
  #hidden layers
  layer_dense(units=8,activation="relu") %>%
  #output layer
  layer_dense(units=12,activation="softmax")


#compiling the model
mlp2 %>% compile(loss="categorical_crossentropy",optimizer="adam",metrics="accuracy")

summary(mlp2) #this model has 496 parameters and 3 dense layers , 1 hidden layer

mlp2$weights

#fitting the model with 100 epochs
history1<-mlp2 %>% fit(train_x,train_y,epochs=100,verbose=TRUE,batch_size=10,
                       validation_split=0.2,callbacks=callback_tensorboard(log_dir = "logs/run_b"))

#results after training 1s - loss: 0.3476 - acc: 0.9028 - val_loss: 4.1848 - val_acc: 0.3113
#again the validation accuracy is very less

plot(history1)

score1<-evaluate(mlp2,test_x,test_y,batch_size = 128,verbose=T)
score1 #accuracy reduced to 42%



#---------------------
#Model3


mlp3<-keras_model_sequential()

mlp3 %>% layer_dense(units=5,input_shape=c(10),activation="relu") %>%
          layer_dense(units=12,activation="softmax")




sgd<-optimizer_sgd(lr=0.001)

mlp3 %>% compile(loss="categorical_crossentropy",optimizer=sgd,metrics="accuracy")


history2<-mlp3 %>% fit(train_x,train_y,epochs=200,batch_size=5,validation_split=0.2,
                       verbose=1,callbacks=callback_tensorboard(log_dir = "logs/run_c"))

scor2e<-mlp3 %>% evaluate(test_x,test_y,batch_size=128,verbose=1)
scor2e



#_--------------------------------------------------
#4th model



mlp4<-keras_model_sequential()

mlp4 %>% layer_dense(units=8,input_shape=c(10),activation="relu") %>%
  layer_dense(units=12,activation="softmax")



#learning rate as=0.001

mlp4 %>% compile(loss="categorical_crossentropy",
                 optimizer="adam",metrics="accuracy")


history3<-mlp4 %>% fit(train_x,train_y,epochs=200,batch_size=5,validation_split=0.2,
                       verbose=1,
                       callbacks=callback_tensorboard(log_dir = "logs/run_d"))



scor2e<-mlp3 %>% evaluate(test_x,test_y,batch_size=128,verbose=1)
scor2e
