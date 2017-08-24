
setwd("D:\\29 ImageRecognition\\Images")

library(rvest)
library(stringr)

#------------------------------------------------------------------------------------------------------

inputFile <- "cats2.txt"
a <- readChar(con = inputFile, file.info(inputFile)$size)
a2 <- str_extract_all(a, "\"https://encrypted(.*?)\"")[[1]]
a3 <- gsub("\"", "", a2)

for(i in 1:length(a3)){
  try(download.file(a3[i], paste0("cats", i + 205, '.jpg'), mode = 'wb'))
}

#------------------------------------------------------------------------------------------------------

require(EBImage)

options("EBImage.display" = "raster")

load("CatsNDogs.RData")

img <- readImage("D:/29 ImageRecognition/Images/CatsNDogs/cats1.jpg")
img_matrix <- img@.Data
img_matrix <- img_matrix - mean(img_matrix)
img_matrix2 <- rgbImage(red = img_matrix[,,1], 
                        green = img_matrix[,,2], 
                        blue = img_matrix[,,3])

# img_matrix2 <- img_matrix[,,1] + img_matrix[,,2] + img_matrix[,,3]
display(img_matrix2, method = "raster", all = TRUE)

## Display a thresholded sequence ...
y = readImage(system.file("images", "sample.png", package="EBImage"))
yt = list()
for (t in seq(0.1, 5, len=9)) yt=c(yt, list(gblur(y, s=t)))
yt = combine(yt)
## ... using the browser viewer ...
display(yt, "Blurred images")
## ... or using R's build-in raster functions
display(resize(yt, 256, 256), method = "raster", all = TRUE)
## Display the last frame 
display(yt, method = "raster", frame = numberOfFrames(yt, type = "render"))

#--------------------------------------------------------------------------------


