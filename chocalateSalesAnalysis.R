## dataset import

setwd("C:\\Users\\Yusuf\\Desktop\\chocalateSalesDatasExcel")
data <- read.csv("Chocolate Sales.csv", sep = ";")

## Find same sales persons.

table(data$Sales.Person)
## We have same name in different rows. Because they had sold different products and 
## the table is showing us, on different products, to sale performance of sales persons.


## Find how many sales persons.

unique(data$Sales.Person)
## We have 25 different persons. 


## Find how many products.

unique(data$Product)
## We have 21 different products.


## Firstly I want to make analysis to which person how many made earn to the company.
## Therefor I will ensure new dataframe. Therefor I need to personel names, amounts, and boxes.
## Therefor I will ensure new dataframe.

earningData <- data[c(1, 5, 6)]


## If I need to how many earned the company, I need to total income.
## I will make Amount * Boxes.Shipped for find to total income per every persons.
## Firstly I need change int type the two columns. But firstly, I need to make a control.
str(earningData)
## Amount is chr. I should change it.

earningData$Amount <- gsub("\\$", "", earningData$Amount) ## I deleted $ symboll
earningData$Amount <- gsub(",", ".", earningData$Amount) ## I deleted , symbol and that was a reaon for * 100
earningData$Amount <- as.numeric(earningData$Amount) ## I changed numeric

str(earningData) ## I made control
## That changed. Now I can make my proccess.
## I will make new column.

earningData$totalIncome <- earningData$Amount * earningData$Boxes.Shipped


## I will make the new column and names, ?? will make new dataframe.
## I will combine same name rows.

totalIncomeData <- aggregate(totalIncome ~ Sales.Person, data = earningData, sum)

## Data Visulation

## Install and call the libraries
install.packages("ggplot2")
library(ggplot2)  

## I will make a histogram graph.

ggplot(totalIncomeData, aes(x=Sales.Person, y=totalIncome))+
  geom_bar(stat = "identity", position = "dodge")+
  theme(
    axis.text.x = element_text(angle = 45)
  )

## I will look at mean, standard deviation results.

mean_totalIncome <- mean(totalIncomeData$totalIncome, na.rm = TRUE) ## Mean
sd_TotalIncome <- sd(totalIncomeData$totalIncome, na.rm = TRUE) ## Standard deviation
max_totalIncome <- max(totalIncomeData$totalIncome, na.rm = TRUE) ## max value
min_totalIncome <- min(totalIncomeData$totalIncome, na.rm = TRUE) ## min value

# INTERPRETING

## When we look at the our sales numbers, we can say we have anormal distrubiton.
## Standard deviation is so high. So our some personals have high kevel sales performances but
## our some personals are so minimal. When we look at the min and max value, we can see that.
## Therefor we should understand why some personals have highly level, some personels have low level
## sales. Therefore we should look at the other columns.