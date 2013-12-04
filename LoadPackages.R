#install (when not yet installed) and load the necessary packages
update.packages(ask=F)
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    
  }
  library(x,character.only=T)
}
neededPackages<-c("rgdal","ggplot2","png","plyr","raster","reshape","scales")
for (package in neededPackages){pkgTest(package)}

