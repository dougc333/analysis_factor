#This syntax file creates the examples in the Module 2 lesson videos

###Change the working directory code to where you have the data saved
###Set working directory
setwd("/Users/dc/analysis_factor")

#if you don't already have this package installed remove the # sign and run the code
#install.packages("psych")
library(psych)

###Use read.csv to import the data set
NLSY<-read.csv("/Users/dc/analysis_factor/datasets_irc_workshop/NLSY.csv",header=T)
nrow(NLSY)
ncol(NLSY)
hist(NLSY$PCS2000)
colnames(NLSY)

#plot MCS2000, this is 1-21? no.  
sapply(NLSY, class)
hist(NLSY$MCS2000)
#these dont work
min(NLSY$MCS2000,rm.NA=TRUE)
max(NLSY$MCS2000, rm.NA=TRUE)
mean(NLSY$MCS2000, rm.NA=TRUE)

#################
##2.2 Centering
#################

# -------------------------------------------------------------------------


##Mental Health Composite Score
NLSY$MCSCen<-NLSY$MCS2000-5280.05

##Look at descriptives to see what centering does
describe(NLSY$MCS2000, na.rm=TRUE)
describe(NLSY$MCSCen, na.rm=TRUE)

##Uncentered Mental Health Composite Score
model1<-lm(PCS2000~MCS2000,data=NLSY)
summary(model1)

plot(NLSY$MCS2000,NLSY$PCS2000,type="p",xlim=c(0,7000),ylab="Physical Health Composite Score",xlab="Mental Health Composite Score") 
abline(lm(NLSY$PCS2000 ~ NLSY$MCS2000))
abline(v=0) #add vertical line at 0

##Centered Mental Health Composite Score
model2<-lm(PCS2000~MCSCen,data=NLSY)
summary(model2)

plot(NLSY$MCSCen,NLSY$PCS2000,type="p",ylab="Physical Health Composite Score",xlab="Centered Mental Health Composite Score") 
abline(lm(NLSY$PCS2000 ~ NLSY$MCSCen)) #add regression line
abline(v=0) #add vertical line at 0


##Years of Education
mean(NLSY$Education2000) #calculate the mean

plot(NLSY$Education2000,NLSY$PCS2000,type="p",ylab="Physical Health Composite Score",xlab="Years of Education") 
abline(lm(NLSY$PCS2000 ~ NLSY$Education2000)) #add regression line
abline(v=0) #add vertical line at 0
abline(v=12) #add vertical line at 12
abline(v=13.05) #add vertical line at the mean

NLSY$EducCen<-NLSY$Education2000-12  #Center at 12

#Depression Score
hist(NLSY$CESD2000Total, nclass=21)
mean(NLSY$CESD2000Total)

plot(NLSY$CESD2000Total,NLSY$PCS2000,type="p",ylab="Physical Health Composite Score",xlab="Depression Score 0-21 Center for Epi Study") 
abline(lm(NLSY$PCS2000 ~ NLSY$CESD2000Total)) #add regression line
abline(v=0) #add vertical line at 0
abline(v=3.5) #add vertical line at the mean 3.5
abline(v=16) #add vertical line at the clinical cutoff 16

NLSY$CESDCen<-NLSY$CESD2000Total-3.5  #Center at the mean

##Multiple regression on uncentered variables
model3<-lm(PCS2000~Education2000+NumberBioStepAdoptChildHH2000+CESD2000Total+MCS2000,data=NLSY)
summary(model3)

##Multiple regression on centered variables
model4<-lm(PCS2000~EducCen+NumberBioStepAdoptChildHH2000+CESDCen+MCSCen,data=NLSY)
summary(model4)

#################
##2.3 Rescaling
#################

##Birth weight already has variables in the data set both in pounds and in ounces;
##Gestation is in the data set in weeks so we are changing it to days by multiplying by 7;

BIRTH<-read.csv("/Users/dc/analysis_factor/datasets_irc_workshop/BIRTH.csv",header=T)




