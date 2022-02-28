---
title: "Peak Bloom Prediction Competition"
author: "Srijeeta Mitra"
date: "28/02/2022"
output:
  csv file
---

## Required libraries
install.packages('pacman')
library('pacman')
pacman::p_load(forecast,timeSeries,tseries,aTSA)


## Loading the data

The data for each of the three main sites is provided as simple text file in CSV format.
Each file contains the dates of the peak bloom of the cherry trees at the respective sites along with weather credentials which can affect peak bloom dates for the sites.

## Reading the data into R

data=read.csv("data/Washington Dc data.csv")            ## For Washington Dc USA
#OR
data=read.csv("data/japan data.csv")                    ## For Kyoto Japan
#OR
data=read.csv("data/Liestal data.csv")                  ## For Liestal Switzerland

data=na.omit(data)               ## Omitting NA Values in the data sets
attach(data)                     ## Attaching the data sets for further references

## Time Series Plot of Response (bloom_doy)

plot(Years,bloom_doy,type="l")

## Scatter plot of each variables wrt the response & calculating Pearsonian Correlation coefficient for selecting significant variables for the analysis

Cor=c()
for(i in 5:dim(data)[2]) 
{
  plot(bloom_doy,data[,i],ylab=colnames(data)[i],main=paste("bloom_doy vs ",colnames(data)[i]))      ## Scatter plots for regressor vs the covariates
  Cor[i-4]=cor(bloom_doy,data[,i])
}

B=Cor
B=data.frame(t(B))                                           ## Correlations with bloom_doy
colnames(B)=colnames(data)[-c(1:4)]
View(B)                                                      

to_omit=which(abs(B[1,])<0.1)                                ## The insignificant covariates 

if(length(to_omit)!=0){                                      ## Removing the insignificant covariates from the data set
  data=data[,-(4+to_omit)]
}

## Checking for normality of bloom_doy
table(bloom_doy)
hist(bloom_doy)
shapiro.test(bloom_doy)

## Modeling with linear models (excluding insignificant covariates)
model=lm(bloom_doy~., data=data[,-c(1,3,4)])
summary(model)
pred=predict.lm(model,newdata = data[,-c(1:4)])              ## Predictions
range(abs(pred-bloom_doy))                                   ## Absolute residuals

## Plotting Actual vs Fitted values
plot(Years,bloom_doy,type="l",ylim=c(min(bloom_doy),max(bloom_doy)),col="red", ylab="Bloom doy", main="Observed vs Predicted")
par(new=T)
plot(Years,pred,type="l",ylim=c(min(bloom_doy),max(bloom_doy)),col="blue",ylab="")

## Forecasted covariates for the next 10 years by Holt Method
Pred_holt=matrix(0,nrow=10,ncol=dim(data)[2]-4)              ## Matrix to store the forecasted covariates for next 10 years
for(i in 5:dim(data)[2])
{
  Pred_holt[,(i-4)]=c(holt(data[,i],h=10)$mean)
}

Pred_holt                                                    ## Forecasted covariates for the next 10 years

## Final prediction of the Response variable (bloom_doy) for the next 10 years

Pred_holt=as.data.frame(Pred_holt)
colnames(Pred_holt)=colnames(data)[5:dim(data)[2]]
predicted=round(predict.lm(model,newdata=Pred_holt),0)       ## Predicted bloom_doy for next 10 years 
predicted=as.data.frame(t(predicted))
colnames(predicted)=c(2022:2031)                             ## Finalizing the bloom doy as data frame

## Extrapolating to Vancouver, BC

As data for Vancouver is not available, the whole data available for the rest of the 3 locations are merged to form a single dataset with all the available variables. 
As, longitude and latitude are playing the role of factor variables here, we have discarded them from modelling and incorporated the altitude variables for the 3 different
locations. Also, since bloom_doy is not available for Vancouver, we cannot provide any historical data for its prediction and hence, Average humidity as well as the Average
temperature on Bloom day are discarded for better and interpretable predictions. 

## Reading the file into R

data_vanc=read.csv("data/Vancouver data.csv")
data_vanc=na.omit(data_vanc)
attach(data_vanc)

## Removing unnessessary columns

data=data_vanc[,-c(1,2,4,5,7,12)]                           ## Lat and Long are not included in model, as BD is not available for Canada, humidity and temp on BD is also removed

## Removing insignificant variables by checking correlations
Cor=c()
for(i in 2:dim(data)[2])
{
  Cor[i-1]=cor(bloom_doy,data[,i])
}

to_omit=which(abs(Cor)<0.1)

data=data[,-(1+to_omit)]

## Modelling for the avaiable data set

model=lm(bloom_doy~.,data=data) 
summary(model)

# New data(with forecats) collected from https://www.theweathernetwork.com/ca/monthly/british-columbia/vancouver?year=2022&month=4&dispt=calendar-container-monthly

B=matrix(0,nrow=1,ncol=5)
B=as.data.frame(B)
colnames(B)=colnames(data)[-1]
View(B)
B[2,]=c(4.1,9.2,13,4.2,2.7) 

## Prediction for 2022

pred=round(predict.lm(model,newdata = B[2,]),0)

