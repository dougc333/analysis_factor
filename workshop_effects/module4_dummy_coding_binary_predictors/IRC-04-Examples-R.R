#This syntax file creates the examples in the Module 4 lesson videos

###Change the working directory code to where you have the data saved
###Set working directory
setwd("C:/Users/Karen/Dropbox/TAF/Workshops/IRC/data")

##install package emmeans in order to produce marginal means
#if you don't already have this package installed remove the # sign and run the code
#install.packages("emmeans")
library(emmeans)

###Use the car package to get Type III sums of squares
#if you don't already have this package installed remove the # sign and run the code
#install.packages("car")
library(car)

###Use the ggplot2 package to plot the interaction effects
#if you don't already have this package installed remove the # sign and run the code
#install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)

###Use read.csv to import the data set
NLSY<-read.csv("NLSY.csv",header=T)


#######################################
## Part 4.1 DUMMY AND EFFECT CODING  ##
#######################################

##Create dummy and effect coded versions of Poverty Status
NLSY$PovertyD<- NA
NLSY$PovertyE<- NA
NLSY$PovertyStatus2000c2[NLSY$PovertyStatus2000c2==1]<- NA   

NLSY$PovertyD[NLSY$PovertyStatus2000c2==2]<- 1 
NLSY$PovertyE[NLSY$PovertyStatus2000c2==2]<- 1 

NLSY$PovertyD[NLSY$PovertyStatus2000c2==3]<-0 
NLSY$PovertyE[NLSY$PovertyStatus2000c2==3]<- -1 

##Center numeric variables
NLSY$MCSCen<-NLSY$MCS2000-5000
NLSY$CESDCen<-NLSY$CESD2000Total-3.5
NLSY$CESD13_5<-NLSY$CESD2000Total-13.5

##Scatterplot between PCS and Poverty Status, Effect Coded
plot(NLSY$PovertyE,NLSY$PCS2000,type="p",ylab="PCS2000",xlab="Poverty type E")
abline(lm(NLSY$PCS2000 ~ NLSY$PovertyE))
abline(v=0)

##Scatterplot between PCS and Poverty Status, Dummy Coded
plot(NLSY$PovertyD,NLSY$PCS2000,type="p",ylab="PCS2000",xlab="Poverty type D")
abline(lm(NLSY$PCS2000 ~ NLSY$PovertyD))
abline(v=0)

#############################################
## Part 4.2 Dummy Coding Binary Predictors ##
#############################################

##Define original Poverty status variable as categorical
NLSY$PovertyStatus2000c2 <-as.factor(NLSY$PovertyStatus2000c2)

##Find the default dummy coding then change it
##This is only needed to match the slides example. If you prefer the first 
##category to be the reference group, you don't need to relevel the factor.
levels(NLSY$PovertyStatus2000c2)
NLSY$PovertyStatus2000c2 <-relevel(NLSY$PovertyStatus2000c2,"3")##set reference category

model1 <-lm(PCS2000~PovertyStatus2000c2,data=NLSY)
Anova(model1) #Gives ANOVA table with Type III sums of squares
summary(model1) #Gives regression coefficients
model1.means<-emmeans(model1,~PovertyStatus2000c2) #calculates marginal means
model1.means #Gives the the marginal means
pairs(model1.means) #contrast for mean difference

## Add Depression as a numerical predictor
model2 <-lm(PCS2000~PovertyStatus2000c2+CESDCen,data=NLSY)
Anova(model2)
summary(model2)

scatterplot(x=NLSY$CESDCen,y=NLSY$PCS2000,groups=NLSY$PovertyStatus2000c2, regLine=FALSE, smooth=FALSE, xlab="Depression Centered at its Mean", ylab="Physical Health Composite Score")
abline(a=5247,b=-56,col="blue") #not in poverty
abline(a=4894,b=-56,col="pink") #in poverty
abline(v=0)


##############################################################
## Part 4.3 Interactions with Dummy Coded Binary Predictors ##
##############################################################

##Add in Interaction between Poverty Status and Depression
model3 <-lm(PCS2000~PovertyStatus2000c2*CESDCen,data=NLSY)
Anova(model3, type=3)
summary(model3)
emmeans(model3,~PovertyStatus2000c2,at=list(CESDCen=c(0)))
pairs(emmeans(model3,~PovertyStatus2000c2,at=list(CESDCen=c(0))))

emmeans(model3,~PovertyStatus2000c2,at=list(CESDCen=c(10)))
pairs(emmeans(model3,~PovertyStatus2000c2,at=list(CESDCen=c(10))))

##Defining the colors to be different for each Poverty Status in the aes makes 
##both the points and the lines separate for each Poverty Status
ggplot(NLSY, aes(x=CESDCen, y=PCS2000, colour = factor(PovertyStatus2000c2))) + geom_point() +stat_smooth(se=F, method='lm', formula=y~x, fill=NA)

##############################################################
## Part 4.5 Interactions with Dummy Coded Binary Predictors ##
##           Binary Variable is Key Variable                ##
##############################################################

##Compare to a model with depression centered at 13.5

model4 <-lm(PCS2000~PovertyStatus2000c2*CESD13_5,data=NLSY)
summary(model4)

