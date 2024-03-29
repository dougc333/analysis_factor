###
###SETUP
###

###install.packages("lme4")
library(nlme)
library(car)

###set working directory to one with data; a different script creates the "longteachers" data
setwd("C:/Users/Kim__/Dropbox/Workshops/Repeated Measures/Data")

###Input the data
teachers<-read.csv("longteachers.csv",header=T)

###Run the full model
model<-lme(Rapport ~ as.factor(time) + t0TchExp, random = ~ 1|factor(SubID), data=teachers,
            na.action=na.omit,method="ML")

## Run the reduced model 
modelr <- lme(Rapport~1,random = ~ 1| factor(SubID),data = teachers,na.action=na.omit,method="ML")

###Summarize each model, request AIC and BIC
summary(model)
AIC(model)
BIC(model)
-2*logLik(model)

summary(modelr)
AIC(modelr)
BIC(modelr)
-2*logLik(modelr)

#Compute liklihood ratio 
-2*logLik(modelr) -(-2*logLik(model))

