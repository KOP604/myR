Logistic regression is a technique that is well suited for examining the relationship between a categorical response variable and one or more categorical or continuous predictor variables. The model is generally presented in the following format, where ¦Â refers to the parameters and x represents the independent variables.

log(odds)=¦Â0+¦Â1?x1+...+¦Ân?xn


library(caret)
data(GermanCredit)
Train <- createDataPartition(GermanCredit$Class, p=0.6, list=FALSE)
training <- GermanCredit[ Train, ]
testing <- GermanCredit[ -Train, ]

mod_fit <- train(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own + 
                   CreditHistory.Critical,  data=training, method="glm", family="binomial")
# we¡¯ll ussually want to use the 
exponential function to calculate the odds ratios for each preditor.

exp(coef(mod_fit$finalModel))
##            (Intercept)                    Age          ForeignWorker 
##              1.1606762              1.0140593              0.5714748 
##    Property.RealEstate            Housing.Own CreditHistory.Critical 
##              1.8214566              1.6586940              2.5943711

# This informs us that for every one unit increase in Age, the odds 
of having good credit increases by a factor of 1.01. 
predict(mod_fit, newdata=testing)
predict(mod_fit, newdata=testing, type="prob")
Model Evaluation and Diagnostics

# Are the predictions accurate? 

# For the following sections, we will primarily work with the 
# logistic regression that I created with the glm() function. 
# While I prefer utilizing the Caret package, many functions in R 
# will work better with a glm object.

mod_fit_one <- glm(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own + 
                     CreditHistory.Critical, data=training, family="binomial")

mod_fit_two <- glm(Class ~ Age + ForeignWorker, data=training, family="binomial")

#Goodness of Fit
#Likelihood Ratio Test
anova(mod_fit_one, mod_fit_two, test ="Chisq")
library(lmtest)
lrtest(mod_fit_one, mod_fit_two)

#Pseudo R^2
library(pscl)
pR2(mod_fit_one)  # look for 'McFadden'
##           llh       llhNull            G2      McFadden          r2ML 
## -344.42107079 -366.51858123   44.19502089    0.06029029    0.07101099 
##          r2CU 
##    0.10068486
Hosmer-Lemeshow Test

#Homer-Lemeshow statistics
library(MKmisc)
HLgof.test(fit = fitted(mod_fit_one), obs = training$Class)
library(ResourceSelection)
hoslem.test(training$Class, fitted(mod_fit_one), g=10)
Statistical Tests for Individual Predictors
Wald Test

#wald test 
#evaluate the statistical significance of each coefficient in the model and is calculated by taking the ratio of the square of the regression coefficient to the square of the standard error of the coefficient. The idea is to test the hypothesis that the coefficient of an independent variable
library(survey)
regTermTest(mod_fit_one, "ForeignWorker")
## Wald test for ForeignWorker
##  in glm(formula = Class ~ Age + ForeignWorker + Property.RealEstate + 
##     Housing.Own + CreditHistory.Critical, family = "binomial", 
##     data = training)
## F =  0.949388  on  1  and  594  df: p= 0.33027
regTermTest(mod_fit_one, "CreditHistory.Critical")
## Wald test for CreditHistory.Critical
##  in glm(formula = Class ~ Age + ForeignWorker + Property.RealEstate + 
##     Housing.Own + CreditHistory.Critical, family = "binomial", 
##     data = training)
## F =  16.67828  on  1  and  594  df: p= 5.0357e-05
Variable Importance

#relative importance
varImp(mod_fit)
## glm variable importance
## 
##                        Overall
## CreditHistory.Critical  100.00
## Property.RealEstate      57.53
## Housing.Own              50.73
## Age                      22.04
## ForeignWorker             0.00
Validation of Predicted Values
Classification Rate

#predicting the target variable on out of sample
pred = predict(mod_fit, newdata=testing)
accuracy <- table(pred, testing[,"Class"])
sum(diag(accuracy))/sum(accuracy)
## [1] 0.705
pred = predict(mod_fit, newdata=testing)
confusionMatrix(data=pred, testing$Class)
ROC Curve

#ROC
library(pROC)
# Compute AUC for predicting Class with the variable CreditHistory.Critical
f1 = roc(Class ~ CreditHistory.Critical, data=training) 
plot(f1, col="red")
## 
## Call:
## roc.formula(formula = Class ~ CreditHistory.Critical, data = training)
## 
## Data: CreditHistory.Critical in 180 controls (Class Bad) < 420 cases (Class Good).
## Area under the curve: 0.5944
library(ROCR)
# Compute AUC for predicting Class with the model
prob <- predict(mod_fit_one, newdata=testing, type="response")
pred <- prediction(prob, testing$Class)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
plot(perf)
auc <- performance(pred, measure = "auc")
auc <- auc@y.values[[1]]
auc
## [1] 0.6540625
K-Fold Cross Validation

#CV
ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)
mod_fit <- train(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own + 
                   CreditHistory.Critical,  data=GermanCredit, method="glm", family="binomial",
                 trControl = ctrl, tuneLength = 5)

pred = predict(mod_fit, newdata=testing)
confusionMatrix(data=pred, testing$Class)

