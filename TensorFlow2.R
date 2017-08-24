
devtools::install_github("rstudio/tensorflow")

Sys.setenv(TENSORFLOW_PYTHON="/usr/local/bin/python")
library(tensorflow)

library(tensorflow)
sess = tf$Session()
hello <- tf$constant('Hello, TensorFlow!')
sess$run(hello)

a <- tf$constant(10L)
b <- tf$constant(32L)
sess$run(a + b)

