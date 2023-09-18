###
### SETUP
###

###Load packages (install first if needed!)
###install.packages("lme4")
library(lme4)
###install.packages("emmeans")
library(emmeans)
###install.packages("lmerTest")
library(lmerTest)
###install.packages("ggplot2")
library(ggplot2)
###install.packages("ggthemes")
library(ggthemes)

###Set working directory to the one containing the data
setwd("C:/Users/Kimberly love/Dropbox/Analysis Factor/Workshops/Repeated Measures/Data")

###Read in the data
teachers<-read.csv("longteachers.csv",header=T)
training<-read.csv("longtraining.csv",header=T)
swallow<-read.csv("swallowing.csv",header=T)


###
### TEACHERS DATA
###

###Empty model with random intercept
model1<-lmer(Rapport~1+(1|SubID),data=teachers)
summary(model1)
-2*logLik(model1)
BIC(model1)

###Scatterplot with overall intercept
ggplot(na.exclude(teachers), aes(x=time, y=Rapport, color=factor(SubID)))+ geom_point() +
  geom_hline(yintercept=3.1795) + scale_color_discrete(name="Subject ID")+ theme_few()+
  scale_x_continuous(breaks = seq(1:3),name="Time") + guides(color="none")

###Add time as a continuous fixed effect
###NOTE: anova should run from the lmerTest package, if you have any trouble re-library lmerTest
model2<-lmer(Rapport~time+(1|SubID),data=teachers)
anova(model2) 
summary(model2)
-2*logLik(model2)
BIC(model2)

###Scatterplot with overall linear trajectory
ggplot(na.exclude(teachers), aes(x=time, y=Rapport, color=factor(SubID)))+ geom_point() +
  geom_abline(intercept=3.64751, slope=-0.23403) + scale_color_discrete(name="Subject ID")+ theme_few()+
  scale_x_continuous(breaks = seq(1:3),name="Time") + guides(color="none")


###Add Summertime Expectancies and its interaction with time as fixed effects.
model3<-lmer(Rapport~ time*t0TchExp+(1|SubID),data=teachers)
anova(model3)
summary(model3)
-2*logLik(model3)
BIC(model3)


###
### PHYSICAL TRAINING
###

###Make time and group factors in data
training$time=as.factor(training$time)
training$group=as.factor(training$group)

###Empty model (with random intercept)
model1<-lmer(BMI~1+(1|ID),data=training,na.action=na.omit)
summary(model1)
-2*logLik(model1)
BIC(model1)

###Scatterplot with overall intercept
ggplot(na.exclude(training), aes(x=time, y=BMI, color=factor(ID)))+ geom_point() +
  geom_hline(yintercept=22.5166) + theme_few()+ scale_x_discrete(name="Time") + guides(color="none")


###full model with time and group included as fixed effects
model2<-lmer(BMI~time*group+(1|ID),data=training,na.action=na.omit)
anova(model2)
summary(model2)
-2*logLik(model2)
BIC(model2)

lsmeansLT(model2,test.effs="time:group")

###Scatterplot paneled by group with 
ggplot(na.exclude(training), aes(x=as.numeric(time), y=BMI, color=factor(ID)))+ geom_point() + facet_wrap("group") +
  geom_smooth(method=lm,se=FALSE, color=1) + theme_few()+ scale_x_continuous(breaks = seq(1:2),name="Time") +
  guides(color="none")



###Similar marginal model created with compound symmetry 
library(nlme)
model10<-gls(BMI~time*group,data=training,
             correlation=corCompSymm(form=~1|ID),
             na.action=na.omit,control=list(apVar=T))

###Note that degrees of freedom are not adjusted properly relative to random intercept model
anova(model10)
summary(model10)
getVarCov(model10)

-2*logLik(model10) ###Same
BIC(model10) ###Different

###Again, same but DF not adjusted
emmeans::emmeans(model10, "time", by="group")



###
### SWALLOWING DATA
###

###Reduce the data by removing AMAXTP and keeping only anterior bulb
swallow<-subset(swallow,Task!="AMAXTP")
swallow<-subset(swallow,Bulb=="A")

###Make "task" a factor in the data set
swallow$Task<-factor(swallow$Task)

###Put rise close in cm instead of mm
swallow$RiseSlopecm<-swallow$RiseSlope/10

###Create numeric version of task for graphing purposes
swallow$Task.num<-rep(c(rep(1,5),rep(2,5),rep(3,5),rep(4,5),rep(5,5),rep(6,5),
                       rep(7,5),rep(8,5),rep(9,5),rep(10,5),rep(11,5)),19)


###Empty model (with random intercept)
model1<-lmer(RiseSlopecm~1+(1|ParticipantID),data=swallow,na.action=na.omit)
summary(model1)
-2*logLik(model1)
BIC(model1)


ggplot(swallow, aes(x=Task.num, y=RiseSlopecm, color=factor(ParticipantID))) +geom_point() +
  geom_hline(yintercept=39.805) + theme_few() + guides(color="none") +
  scale_x_continuous(breaks = seq(1:11), labels = unique(swallow$Task),name="Task") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


###Model with task as fixed effect
model2<-lmer(RiseSlopecm~Task+(1|ParticipantID),data=swallow,na.action=na.omit)
summary(model2)
anova(model2)
-2*logLik(model2)
BIC(model2)

###make plot
lsmeansLT(model2,test.effs="Task")

task.means<-lsmeansLT(model2,test.effs="Task")

str(task.means)

task.means2<-as.data.frame(task.means)

###Make columns more suitable for plotting
names(task.means2)[names(task.means2) == 'Estimate'] <- 'RiseSlopecm'
task.means2$Task.num<-c(1:11)

ggplot(swallow, aes(x=Task.num, y=RiseSlopecm, color=factor(ParticipantID))) + theme_few() + guides(color="none") +
  scale_x_continuous(breaks = seq(1:11), labels = unique(swallow$Task),name="Task") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  geom_point()+ geom_line(data=task.means2, aes(x=Task.num,y=RiseSlopecm,color=""),color=1)
