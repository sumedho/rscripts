polmean2<-function(directory,pollutant,id=1:332)
{
    file_list<-list.files(directory,full.names=TRUE,pattern="*.csv")
    pollution<-data.frame()
    for(i in id)
    {
        pollution<-rbind(pollution,read.csv(file_list[i]))
    }
    summary(pollution)
}