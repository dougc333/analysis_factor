###
###SETUP
###

###install and load packages
###install.packages("ggplot2")
library(ggplot2)
###install.packages("ggthemes")
library(ggthemes)


###Set the working directory to the one containing your data
setwd("/Users/dc/test_stuff/repeated_measures/data")

###Read in the swallowing data
swallowing<-read.csv("Swallowing.csv",header=T)

###Keep only the anterior bulb observations
swallowing<-swallowing[swallowing$Bulb=="A",]


###
###SET UP FOR PLOTS
###

###Get a data set with means by task for each participant
swallowing.means<-aggregate(swallowing$RiseSlope,list(swallowing$Task,swallowing$ParticipantID),mean,na.rm=T)
colnames(swallowing.means)<- c("Task", "ParticipantID","RiseSlope.Mean")

###Create numbers to match the tasks; R has issues making lines on the graphs that follow otherwise!
swallowing.means$Task.num <-rep(c(1:12),19)
swallowing$Task.num<-rep(c(rep(1,5),rep(2,5),rep(3,5),rep(4,5),rep(5,5),rep(6,5),
                           rep(7,5),rep(8,5),rep(8,5),rep(10,5),rep(11,5),rep(12,5)),19)

###LINE GRAPH
ggplot(swallowing.means, aes(x=Task.num, y=RiseSlope.Mean, color=factor(ParticipantID))) +
  geom_line() + geom_point() + theme_few() + scale_color_discrete(name="Participant ID") +
  scale_x_continuous(breaks = seq(1:12), labels = unique(swallowing.means$Task),name="Task") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

###LINE GRAPH WITIH SCATTERPLOT
ggplot(swallowing.means, aes(x=Task.num, y=RiseSlope.Mean, color=factor(ParticipantID))) +
  geom_line() + theme_few() + scale_color_discrete(name="Participant ID") +
  scale_x_continuous(breaks = seq(1:12), labels = unique(swallowing.means$Task),name="Task") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  geom_point(data=na.exclude(swallowing), aes(x=Task.num,y=RiseSlope,color=factor(ParticipantID)))


###PANEL BY PARTICIPANT
ggplot(swallowing.means, aes(x=Task.num, y=RiseSlope.Mean)) + geom_line() + theme_few() + 
  scale_x_continuous(breaks = seq(1:12), labels = unique(swallowing.means$Task),name="Task") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + facet_wrap(~ParticipantID) + 
  geom_point(data=na.exclude(swallowing), aes(x=Task.num,y=RiseSlope)) 
