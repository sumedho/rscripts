runAllMenuTimes<-function(dir_to_use)
{
    files<-list.files(dir_to_use)
    df<-data.frame()
    for(n in 1:length(files))
    {
        filep<-file.path(dir_to_use,files[n])
        print(filep)
        data<-ParseMenuLogTime(filep)
        if(dim(data) != 0)
        {
            df<-rbind(df,data)
        }
    }
    df$user<-as.factor(df$user)
    df$menu<-as.numeric(df$menu)
    df$sec<-as.numeric(df$sec)
    df$licensekey<-as.factor(df$licensekey)
    df$config<-as.factor(df$config)
    df$os<-as.factor(df$os)
    df$vulcanversion<-as.factor(df$vulcanversion)
    return(df)
}