#This syntax file creates the examples in the Module 3 lesson videos

###Change the working directory code to where you have the data saved
###Set working directory
setwd("C:/Users/Karen/Dropbox/TAF/Workshops/IRC/data")


###Use read.csv to import the data set
NLSY<-read.csv("NLSY.csv",header=T)
NLSY$MCS2000[NLSY$MCS2000<=100]<- NA 
NLSY$PCS2000[NLSY$PCS2000<=100]<- NA 

################################
## Part 3.1 Quadratic Terms   ##
################################

## Create new variables

NLSY$MCSCen<-NLSY$MCS2000-5000
NLSY$CESDCen<-NLSY$CESD2000Total-3.5
NLSY$EducCen<-NLSY$Education2000-13
NLSY$MCS2000Sq<-NLSY$MCSCen^2 #squared term

###Use the ggplot2 package to plot the quadratic effects
#if you don't already have this package installed remove the # sign and run the code
#install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)


## Scatterplot with regression line
## We're using ggplot b/c it will add the quadratic curve
ggplot(NLSY, aes(x=MCSCen, y=PCS2000)) + geom_point()+stat_smooth(se=F, method='lm', formula=y~x)

## Scatterplot with quadratic curve
ggplot(NLSY, aes(x=MCSCen, y=PCS2000)) + geom_point()+stat_smooth(se=F, method='lm', formula=y~poly(x,2))

## Mental Health linear and quadratic
model1<-lm(PCS2000~MCSCen+MCS2000Sq,data=NLSY)
summary(model1)

## Add covariates
model2<-lm(PCS2000~Education2000+NumberBioStepAdoptChildHH2000+CESD2000Total+MCSCen+MCS2000Sq,data=NLSY)
summary(model2)

############################################################
## Part 3.2 Interactions Between Two Continuous Variables ##
############################################################

plot(NLSY$CESDCen,NLSY$PCS2000,type="p",ylab="PCS2000",xlab="CESDSCen")

## Interaction between Education and Depression (both centered)
model3<-lm(PCS2000~CESDCen*EducCen,data=NLSY)
summary(model3)

## Add covariates
model4<-lm(PCS2000~NumberBioStepAdoptChildHH2000+MCSCen+CESDCen*EducCen,data=NLSY)
summary(model4)


###################################################
## Part 3.3 interactions with quadratic terms    ##
###################################################

## Open the birth data
BIRTH<-read.csv("BIRTH.csv",header=T)

## Center Birth Order, then create squared term
BIRTH$orderCen<-BIRTH$birth_order_cat-3
BIRTH$order_sq<-BIRTH$orderCen*BIRTH$orderCen

##change sex to a categorical variable or factor
BIRTH$sex <-as.factor(BIRTH$sex)

##set reference category
levels(BIRTH$sex)
levels(BIRTH$sex)[1]
BIRTH$sex <-relevel(BIRTH$sex,"2")

model5<-lm(wtgain~sex+orderCen+order_sq+sex:orderCen+sex:order_sq, data=BIRTH)
summary(model5)

##Defining the colors to be different for each value of sex in the aes makes both the points and the curves separate for each sex
ggplot(BIRTH, aes(x=orderCen, y=wtgain, colour = factor(sex))) + geom_point() +stat_smooth(se=F, method='lm', formula=y~poly(x,2))
