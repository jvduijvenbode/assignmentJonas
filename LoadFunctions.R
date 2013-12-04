#convert factor data with unnecessary comma's to numeric data
factortopopnum<-function(x){
  x1<-unlist(strsplit(x,split=","))
  x2<-as.numeric(paste(x1,collapse=""))
  return(x2)  
}

#select a year of the worldpopulation to use in this script
sel_year<-function(poptable,y){
  #make year readable for dataframe
  years<-paste0("X",as.character(y))
  #select the data from the selected year
  outtable<-(cbind(as.data.frame(poptable$ISO.country.code),poptable$Country))
  for (year in years){
    #convert the selected year factor values to numerical data
    convertedyear<-mapply(as.character(poptable[,year]),FUN=factortopopnum)
    outtable<-cbind(outtable,convertedyear)    
  }
  names(outtable)<-c("ISO2","country",paste0("population",as.character(years)))
  #remove countries with no country code
  outtable<-outtable[outtable$ISO2!="",]  
  return(outtable)
}

#convert Inf data created by dividing by zero (missing data) to NA
Inf2NA <- function(x){
  for (i in 1:ncol(x)){
    x[,i][is.infinite(x[,i])] = NA
  }
  return(x)
}