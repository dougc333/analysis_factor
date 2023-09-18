###
###SETUP
###

###install/load packages
###install.packages("ggplot2")
library(ggplot2)
###install.packages("ggthemes")
library(ggthemes)
###install.packages("scales")
###This is used in problem 7 to avoid scientific notation
library(scales)


###Set working directly to one containing the data
setwd("/Users/dc/test_stuff/repeated_measures/data")


###Read in the data sets that we will need
training<-read.csv("Physical-training.csv", header=T)
countywide<-read.csv("countywide.csv",header=T)


###
###2. RESTRUCTURE TRAINING FROM WIDE TO LONG
###


###
###RESTRUCTURE TRAINING FROM WIDE TO LONG
###

###Create an ID variable (no variable currently)
training$ID<-1:nrow(training)


###Get current column names
colnames(training)


#"group"   "age"     "height"  "BM.1"    "BM.2"    "BF.1"    "BF.2"    "FM.1"    "FM.2"    "FFM.1"   "FFM.2"   "WHR.1"   "WHR.2"   "BMI.1"  
#"BMI.2"   "TG.1"    "TG.2"    "CHL.1"   "CHL.2"   "HDL.1"   "HDL.2"   "LDL.1"   "LDL.2"   "TC_HD.1" "TC_HD.2" "TC_LD.1" "TC_LD.2" "LD_HD.1"
#"LD_HD.2" "ID" 

###Change them! The "easiest" restructuring method needs numbers. Make "pre" 1 and "post" 2
###Note we could keep the underscore as a separator, except it is confusing to R because 
### there are some variables with underscores in the names
colnames(training)<- c("group","age","height","BM.1","BM.2","BF.1","BF.2","FM.1","FM.2",
                       "FFM.1","FFM.2","WHR.1","WHR.2","BMI.1","BMI.2","TG.1",
                       "TG.2","CHL.1","CHL.2","HDL.1","HDL.2","LDL.1","LDL.2","TC_HD.1",
                       "TC_HD.2","TC_LD.1","TC_LD.2","LD_HD.1","LD_HD.2","ID") 

###Let's go ahead and define the variables to be varying in advance since there are so many of them...
vars<-c("BM.1","BM.2","BF.1","BF.2","FM.1","FM.2","FFM.1","FFM.2","WHR.1","WHR.2","BMI.1","BMI.2",
        "TG.1","TG.2","CHL.1","CHL.2","HDL.1","HDL.2","LDL.1","LDL.2","TC_HD.1","TC_HD.2",
        "TC_LD.1","TC_LD.2","LD_HD.1","LD_HD.2")

###Create the dataset
longtraining<-reshape(training,varying=vars,sep=".",idvar="ID",direction="long")



###
###3. RESTRUCTURE TRAINING FROM LONG TO WIDE
###

###This depends very much on the format that's already there
widetraining<-reshape(longtraining) ###that's it


###
###4. LINE GRAPHS
###

###For more information about the ggplot options, I recommend you watch the examples videos

###FFM graph
ggplot(data=longtraining, aes(x=time, y=FFM, color=factor(ID))) + geom_point() + geom_line() + 
  theme_few() + scale_x_continuous(breaks = seq(1:2), labels=c("Pre","Post"),name="Time") + 
  facet_wrap(~group) + guides(color="none")

###HDL graph
ggplot(data=longtraining, aes(x=time, y=HDL, color=factor(ID))) + geom_point() + geom_line() + 
  theme_few() + scale_x_continuous(breaks = seq(1:2), labels=c("Pre","Post"),name="Time") + 
  facet_wrap(~group) + guides(color="none")

###LDL graph
ggplot(data=longtraining, aes(x=time, y=LDL, color=factor(ID))) + geom_point() + geom_line() + 
  theme_few() + scale_x_continuous(breaks = seq(1:2), labels=c("Pre","Post"),name="Time") + 
  facet_wrap(~group) + guides(color="none")


###
###5. COUNTY DATA WIDE TO LONG
###

###Get column names
colnames(countywide)

