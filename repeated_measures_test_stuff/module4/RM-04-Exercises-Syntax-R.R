###
###SETUP
###

###Install packages we will need
###install.packages("nlme")
library(nlme)
###install.packages("ggplot2")
library(ggplot2)
###install.packages("ggthemes")
library(ggthemes)
###install.packages("multcomp")
library(multcomp)
###install.packages("emmeans")
library(emmeans)
###install.packages("car")
library(car)

###Set your working directly to the one containing the data
setwd("C:/Users/Kim__/Dropbox/Workshops/Repeated Measures/Data")

###We will need the training, teachers, and county data sets
###Long versions created in previous modules
### Long County is from RM-03-Exercises-Syntax
training<-read.csv("longtraining.csv",header=T)
county<-read.csv("longcounty.csv",header=T)
teachers<-read.csv("longteachers.csv",header=T)


###
###2. TRAINING, LDL
###


###Unstructured covariance structure, LDL outcome
model<-gls(LDL~as.factor(time)*as.factor(group), data=training, method="ML",
           correlation=corSymm(form=~1|ID), weights=varIdent(form=~1|as.factor(time)))

###Get summary of model
summary(model)
anova(model)
Anova(model,type=3)

###Get variance matrix
cors<-corMatrix(model$modelStruct$corStruct)[[1]]
vars<-c(1,0.59808)^2*model$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs

###Get model means
emmeans(model,"time")


###
###3. TRAINING, HDL
###

####Unstructured covariance structure, HDL outcome
model<-gls(HDL~as.factor(time)*as.factor(group), data=training, method="ML",
           correlation=corSymm(form=~1|ID), weights=varIdent(form=~1|as.factor(time)))

###Get summary of model
summary(model)
anova(model)
Anova(model,type=3)

###Get variance matrix
cors<-corMatrix(model$modelStruct$corStruct)[[1]]
vars<-c(1,0.59808)^2*model$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs

###Get model means
emmeans(model,"time")


###
###4. COUNTY DATA
###

###Create jobs in the 1000 jobs scale
county$JobsK<-county$Jobs/1000

###Create factors for "rural" and "decade"
county$RuralF<-factor(county$Rural)
county$decadeF<-factor(county$decade)

###Unstructured
model1<-gls(JobsK~decadeF*RuralF, data=county, method="REML",
           correlation=corSymm(form=~1|County), weights=varIdent(form=~1|decadeF))

###Get the model summmary
summary(model1)

###Get variance matrix
cors<-corMatrix(model1$modelStruct$corStruct)[[1]]
vars<-c(1,1.11,1.35,1.58,1.83)^2*model1$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs


###Heterogeneous autoregressive
model2<-gls(JobsK~decadeF*RuralF, data=county, method="REML", 
           correlation=corAR1(form=~1|County), weights=varIdent(form=~1|decadeF))

###Get model summary
summary(model2)

###Get variance matrix
cors<-corMatrix(model2$modelStruct$corStruct)[[1]]
vars<-c(1.00000,1.09,1.32,1.52,1.76)^2*model2$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs


##Heterogeneous CS
model3<-gls(JobsK~decadeF*RuralF, data=county, method="REML",
            correlation=corCompSymm(form=~1|County), weights=varIdent(form=~1|decadeF))

###Get model summary
summary(model3) 

###Get variance matrix
cors<-corMatrix(model3$modelStruct$corStruct)[[1]]
vars<-c(1,1.08,1.31,1.52,1.76)^2*model3$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs


###Chosen model with decade as categorical
model4<-gls(JobsK~decadeF*RuralF, data=county, method="ML",
           correlation=corSymm(form=~1|County), weights=varIdent(form=~1|decadeF))

###Get model summary
summary(model4)
Anova(model4,type=3)


###Get variance matrix
cors<-corMatrix(model4$modelStruct$corStruct)[[1]]
vars<-c(1.00000,1.11,1.35,1.58,1.83)^2*model4$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs


###Chosen model with decade as continuous
model5<-gls(JobsK~decade*RuralF, data=county, method="ML",
            correlation=corSymm(form=~1|County),weights=varIdent(form=~1|decadeF))

###Get model summary
summary(model5)
Anova(model5,type=3)

###Get variance matrix
cors<-corMatrix(model5$modelStruct$corStruct)[[1]]
vars<-c(1.00000,1.10,1.35,1.58,1.85)^2*model4$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs


###MAKE A PLOT

###Get means from data
county.means<-aggregate(county$JobsK,by=list(county$Rural,county$decade),FUN=mean)
colnames(county.means)<-c("Rural","decade","JobsK")

###Graph jobs across decades by rural
ggplot(county.means, aes(x=decade, y=JobsK, color=factor(Rural),group=factor(Rural)))+ theme_few()  +
  geom_line()+  scale_color_discrete(name="Rural")+
  scale_x_continuous(breaks = seq(1:5),name="Year", labels=c("1960","1970","1980","1990","2000"))




###
###5. TEACHERS
###

###MAKE SOME PLOTS

###Plot STRS by time
###Get means from data
teachers.means<-aggregate(teachers$STRS,by=list(teachers$time),FUN=mean,na.rm=T)
colnames(teachers.means)<-c("time","STRS")

###Make plot
ggplot(teachers.means, aes(x=time, y=STRS, group=1))+ theme_few()  +
  geom_line()+  scale_x_continuous(breaks = seq(1:3),name="Time") + ylim(100,130)


###Same plot by gender
###Get means from data
teachers.gender.means<-aggregate(teachers$STRS,by=list(teachers$time,teachers$Gender),FUN=mean,na.rm=T)
colnames(teachers.gender.means)<-c("time","gender","STRS")

ggplot(teachers.gender.means, aes(x=time, y=STRS, color=factor(gender)))+ theme_few()  +
  geom_line()+  scale_x_continuous(breaks = seq(1:3),name="Time") + ylim(100,130) + scale_color_discrete(name="Gender",label=c("Girl","Boy"))



###Same plot by t0TchExpCat (as in examples in modules)
teachers$t0TchExpCat<-cut(teachers$t0TchExp,breaks=c(0,3,Inf),include.lowest=F,labels=c(0,1))

###Get means from data
teachers.exp.means<-aggregate(teachers$STRS,by=list(teachers$time,teachers$t0TchExpCat),FUN=mean,na.rm=T)
colnames(teachers.exp.means)<-c("time","t0TchExpCat","STRS")

###Make plot
ggplot(teachers.exp.means, aes(x=time, y=STRS, color=factor(t0TchExpCat)))+ theme_few()  +
  geom_line()+  scale_x_continuous(breaks = seq(1:3),name="Time") + ylim(100,130) + scale_color_discrete(name=("Teacher \n Expectations"))


###RUN MARGINAL MODEL

###Unstructured
model<-gls(STRS~time*t0TchExp + Gender,data=teachers, na.action=na.omit, method="REML",
           correlation=corSymm(form=~1|SubID),weights=varIdent(form=~1|as.factor(time)))


###Get model summary
summary(model)
Anova(model,type=3)

###Get variance matrix
cors<-corMatrix(model$modelStruct$corStruct)[[1]]
vars<-c(1,1.03,1.02)^2*model$sigma^2
covs<-outer(vars,vars,function(x,y) sqrt(x)*sqrt(y))
cors*covs


###Compound symmetry
model<-gls(STRS~time*t0TchExp + Gender,data=teachers,na.action=na.omit,method="REML",
           correlation=corCompSymm(form=~as.factor(time)|SubID))

###Get model summary
summary(model)
Anova(model,type=3)

###Get variance matrix
getVarCov(model)
