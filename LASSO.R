## I"M ADDDING ONE LINE TO ORINGINAL LASSO.R
## Create a sim data folowing SAS example
#data analysisData testData;
#drop i j;
#array x{20} x1-x20;
#do i=1 to 5000;
#/* Continuous predictors */
#do j=1 to 20;
#x{j} = ranuni(1);
#end;
#/* Classification variables */
#c1 = int(1.5+ranuni(1)*7);
#c2 = 1 + mod(i,3);
#c3 = int(ranuni(1)*15);
#yTrue = 2 + 5*x17 - 8*x5 + 7*x9*c2 - 7*x1*x2 + 
6*(c1=2) + 5*(c1=5);
#y = yTrue + 6*rannor(1);
#if ranuni(1) < 2/3 then output analysisData;
#else output testData;
#end;
#run;

## r
rm(analysisdata)
analysisdata <- data.frame(ID=1:5000)

#  Pay attention to upper and lower case. It's 'for' not 'For'
## Continuous predictors
for (i in 1:20) 
	{analysisdata[,paste0("x",i)]<-runif(5000) 
	  #note random number generator needs N
	} 
head(analysisdata$x3)

### Classification variables 
analysisdata$c1<-as.factor(floor(1.5+runif(5000)*7))
analysisdata$c3<-as.factor(floor(runif(5000)*15))
for (i in 1:5000){
   analysisdata$c2[i]<-(1+i %% 3	)
}

#TRue relationship
ytrue<-
  2 + 
	5*analysisdata$x17  - 
	8*analysisdata$x5 + 
	7*analysisdata$x9 -
  6*(analysisdata$c1==2) + 
	5*(analysisdata$c1==5)

	# 7*analysisdata$x1*analysisdata$x2 +
analysisdata$y<-ytrue + 6*rnorm(5000)

# partition training and validation
traindata<-analysisdata[sample(1:5000, 5000*2/3, replace=FALSE),]
testdata<-analysisdata[!analysisdata$ID %in% traindata$ID,]

pairs(traindata[,1:5])

#stepwise regression
fit<-lm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15+x16+x17+x18+x19+x20
	+factor(c1)+factor(c2)+factor(c3),data=traindata)

summary(fit) #some overfit x11, x18, and c2
fit$coefficients

# MASS package is needed to run stepAIC
require(MASS) #same as library()
AIC <- stepAIC(fit, direction="both")
AIC$coefficients

## Call in training data from outside
traindata <- read.xport("H://temp//reg.xpt") 
str(traindata)

?lm
fit<-lm(Y~X1+X2+X3+X4+X5+X6+X7+X8+X9+X10+X11+X12+X13+X14+X15+X16+X17+X18+X19+X20
	+factor(C1)+factor(C2)+factor(C3),data=traindata)

summary(fit) #some overfit x11, x18, and c2
summary.lm(fit)
fit$coefficients
AIC <- stepAIC(fit, direction="both")
AIC$coefficients

?stepAIC
## not easy to implement other stepwise methods in r

#I want to do LASSO
library(relaimpo) #relative importance
library(glmnet) #LASSO
library(randomForest) ## we alreay have it too!
library(rpart) ## we have it!
libraray(psych) ## nice cor.pot
libraray(DAAG) 


#PART II: lok it, chart it, describe it, analyze it
colnames(CAMPGN)
head(CAMPGN$LST_CMPGN_DT)
class(CAMPGN$LST_CMPGN_DT)
class(CAMPGN$EMAIL)
View(CAMPGN[1:100,]) #note it is View
str(CAMPGN)

summary(CAMPGN)
T1<-table(CAMPGN$CAMP_CNT, CAMPGN$EMAIL,useNA="ifany",dnn=c("CNT","EMAIL"))

options(scipen=9)
PT<-prop.table(addmargins(T1),2)
names(dimnames(PT)) <- c("ROW", "My Table w title") 
100*PT
print(sprintf("%.1f %%",100*PT))

#Complete regression excercise
fit<-lm(CAMP_CNT~EMAIL + WEB+ PHONE +MAIL, data=CAMPGN)

coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(fit) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 
influence(fit) # regression diagnostics 

# K-fold cross-validation
library(DAAG)
cv.lm(df=mydata, fit, m=3) # 3 fold cross-validation

# Assessing R2 shrinkage using 10-Fold Cross-Validation 

fit <- lm(y~x1+x2+x3,data=mydata) 

library(bootstrap)
# define functions 
theta.fit <- function(x,y){lsfit(x,y)}
theta.predict <- function(fit,x){cbind(1,x)%*%fit$coef} 

# matrix of predictors
X <- as.matrix(mydata[c("x1","x2","x3")])
# vector of predicted values
y <- as.matrix(mydata[c("y")]) 

results <- crossval(X,y,theta.fit,theta.predict,ngroup=10)
cor(y, fit$fitted.values)**2 # raw R2 
cor(y,results$cv.fit)**2 # cross-validated R2 


##major tools for linear regression
# Stepwise Regression
library(MASS)
fit <- lm(y~x1+x2+x3,data=mydata)
step <- stepAIC(fit, direction="both")
step$anova # display results 

# All Subsets Regression
library(leaps)
attach(mydata)
leaps<-regsubsets(y~x1+x2+x3+x4,data=mydata,nbest=10)
# view results 
summary(leaps)
# plot a table of models showing variables in each model.
# models are ordered by the selection statistic.
plot(leaps,scale="r2")
# plot statistic by subset size 
library(car)
subsets(leaps, statistic="rsq") 

#Relative Importance
#The relaimpo package provides measures of relative importance for each of the predictors in the model. See help(calc.relimp) for details on the four measures of relative importance provided. 
# Calculate Relative Importance for Each Predictor
library(relaimpo)
calc.relimp(fit,type=c("lmg","last","first","pratt"),
   rela=TRUE)
# Bootstrap Measures of Relative Importance (1000 samples) 
boot <- boot.relimp(fit, b = 1000, type = c("lmg", 
  "last", "first", "pratt"), rank = TRUE, 
  diff = TRUE, rela = TRUE)
booteval.relimp(boot) # print result
plot(booteval.relimp(boot,sort=TRUE)) # plot result 

rm(k)
k<-data.frame(1:10)
k$ind<-21:30
k$ind2<-ifelse(k$ind==22, k$ind*.5,0) 
k$ind2




