
rm(list = ls())

library(EBImage)
library(ranger)
library(MyHelperFunctions)
library(caret)
library(gtools)
library(gbm)
library(pryr)
library(tensorflow)

plotMNIST <- defmacro(x, expr = {
  Im1 <- matrix(as.numeric(MNISTtrain[x, -1]), 28, 28, byrow = T)
  Im2 <- t(apply(Im1, 2, rev)) # the image function for some reason draws bottom up
  graphics::image(z = Im2, col = grey(seq(1, 0, length = 256)))
})

#---------------------------------------------------------------------------------------------

MNISTtrain <- read.csv("D:/29 ImageRecognition/R/Data/MNIST/mnist_train.csv", header = F)
colnames(MNISTtrain) <- c("Y", paste0("P", 1:784))
MNISTtrain$Y <- as.factor(MNISTtrain$Y)

#---------------------------------------------------------------------------------------------

Xs <- paste0("P", 1:784)
Y <- "Y"

set.seed(432)
sampVec <- sample(1:60000, 20000)
Train <- MNISTtrain[1:10000,]
Val <- MNISTtrain[50001:60000,]

# ranger
#---------------------------------------------------------------------------------------------

system.time({
  set.seed(12345)
  ranger1 <- ranger(create.formula(Y, Xs),
                    data = Train,
                    num.trees = 1000)
})

# pred <- predict(ranger1, data = Val)$predictions

tf$abs

# gbm
#---------------------------------------------------------------------------------------------

system.time({
  set.seed(12345)
  gbm1 <- gbm(formula = create.formula(Y, Xs),
              distribution = "multinomial",
              data = Train,
              # weights,
              # var.monotone = NULL,
              n.trees = 20,
              interaction.depth = 2,
              n.minobsinnode = 10,
              shrinkage = 0.001,
              bag.fraction = 0.8,
              train.fraction = 1.0,
              cv.folds=0,
              keep.data = FALSE,
              verbose = "CV",
              class.stratify.cv=NULL,
              n.cores = NULL)
})

object_size(gbm1)

mem_used()

pred <- predict(gbm1, newdata = Train, n.trees = 100, type="response")
pred <- max.col(pred[,,1])
pred <- pred - 1

# tensorflow
#------------------------------------------------------------------------------------------------------------




#------------------------------------------------------------------------------------------------------------

obs <- Val$Y
obs <- Train$Y

confusionMatrix(obs, pred)

Wrong <- data.frame(pred,obs)
Wrong <- Wrong[pred != obs,]

x <- 50000 + 1
plotMNIST(x)

#---------------------------------------------------------------------------------------------