###Change them... note the variable order is a mess
colnames(countywide)<-c("County","Rural.1","College.5","College.4","College.3","Jobs.4",
  "Jobs.3","Jobs.5","College.2","College.1","Rural.2","Rural.3",
  "Rural.4","Rural.5","LandArea","LFP.1","LFP.2","LFP.3",
  "LFP.4","LFP.5","Mobil.1","Mobil.2","Mobil.3","Mobil.4",      
  "Mobil.5","Pop.1","Pop.2","Pop.3","Pop.4","Pop.5",
  "HWY.1","HWY.2","HWY.3","HWY.4","HWY.5","NatAmenity","Jobs.1","Jobs.2",
  "ContigJobsK.1","ContigJobsK.2","ContigJobsK.3","ContigJobsK.4",
  "ContigJobsK.5","Mobil1950","College1950","Pop1950","LFP1950","HWY1950")

###Order variables in the right order within variable names, or this will get wonky
vars<-c("Rural.1","Rural.2","Rural.3","Rural.4","Rural.5",
        "College.1","College.2","College.3","College.4","College.5",
        "Jobs.1","Jobs.2","Jobs.3","Jobs.4","Jobs.5",
        "LFP.1","LFP.2","LFP.3","LFP.4","LFP.5",
        "Mobil.1","Mobil.2","Mobil.3","Mobil.4","Mobil.5",
        "Pop.1","Pop.2","Pop.3","Pop.4","Pop.5",
        "HWY.1","HWY.2","HWY.3","HWY.4","HWY.5",
        "ContigJobsK.1","ContigJobsK.2","ContigJobsK.3","ContigJobsK.4","ContigJobsK.5")

###Reshape the data
longcounty<-reshape(countywide,varying=vars,timevar="decade",idvar="County",direction="long",sep=".")


###
###6. COUNTY DATA LONG TO WIDE
###

###This depends very much on the format that's already there
widecounty<-reshape(longcounty) ###that's it


###
###7. LINE GRAPHS BY RURAL
###

###Note that in order to get the y axis to print in NOT scientific notation, I used
### the labels=comma option that comes from the scales package
ggplot(data=longcounty, aes(x=decade, y=Jobs, group=factor(County),color=factor(Rural))) + geom_point() + geom_line() + 
  theme_few()  + guides(color="none") +  
  geom_smooth(method='lm',color=1,se=F,aes(x=decade, y=Jobs, group=factor(Rural))) + 
  scale_y_continuous(labels=comma)+ 
  scale_x_continuous(breaks = seq(1:5), labels=c("1960","1970","1980","1990","2000"),name="Year")


### OR
ggplot(data=longcounty, aes(x=decade, y=Jobs, color=factor(County))) + geom_point() + geom_line() + 
  theme_few() + facet_wrap(~Rural) + guides(color="none") +  geom_smooth(method='lm',color=1,se=F) + 
  scale_y_continuous(labels=comma)+ 
  scale_x_continuous(breaks = seq(1:5), labels=c("1960","1970","1980","1990","2000"),name="Year")





###
###8. LINE GRAPHS BY RURAL WITH INTERPOLATION LINES
###

###Note, I interpreted "interpolation lines" as regression lines
###Otherwise you could just use second version of previous answer
###Create the plot
ggplot(data=longcounty, aes(x=decade, y=Jobs, color=factor(County))) + geom_point() + theme_few() +  
  geom_smooth(method = "lm", se = FALSE,size=0.5)+ 
  scale_x_continuous(breaks = seq(1:5), labels=c("1960","1970","1980","1990","2000"),name="Year") + 
  facet_wrap(~Rural) + guides(color="none") + scale_y_continuous(labels=comma)


###
###9. LINE GRAPHS/SCATTERPLOTS BY COUNTY WITH REGRESSION LINES
###

###I changed the orientation of the x axis text to fit it on the plot
ggplot(data=longcounty, aes(x=decade, y=Jobs)) + geom_point() + theme_few()+
  geom_smooth(method="lm",size=0.5,color=1,se=F) +  
  scale_x_continuous(breaks = seq(1:5), labels=c("1960","1970","1980","1990","2000"),name="Year") +
  facet_wrap(~County) + guides(color="none") + scale_y_continuous(labels=comma) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

