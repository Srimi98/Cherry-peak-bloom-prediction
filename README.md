# Cherry-peak-bloom-prediction
Peak bloom date prediction of Cherry trees for four different geographic locations for the next 10 years.

This is a statistical report on predicting the peak bloom date of cherry trees in four different geographical locations, likely Washington, D.C. (USA), Kyoto (Japan), and Liestal-Weideli (Switzerland), Vancouver BC (Canada).
The dataset i.e. bloom_doy (response) & the other variables (in data folder) are collected for different timeline.
We perform some statistical analysis & predict the blooming days for the next 10 years for each of the locations.
Note: For Vancouver there was no data available. So, the analysis is different.

# Washington DC (USA)

## Timeline: 1921 - 2021
## Exploratory Analysis:
We have plotted the predictor (i.e. bloom_doy) with respect to Years for a basic idea of the blooming pattern for the past 100 years & also analyse the relation between each of the covariates & the response (scatter plot,Pearsonian correlation).
Most of the variable (especially the temperature ones) was negatively correlated, which means the blooming day comes earlier with the increasing value of that variable.
Here, the last three variables are almost insignificant. So we drop those three variables and fit our model.
## Model & Prediction:
Normality check : Though the bloom_doy is a count variable, it seemed to have a gaussian distribution (by plotting histogram and Shapiro-Wilks Test)
Model fitting :  We have fitted a linear regression model with the dataset containing past 100 year’s records of a response variable and 5 covariates. 
The most significant variables for DC are February and March temperature. (from the corresponding P-values)
Also, almost all the 5 variables have a negative impact on the regressor variable.
Prediction: After fitting and checking the efficiency of the fit,we Predict each of the 5 covariates for the next 10 years. For this we perform Holt’s Method (as the variables have a trend with time)
Finally, we predict the response for the coming 10 years using the forecasted data frame in the fitted model.

# Kyoto (Japan)

## Timeline: 1922 - 2021
## Exploratory Analysis:
We have plotted the predictor (i.e. bloom_doy) with respect to Years for a basic idea of the blooming pattern for the past 99 years(1922-2021) & also analyse the relation between each of the 8 covariates & the response (scatter plot,Pearsonian correlation).
Most of the variable (especially the temperature ones) was negatively, which means the blooming day comes earlier with the increasing value of that variable.
## Model & Prediction:
Normality check : Though the bloom_doy is a count variable, it follows a normal distribution (by plotting histogram and Shapiro-Wilks Test).
Model fitting :  We have fitted a linear regression model with the dataset containing past 99 year’s records of a response variable and 8 covariates. 
The most significant variables for Kyoto are January,February, March & April temperature. (from the corresponding P-values).
All the covariates (except January temperature) have a negative impact on the regressor variable.
Prediction: After fitting and checking the efficiency of the fit,we Predict each of the 8 covariates for the next 10 years. For this we perform Holt’s Method (as the variables have a significant trend with time)
Finally, we predict the response for the coming 10 years using the forecasted data frame in the fitted model.

# Liestal-Weideli (Switzerland)

## Timeline: 1982 - 2021
## Exploratory Analysis:
We have plotted the predictor (i.e. bloom_doy) with respect to Years for a basic idea of the blooming pattern for the past 40 years(1982-2021) & also analyse the relation between each of the 6 covariates & the response (scatter plot, Pearsonian correlation).
Most of the variable (especially the temperature ones) was negatively correlated (except Average humidity & temperature on the bloom day), which means the blooming day comes earlier with the increasing value of the negatively related variables.
## Model & Prediction:
We have fitted a linear regression model with the dataset containing past 40 year’s records of a response variable and 6 covariates. 
All the covariates are significant for. (from the corresponding P-values).
All the temperature related covariates (except average temperature on bd) have a negative impact on the regressor variable.
Prediction: After fitting and checking the efficiency of the fit,we Predict each of the 6 covariates for the next 10 years. For this we perform Holt’s Method (as the variables have a significant trend with time)
Finally, we predict the response for the coming 10 years using the forecasted data frame in the fitted model.

# Vancouver, BC (Canada)

As data for Vancouver is not available, the whole data available for the rest of the 3 locations are merged to form a single dataset with all the available variables.  As, longitude and latitude are playing the role of factor variables here, we have discarded them from modelling and incorporated the altitude variables for the 3 different locations. Also, since bloom_doy is not available for Vancouver, we cannot provide any historical data for its prediction and hence, Average humidity as well as the Average temperature on Bloom day are discarded for better and interpretable predictions.
After the model fitting we have taken the forecasted values of the covariates as new data for the prediction of 2022 and replicated it for the next 9 years.
