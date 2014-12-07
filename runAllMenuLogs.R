runAllMenuLogs<-function(dir)
{
    files<-list.files("logs")
    df<-data.frame()
    for(n in 1:length(files))
    {
        filep<-file.path(dir,files[n])
        print(filep)
        data<-ParseMenuLog(filep)
        if(dim(data) != 0)
        {
            df<-rbind(df,data)
        }
    }
    return(df)
    
}