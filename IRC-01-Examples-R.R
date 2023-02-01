#This syntax file creates the examples in the Module 1 lesson videos

###Change the working directory code to where you have the data saved
###Set working directory
setwd("C:/Users/Karen/Dropbox/TAF/Workshops/IRC/data")


###Use read.csv to import the data set
NLSY<-read.csv("NLSY.csv",header=T)

###Use the psych package to get p-values for correlations
#if you don't already have this package installed remove the # sign and run the code
#install.packages("psych")
library(psych)

##Part 1.1 Review of Simple Linear Regression

###scatter plot

plot(NLSY$CESD2000Total,NLSY$PCS2000,type="p",ylab="PCS2000",xlab="CESD2000TOTAL") 
#add the regression line
abline(lm(NLSY$PCS2000 ~ NLSY$CESD2000Total))

##Simple regression
##the lm command runs linear models
model1<-lm(PCS2000~CESD2000Total,data=NLSY)
summary(model1)

##Part 1.2 Review of Multiple Linear Regression

model2<-lm(PCS2000~CESD2000Total+Education2000+NumberBioStepAdoptChildHH2000+MCS2000,data=NLSY)
summary(model2)

##Correlation table
corr.test(NLSY[,c("CESD2000Total", "Education2000", "NumberBioStepAdoptChildHH2000", "MCS2000")], use="pairwise.complete.obs")


