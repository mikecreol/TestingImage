
# http://firsttimeprogrammer.blogspot.bg/2016/07/image-recognition-in-r-using.html
# https://www.r-bloggers.com/image-recognition-tutorial-in-r-using-deep-convolutional-neural-networks-mxnet-package/

# source("https://bioconductor.org/biocLite.R")
# biocLite("EBImage")
require(EBImage)

# Resize images and convert to grayscale
#-------------------------------------------------------------------------------------------------------------

# Set wd where images are located
setwd("D:\\29 ImageRecognition\\Images\\CatsNDogs")

# Set d where to save images
save_in <- "D:\\29 ImageRecognition\\Images\\Resized\\"

# Load images names
images <- list.files()

# Set width
w <- 300
# Set height
h <- 300

# Main loop resize images and set them to greyscale
for(i in 1:length(images))
{
  # Try-catch is necessary since some images
  # may not work.
  result <- tryCatch({
    imgname <- images[i]
    
    try({img <- readImage(imgname, type = "png")})
    try({img <- readImage(imgname, type = "jpeg")})
    
    img <- resize(img, w = w, h = h)
    img <- channel(img, "gray")
    path <- paste(save_in, imgname, sep = "")
    writeImage(img, type = "png", path, quality = 100)
    print(paste("Done",i,sep = " "))
    }, 
    error = function(e){print(e)})
}

# Generate a train-test dataset
#-------------------------------------------------------------------------------------------------------------

# Set wd where resized greyscale images are located
setwd("D:\\29 ImageRecognition\\Images\\Resized")

# Out file
out_file <- "C://dogs_28.csv"

# List images in path
images <- list.files()

# Set up df
df <- data.frame()

# Set image size. In this case 28x28
img_size <- w * h

# Set label
label <- 1

# Main loop. Loop over each image
for(i in 1:length(images))
# for(i in 1:2)
{
  # Read image
  # try(img <- readImage(images[i]))
  try(img <- readImage(images[i], type = "png"))
  
  # Get the image as a matrix
  img_matrix <- img@.Data
  # Coerce to a vector
  # img_vector <- as.vector(t(img_matrix))
  img_vector <- as.vector((img_matrix))
  # Add label
  vec <- c(label, img_vector)
  # Bind rows
  df <- rbind(df,vec)
  # Print status info
  print(paste("Done ", i, sep = ""))
}

# Set names
colnames(df) <- c("label", paste("pixel", c(1:img_size)))
rownames(df) <- images

# Write out dataset
# write.csv(df, out_file, row.names = FALSE)
save(df, file = "CatsNDogs.RData")

