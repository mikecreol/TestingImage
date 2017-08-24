
options(digits = 22)

numGradient <- function(f, x, h = 0.0001){
  # numerically compute the gradient as computing the derivative in each direction
  # f is a function
  # x is a point
  # h is the increase
  
  grad <- numeric()
  
  for(i in 1:length(x)){
    xnew <- x
    xnew[i] <- x[i] + h
    grad[i] <- (f(xnew) - f(x)) / h
  }
  
  return(grad)
}

testF <- function(x){
  y <- x[1]^2 + x[2] + x[3]
  return(y)
}

testF(c(3.0001, 2, 2))
testF(c(3, 2, 2))

numGradient(testF, c(3,2,2))
debug(numGradient)

#-----------------------------------------------------------------------------------------------------------

driverVars<- c("q6_1_1","q6_5_1","q6_9_1","q6_10_1","q6_11_1","q6_12_1","q6_13_1","q6_14_1","q6_15_1","q6_16_1","q6_17_1","q6_18_1",          
               "q6_19_1","q6_20_1","q6_21_1","q6_22_1","q6_23_1","q6_24_1" )

InitData <- read_spss("D:\\24 KDA\\R\\Data\\YTD2016_for_gemseek.sav")

attr(InitData), "variable.labels")

which(colnames(InitData) %in% driverVars)

labels(InitData)
