#check if the output must be in degrees or percentages
ifelse(SettingY=="percentage",label<-"population in percentage",label<-"total population")
DFperdegM<-melt(DFperdeg,id.vars="degrees")

if(orient=="LONG"){
  popplot<-ggplot(DFperdegM,aes(x=degrees-180,y=value,group=variable,fill=variable))+
    annotation_raster(Rworld, -180, 180, 0, max(DFperdegM$value), interpolate = F)+
    geom_area(alpha=0.2,position="dodge")+
    scale_y_continuous(labels = comma)+
    xlab("degrees longitude")+
    ylab(label)+
    ggtitle(paste("population per degree for the years",paste(years,collapse=" , ")))+
    ylab(SettingY)+
     theme(panel.grid.minor=element_blank(),
           legend.title = element_blank())      
        

}else{if(orient=="LAT"){
    popplot<-ggplot(DFperdegM,aes(x=(-1)*(degrees-90),y=value,group=variable,fill=variable))+
      annotation_raster(Rworld, 90,-90, 0, max(DFperdegM$value), interpolate = F)+
      coord_flip()+
      xlab("degrees latitude")+
      scale_y_continuous(labels = comma)+
      ylab(label)+
      ggtitle(paste("population per degree for the years",paste(years,collapse=" , ")))+
      geom_area(alpha=0.2,position="dodge")+ 
       theme(panel.grid.minor=element_blank(),
             legend.title = element_blank())      
            

  
}else{
  stop("only the options LONG or LAT are possible")
}
}
print(popplot)
