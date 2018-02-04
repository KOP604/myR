#NOTES
geom_bar geom_histogram geom_point can take both numeric and factor variables
geom_line or geom_smooth needs x to be numeric. Use as.numeric()to transform x if it isn't. 
When creating LINE chart with aggregated data, i.e. one obs each x, use 'fake' group=1 in aes statement

#install.packages("caret")
#install.packages("pROC") # 
#install.packages("leaps") #
#install.packages("readr")
#install.packages("arules")
#install.packages("GGally")

require(GGally)
require(Hmisc)
library(pROC)
library(ggplot2)
library(plyr)
library(leaps)
library(dplyr)
require(arules)
require(GGally)

# Boston Housing Data
load(file='D://R/training.RData') 
exists("training")

#Hmisc
describe(training)
#rename variable names
names(training)<-edit(names(training))

#Histogram/Bar chart
#equal interval
training$das<-discretize(training$SalePrice, method="interval", categories = 10)
ggplot(training, aes(x=das)) +geom_bar(col="red", fill="green", alpha=.2, stat="count")
ggplot(training, aes(x=das)) +geom_histogram(col="red", fill="green", stat="count") #OK too

#fixed
training$das<-discretize(training$SalePrice, method="fixed", 
      categories = c(-Inf, 100000,200000,300000,400000,500000,Inf),
      labels=c('<100M','<200M','<300M','<400M','<500M'£¬¡®500M+'))
table(training$das)
ggplot(training, aes(x=das)) +geom_bar(col="red", fill="green", stat="count")

# SUMMERIZED
m2<-summary(training$das,FUN=length) #integer
class(m2) 
str(m2)
dat<-as.data.frame(m2)
dat$names<-rownames(dat) # create x
ggplot(dat, aes(x=names, y=m2)) +geom_bar(stat="identity")
ggplot(dat, aes(x=names, y=m2, group=1)) +geom_line(stat="identity") 


#Group mean
price.by.lc<-aggregate(training$SalePrice, by=list(training$LandContour), FUN=mean)
ggplot(price.by.lc, aes(x=Group.1, y=x)) +geom_bar(stat="identity", position="dodge", fill="green", col="red")
ggplot(price.by.lc, aes(x=Group.1, y=x, group=1)) +geom_line(stat="identity")


# x y
ggplot(training, aes(x=LotFrontage,y=SalePrice.log))+geom_smooth(method='lm')+geom_point()
ggplot(training, aes(x=LotFrontage,y=SalePrice.log))+geom_smooth(method='loess')+geom_point()

## Decile x -> y mean
training$dan<-discretize(training$LotFrontage, "frequency", categories = 10)
class(training$dan) #factor
K2<-aggregate(training$SalePrice,by=list(training$dan), FUN=mean) #data.frame
K22<-tapply(training$SalePrice,training$dan, FUN=mean) array

#SUMMERIZED
ggplot(data=K2, aes(x=Group.1,y=x, group=1))+geom_line(stat='identity')
ggplot(data=K2, aes(x=Group.1,y=x, group=1))+geom_smooth(method=loess) +geom_point()
ggplot(data=K2, aes(x=Group.1,y=x, group=1))+geom_smooth(method=lm) +geom_point()

#UNSUMMERIZED
ggplot(training, aes(x=das,y=SalePrice,group=1)) + geom_point() + geom_smooth(method=lm) 

#BY charts One page
training$das<-discretize(training$SalePrice, method="interval", categories = 10)
ggplot(training, aes(x=das)) +geom_bar(col="red", fill="green", alpha=.2, stat="count") +facet_grid(GarageType~.)

#percent of count
training$das<-discretize(training$SalePrice, method="interval", categories = 20)
ggplot(training, aes(x=das)) + geom_bar(col="red", fill="green", aes(y=(..count..)/sum(..count..)))+ facet_grid(GarageType~.)
# NOT GOOD! It uses the total total as denominator not the group total

# Calculate PCT first
K<-prop.table(table(training$das,training$GarageType), margin=2)*100
KK<-as.data.frame(K) 
ggplot(KK, aes(x=Var1, y=Freq)) + geom_bar(col="red", fill="green", stat='identity') +facet_grid(Var2~.)+ ggtitle("Boston Housing") + labs(x="Price",y="Percent") 

#ggcorr & ggpairs
num<-sapply(training,is.numeric)
ft<-names(training)
num.var<-ft[num==T] 
ggcorr(training[num.var[2:10]],  hjust = 0.25, size=2.5)

#scatter plot matrix NOTE plotmatrix has been replaced by ggpairs
ggpairs(training, columns=num.var[2:6],  title="GGPAIRS") 
ggpairs(training, columns=2:10,  title="GGPAIRS") 










