#set and create working directory if not yet existing
filedir<-getwd()
#unzip the data to the working directory
if(file.exists("worldspf.zip")){
  unzip(zipfile=file.path(filedir,"worldspf.zip"),overwrite=F,exdir=filedir)
}else{
  download.file(url="http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip",destfile="worldspf.zip")
  unzip(zipfile="worldspf.zip",overwrite=F,exdir=filedir)
}
#load the world shapefile with all countries as polygon to Sworld
Sworld<-Sworld<-readOGR(dsn=filedir,layer="TM_WORLD_BORDERS-0.3")
#load population data for different years to worldpop
worldpop<-read.csv("worldpop.csv",skip=2,header=T)