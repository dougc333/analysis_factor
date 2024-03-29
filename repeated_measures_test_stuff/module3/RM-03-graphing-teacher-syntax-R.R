###
###SETUP
###

###install and load packages
###install.packages("ggplot2")
library(ggplot2)
install.packages("ggthemes")

library(ggthemes)


###Set the working directory to the one containing your data
setwd("/Users/dc/test_stuff/repeated_measures/data")

###Note that the longteachers data has been created and saved in a separate syntax file
### for this module!
longteachers<-read.csv("longteachers.csv",header=T)


###USEFUL GRAPH 1

### Scatterplot with lines connecting rapport at different times
###To remove the legend include an additional + guides(color=FALSE)
ggplot(na.exclude(longteachers), aes(x=time, y=Rapport, color=factor(SubID))) +
    geom_line() + geom_point() + theme_few() + scale_color_discrete(name="Subject ID")+
    scale_x_continuous(breaks = seq(1:3),name="Time") 


###USEFUL GRAPH 2

###Scatterplot with individual linear trajectories and overall trajectory
ggplot(na.exclude(longteachers), aes(x=time, y=Rapport, color=factor(SubID)))+ geom_point() +
  geom_smooth(method=lm,se=FALSE,size=0.5) + theme_few() + 
  geom_smooth(method=lm,se=FALSE,color=1,size=1.5)+
  scale_color_discrete(name="Subject ID")+
  scale_x_continuous(breaks = seq(1:3),name="Time")


###USEFUL GRAPH 3

###scatterplot faceted by gender, showing individual series and overall trajectories
ggplot(na.exclude(longteachers), aes(x=time, y=Rapport, color=factor(SubID)))+ geom_point() +
  geom_line() + theme_few()  + facet_wrap(~Gender) + guides(color="none") +
  geom_smooth(method=lm,se=FALSE,color=1,size=1.5)+
  scale_color_discrete(name="Subject ID")+
  scale_x_continuous(breaks = seq(1:3),name="Time")

###OR
ggplot(na.exclude(longteachers), aes(x=time, y=Rapport, group=factor(SubID), color=factor(Gender)))+ geom_point() +
  geom_line() + theme_few()  +  guides(color="none") +
  geom_smooth(method=lm,se=FALSE,size=1.5,aes(x=time, y=Rapport, group=factor(Gender)),color=1)+
  scale_color_discrete(name="Subject ID")+
  scale_x_continuous(breaks = seq(1:3),name="Time")

###USEFUL GRAPH 4

###Scatterplot faceted by subject
ggplot(na.exclude(longteachers), aes(x=time, y=Rapport)) + geom_point() +
  geom_smooth(se=FALSE, method=lm, size=0.5) + theme_few() + facet_wrap(~SubID)+
  scale_x_continuous(breaks = seq(1:3),name="Time")
