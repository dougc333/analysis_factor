###
###SETUP
###

###Set working directly to one containing the data
setwd("C:/Users/Kim__/Dropbox/Workshops/Repeated Measures/Data")

###Read in the data sets that we will need
training<-read.csv("Physical-training.csv", header=T)
teachers<-read.csv("teachers.csv",header=T)
county<-read.csv("CountyWide.csv",header=T)
county_remove1950<-subset(county,select= -c(Mobil1950,College1950,Pop1950,LFP1950,HWY1950))
county_remove1950
county_remove1950$ID<-1:nrow(county_remove1950)
1960 1
1970 2
1980 3
1990 4
2000 5
colnames(county_remove1950)
colnames(county_remove1950)<-c("County","Rural.1","College.5","College.4","College.3","Jobs.4","Jobs.3","Jobs.5",       
                                "College.2","College.1","Rural.2","Rural.3","Rural.4","Rural.5","LandArea","LFP.1",        
                                "LFP.2","LFP.3","LFP.4","LFP.5","Mobil.1","Mobil.2","Mobil.3","Mobil.4",      
                                "Mobil.5","Pop.1","Pop.2","Pop.3","Pop.4","Pop.5","HWY.1","HWY.2", 
                                "HWY.3","HWY.4","HWY.5","NatAmenity","Jobs.1","Jobs.2","ContigJobsK.1","ContigJobsK.2",
                                "ContigJobsK.3","ContigJobsK.4", "ContigJobsK.5","ID")

county_remove1950
#colnames(county_remove1950)<- c("group","age","height","BM.1","BM.2","BF.1","BF.2","FM.1","FM.2",
                       "FFM.1","FFM.2","WHR.1","WHR.2","BMI.1","BMI.2","TG.1",
                       "TG.2","CHL.1","CHL.2","HDL.1","HDL.2","LDL.1","LDL.2","TC_HD.1",
                       "TC_HD.2","TC_LD.1","TC_LD.2","LD_HD.1","LD_HD.2","ID") 

longcounty<-reshape(county_remove1950,varying=c("Rural.1","College.5","College.4","College.3","Jobs.4","Jobs.3","Jobs.5",       
                                "College.2","College.1","Rural.2","Rural.3","Rural.4","Rural.5","LandArea","LFP.1",        
                                "LFP.2","LFP.3","LFP.4","LFP.5","Mobil.1","Mobil.2","Mobil.3","Mobil.4",      
                                "Mobil.5","Pop.1","Pop.2","Pop.3","Pop.4","Pop.5","HWY.1","HWY.2", 
                                "HWY.3","HWY.4","HWY.5","Jobs.1","Jobs.2","ContigJobsK.1","ContigJobsK.2",
                                "ContigJobsK.3","ContigJobsK.4", "ContigJobsK.5"),
                      timevar="decade",idvar="County",direction="long",sep=".")

longcounty

###
###RESTRUCTURE TEACHERS FROM WIDE TO LONG
###


###The way variables are named is VERY important for this--must use the same separating symbol (Rapport.1, STRS.1, etc.)
###Create a new variable called "Time" that will go with the long versions of wide variables
###Use SubID as the ID variable
###Everything you don't list will repeat when you use direction="long"
longteachers<-reshape(teachers,varying=c("Rapport.1","Rapport.2","Rapport.3","STRS.1","STRS.2","STRS.3"),
                        timevar="time",idvar="SubID",direction="long",sep=".")


###Export to a new CSV to reimport for other scripts
write.csv(longteachers,"longteachers.csv",row.names=F,na="")

###
###RESTRUCTURE TEACHERS TO LONG FROM WIDE
###


###This is entirely dependent on the data
###R "knows" which variables are repeated and which are not
wideteachers<-reshape(longteachers)


###
###RESTRUCTURE TRAINING FROM WIDE TO LONG
###

###Create an ID variable (no variable currently)
training$ID<-1:nrow(training)

###While there are a number of ways to do this, the easiest is to rename your variables
### and use the same method above.

###Get current column names
colnames(training)

###Change them! Make "pre" 1 and "post" 2
###Note we could keep the underscore as a separator, except it is confusing to R because 
### there are some variables with underscores in the names
colnames(training)<- c("group","age","height","BM.1","BM.2","BF.1","BF.2","FM.1","FM.2",
                       "FFM.1","FFM.2","WHR.1","WHR.2","BMI.1","BMI.2","TG.1",
                       "TG.2","CHL.1","CHL.2","HDL.1","HDL.2","LDL.1","LDL.2","TC_HD.1",
                       "TC_HD.2","TC_LD.1","TC_LD.2","LD_HD.1","LD_HD.2","ID") 

###Let's go ahead and define the variables to be varying in advance since there are so many of them...
vars<-c("BM.1","BM.2","BF.1","BF.2","FM.1","FM.2","FFM.1","FFM.2","WHR.1","WHR.2","BMI.1","BMI.2","TG.1",
        "TG.2","CHL.1","CHL.2","HDL.1","HDL.2","LDL.1","LDL.2","TC_HD.1","TC_HD.2","TC_LD.1","TC_LD.2",
        "LD_HD.1","LD_HD.2")

###Create the dataset
longtraining<-reshape(training,varying=vars,sep=".",idvar="ID",direction="long")


###Export to a new CSV to reimport for other scripts
write.csv(longtraining,"longtraining.csv",row.names=F,na="")
