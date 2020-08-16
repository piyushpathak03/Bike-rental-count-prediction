rm(list=ls(all=T))
setwd("E:/ml/Project1")
getwd()
install.packages( c("ggplot2", "corrgram", "randomForest"))

rental = read.csv("day.csv", header = T, na.strings = c(" ", "", "NA"))

df=rental
summary(df)
str(df)
head(df)
#Exploratory Data Analysis
df$season=as.factor(df$season)
df$mnth=as.factor(df$mnth)
df$yr=as.factor(df$yr)
df$holiday=as.factor(df$holiday)
df$weekday=as.factor(df$weekday)
df$workingday=as.factor(df$workingday)
df$weathersit=as.factor(df$weathersit)
df=subset(df,select = -c(instant,casual,registered))
d1=unique(df$dteday)
df=data.frame(d1)
df$dteday=as.Date(df$d1,format="%Y-%m-%d")
df$d1=as.Date(df$d1,format="%Y-%m-%d")
df$dteday=format(as.Date(df$d1,format="%Y-%m-%d"), "%d")
df$dteday=as.factor(df$dteday)
head(df)
str(df)
#Missing Values Analysis
# 1. checking for missing value
missing_val = data.frame(apply(df,2,function(x){sum(is.na(x))}))

#Outlier Analysis  



#Feature Selection

## Correlation Plot 
corrgram(df[,numeric_index], order = F,
         upper.panel=panel.pie, text.panel=panel.txt, main = "Correlation Plot")



## Dimension Reduction####

df = subset(df,select = -c(atemp))


#Model Development

###########################################
rmExcept("df")
train_index = sample(1:nrow(df), 0.8 * nrow(df))
train = df[train_index,]
test = df[-train_index,]


#Random Forest Model
RF_model = randomForest(cnt ~ ., train, importance = TRUE, ntree = 200)
predictions_RF = predict(RF_model, test[,-12])
plot(RF_model)





##########extacting predicted values output from Random forest model######################
results <- data.frame(test, pred_cnt = predictions_RF)

write.csv(results, file = 'output.csv', row.names = FALSE, quote=FALSE)

############################################################################################








