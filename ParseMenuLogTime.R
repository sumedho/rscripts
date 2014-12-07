ParseMenuLogTime<-function(file)
{
    require(XML)
    data<-xmlTreeParse(file) # Parse XML file
    user<-unlist(strsplit(file[1],"_"))[2] # Grab username from filename
    r<-xmlRoot(data) # Grab root of xml file
    numlog<-length(names(r)) # Find number of session logs
    df<-data.frame(user=character(numlog),menu=integer(numlog),timeopen=character(numlog),
                   timeclosed=character(numlog),sec=integer(numlog),
                   licensekey=character(numlog),config=character(numlog),
                   os=character(numlog),vulcanversion=character(numlog),stringsAsFactors=FALSE)
    # Loop through all sessions in xml file
    for(i in 1:numlog) 
    {
        nummenu<-length(names(r[[i]][[6]])) # Find length of Menuitem logs
        lk<-xmlGetAttr(r[[i]][[2]],"LicenseKey") # Get license key
        lc<-xmlGetAttr(r[[i]][[2]],"Configuration") # Get license config
        vv<-r[[i]][[3]][[1]]$value # Get vulcan version
        t1<-as.POSIXct(r[[i]][[1]][[1]]$value, format= '%Y/%m/%d %H:%M:%S') # Get start time in posix format
        t2<-as.POSIXct(r[[i]][[7]][[1]]$value, format= '%Y/%m/%d %H:%M:%S') # Get close time in posix format
        to<-r[[i]][[1]][[1]]$value # Get time open in char format
        tc<-r[[i]][[7]][[1]]$value # Get time closed in char format
        timesec<-as.numeric(difftime(t2,t1), units="secs") # Calculate time between open and closed
        os<-unname(xmlAttrs(r[[1]][[4]])[1]) # Get os name
        df[i,]<-c(user,nummenu,to,tc,timesec,lk,lc,os,vv) # change row in data.frame  
    }
    return(df) # Return data frame
}