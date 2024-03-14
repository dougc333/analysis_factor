##########################################################################
##This syntax file creates the examples in the Module 5 lesson videos
##########################################################################

###Change the working directory code to where you have the data saved
###Set working directory
setwd("/Users/dc/analysis_factor")

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
NLSY<-read.csv("/Users/dc/analysis_factor/datasets_irc_workshop/NLSY.csv",header=T)

NLSY$CESDCen<-NLSY$CESD2000Total-3.5
NLSY$PovertyStatus2000c2[NLSY$PovertyStatus2000c2==1]<- NA   

##5.1 Dummy Coding Categorical Predictors: Multiple Categories

##Marital Status only




NLSY$Marital2000c5<-as.factor(NLSY$Marital2000c5)
NLSY$Marital2000c5 <-relevel(NLSY$Marital2000c5,"5")##set reference category

model1 <-lm(PCS2000~Marital2000c5,data=NLSY)
Anova(model1, type = 3)
summary(model1)
emmeans(model1,~Marital2000c5)

##create so we can add to graph
ms.emm<-as.data.frame(emmeans(model1,~Marital2000c5))

##PCS by Marital Status plot
##to get a scatterplot, change Martial status back to numeric. 
##otherwise, you'll get side-by-side boxplots
NLSY$Marital2000c5<-as.numeric(NLSY$Marital2000c5)
plot(NLSY$Marital2000c5,NLSY$PCS2000,type="p",ylab="PCS2000",xlab="MARITAL STATUS")
lines(ms.emm,type="o",col="orange",pch=16)


########################################
## Part 5.2 Add a Numerical Predictor ##
########################################

##Depression and Marital Status

NLSY$Marital2000c5<-as.factor(NLSY$Marital2000c5)
model2 <-lm(PCS2000~Marital2000c5+CESDCen,data=NLSY)
Anova(model2,type=3)
summary(model2)


scatterplot(x=NLSY$CESDCen,y=NLSY$PCS2000,groups=NLSY$Marital2000c5, regLine=FALSE, smooth=FALSE, ylab="Depression Centered at its Mean",xlab="Physical Health Composite Score")
abline(a=5112,b=-63,col="grey") #never married
abline(a=4966,b=-63,col="cyan") #widowed
abline(a=5239,b=-63,col="orange") #married
abline(a=5188,b=-63,col="magenta") #divorced
abline(a=5033,b=-63,col="blue") #separated



####################################################################
## Part 5.3 Interactions with Dummy Coded Categorical Predictors  ##
####################################################################

##Add in Interaction between Marital Status and Depression

scatterplot(x=NLSY$CESDCen,y=NLSY$PCS2000,groups=NLSY$Marital2000c5, smooth=FALSE, ylab="Depression Centered at its Mean",xlab="Physical Health Composite Score")

model3 <-lm(PCS2000~Marital2000c5+CESDCen+Marital2000c5*CESDCen,data=NLSY)
Anova(model3, type=3)
summary(model3)

emmean1<- emmeans(model3,~Marital2000c5|by(CESDCen),
                  at=list(CESDCen=c(-3,0,3,6,9,12,15)))
emmean1

## plotting the marginal means
emmean1.means<-summary(emmean1)[,c("Marital2000c5","CESDCen","emmean")]

#number of children on the x axis
ggplot(emmean1.means,aes(x=CESDCen,y=emmean,color=as.factor(Marital2000c5),group=as.factor(Marital2000c5))) + 
  geom_point() + geom_line() +
  ylab("Estimated Mean PCS")  +  ggtitle("Marginal mean of PCS2000") + 
  scale_color_discrete(name="Marital2000c5")


at0.emm<-emmeans(model3,~Marital2000c5,at=list(CESDCen=c(0)))
pairs(at0.emm) #These pvalues are tukey adjusted so don't match slides.

emmeans(model3,~Marital2000c5,at=list(CESDCen=c(10)))
at10.emm<-emmeans(model3,~Marital2000c5,at=list(CESDCen=c(10)))
pairs(at10.emm) #These pvalues are tukey adjusted so don't match slides.

##############################################################
## Part 5.4 Interactions between Two Dummy-Coded Predictors ##
##############################################################

##Poverty Status and Gender

NLSY$PovertyStatus2000c2 <-as.factor(NLSY$PovertyStatus2000c2)
levels(NLSY$PovertyStatus2000c2)

NLSY$PovertyStatus2000c2 <-relevel(NLSY$PovertyStatus2000c2,"3") #set reference group
levels(NLSY$PovertyStatus2000c2)

NLSY$Gender<-as.factor(NLSY$Gender)

levels(NLSY$Gender)
NLSY$Gender <-relevel(NLSY$Gender,"2") #set reference group

model4 <-lm(PCS2000~PovertyStatus2000c2*Gender,data=NLSY)
Anova(model4, type=3)
summary(model4)

#marginal means
emmean2<- emmeans(model4,~PovertyStatus2000c2*Gender)
emmean2


## plotting the marginal means
emmean2.means<-summary(emmean2)[,c("PovertyStatus2000c2","Gender","emmean")]

#number of children on the x axis
ggplot(emmean2.means,aes(x=PovertyStatus2000c2,y=emmean,color=as.factor(Gender),group=as.factor(Gender))) + 
  geom_point() + geom_line() +
  ylab("Estimated Mean PCS")  +  ggtitle("Marginal mean of PCS2000") + 
  scale_color_discrete(name="Gender")