BIRTH$gestation_days<-BIRTH$gestation*7

##look at the first 10 values of original and rescaled variables
head(BIRTH$bwt,n=10)
head(BIRTH$bwt_pnds,n=10)
head(BIRTH$gestation,n=10)
head(BIRTH$gestation_days,n=10)

##Scatter plots of original and rescaled variables
plot(BIRTH$gestation,BIRTH$bwt_pnds,type="p",ylab="Birth Weight in Pounds",xlab="Gestation in Weeks")
abline(lm(BIRTH$bwt_pnds ~ BIRTH$gestation))

plot(BIRTH$gestation_days,BIRTH$bwt,type="p",ylab="Birth Weight in Ounces",xlab="Gestation in Days")
abline(lm(BIRTH$bwt ~ BIRTH$gestation_days))

##Regression of original and rescaled variables
model5<-lm(bwt_pnds~gestation,data=BIRTH)
summary(model5)

model6<-lm(bwt~gestation_days,data=BIRTH)
summary(model6)


#################################
##2.4 Standardized Coefficients
#################################

###Use the lm.beta package to get standardized regression coefficients
#if you don't already have this package installed remove the # sign and run the code
#install.packages("lm.beta")

library(lm.beta)

model7<-lm(PCS2000~CESD2000Total+Education2000+NumberBioStepAdoptChildHH2000+MCS2000,data=NLSY)
model7.1<-lm.beta(model7)
summary(model7.1)


#################################
##2.5 Nonlinear Transformations
#################################

##the log function creates a natural log;
##the sqrt function creates a square root;

BIRTH$ln_last_preg<-log(BIRTH$last_preg)
BIRTH$inv_last_preg<-1/(BIRTH$last_preg)
BIRTH$sqrt_last_preg<-  (BIRTH$last_preg)
BIRTH$ln_pre_wgt<-log(BIRTH$pre_wgt)

##scatterplots for untransformed, square root, and natural log against mother's age
plot(BIRTH$mage,BIRTH$last_preg,type="p",ylab="last_preg",xlab="Mother's Age")
abline(lm(BIRTH$last_preg ~ BIRTH$mage))

plot(BIRTH$mage,BIRTH$sqrt_last_preg,type="p",ylab="sqrt_last_preg",xlab="Mother's Age")
abline(lm(BIRTH$sqrt_last_preg ~ BIRTH$mage))

plot(BIRTH$mage,BIRTH$ln_last_preg,type="p",ylab="ln_last_preg",xlab="Mother's Age")
abline(lm(BIRTH$ln_last_preg ~ BIRTH$mage))

##histograms of untransformed, square root, and natural log of months since last pregnancy
hist(BIRTH$last_preg)
hist(BIRTH$sqrt_last_preg)
hist(BIRTH$ln_last_preg)

##Square Root transformation on Y
model8<-lm(sqrt_last_preg~mage+pre_wgt,data=BIRTH)
summary(model8)

##Natural log transformation on Y
model9<-lm(ln_last_preg~mage+pre_wgt,data=BIRTH)
summary(model9)

##Natural log transformation on X
model10<-lm(last_preg~mage+ln_pre_wgt,data=BIRTH)
summary(model10)

plot(BIRTH$ln_pre_wgt,BIRTH$last_preg,type="p",ylab="Months Since Last Pregnancy",xlab="ln_pre_wgt")
abline(lm(BIRTH$last_preg ~ BIRTH$ln_pre_wgt))

##Natural log transformation on both Y and X
model11<-lm(ln_last_preg~mage+ln_pre_wgt,data=BIRTH)
summary(model11)

plot(BIRTH$ln_pre_wgt,BIRTH$ln_last_preg,type="p",ylab="ln_last_preg",xlab="ln_pre_wgt")
abline(lm(BIRTH$ln_last_preg ~ BIRTH$ln_pre_wgt))

