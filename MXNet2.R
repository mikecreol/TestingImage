
rm(list=ls())

# https://www.r-bloggers.com/deep-learning-with-mxnetr/

# install.packages("drat", repos="https://cran.rstudio.com")
# drat:::addRepo("dmlc")
# install.packages("mxnet")

#----------------------------------------------------------------------------------------------------

require(mlbench)
## Loading required package: mlbench
require(mxnet)
## Loading required package: mxnet
## Loading required package: methods
data(Sonar, package = "mlbench")

Sonar[,61] = as.numeric(Sonar[,61])-1
train.ind = c(1:50, 100:150)
train.x = data.matrix(Sonar[train.ind, 1:60])
train.y = Sonar[train.ind, 61]
test.x = data.matrix(Sonar[-train.ind, 1:60])
test.y = Sonar[-train.ind, 61]

#----------------------------------------------------------------------------------------------------







