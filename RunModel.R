#check if years are within range, then select the year to be plotted
years<-round(years)
if(sum(!years %in% c(1950:2100))==0){
  popyear<-sel_year(poptable=worldpop,y=years)
}else{stop("year must be between 1950 and 2100")}
#remove NA's
popyear<-na.omit(popyear)

#extract necessary data from SPDF
NSPworld<-as.data.frame(Sworld@data)
NSPworld<-NSPworld[,c(2,5,6,10,11)]

#join the census data to the spatial data
datawithpop<-join(x=NSPworld,y=popyear,by="ISO2",type="full",match="first")

#calculate the population density for every country
datawithpop[,7:ncol(datawithpop)]<-(datawithpop[,7:ncol(datawithpop)]*1000)/(datawithpop$AREA*10)
#re-insert the data into the SPDF
Sworldnew<-Sworld
Sworldnew@data<-datawithpop

#set dimensions for the raster
worldraster<-raster(ncols=360,nrows=180)
if(orient=="LONG"){
  DFperdeg<-c(1:360)
} else{
  if(orient=="LAT"){
    DFperdeg<-c(1:180)
  }else{
    stop("only the options LONG or LAT are possible")
  }
}
#create rasters from the SPDF with population density per pixel as value for every selected year
for(field in names(Sworldnew@data)[7:length(names(Sworldnew@data))]){
  Rworld<-rasterize(x=Sworldnew,y=worldraster,field=field,fun=mean)
  #convert SPDF to data frame and remove Inf and NA values
  DFworld<-as.data.frame(as.matrix(Rworld))
  DFworld<-Inf2NA(DFworld)
  DFworld[is.na(DFworld)]<-0
  
  #calculate the square kilometer per pixel, 510072000 being the number of square kilometers on earth
  kmperpixel<-510072000/(nrow(DFworld)*ncol(DFworld))
  
  if(SettingY=="total"){
    DFworld<-DFworld*kmperpixel
  } else{
    if(SettingY=="percentage"){
      DFworld<-(DFworld/sum(DFworld))*100
    }else{
      stop("only the options total or percentage are possible")
    }
  }

  #calculate the sum of percentages or total per degree
  if(orient=="LONG"){
    DFperdeg<-cbind(DFperdeg,colSums(DFworld))
  } else{
    if(orient=="LAT"){
      DFperdeg<-cbind(DFperdeg,rowSums(DFworld))
    }else{
      stop("only the options LONG or LAT are possible")
    }
  }
}
DFperdeg<-as.data.frame(DFperdeg)
names(DFperdeg)<-c("degrees",paste("population",as.character(years)))