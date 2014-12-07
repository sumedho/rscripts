ParseMenuLog<-function(file)
{
  data<-xmlTreeParse(file) # Parse XML file
  user<-unlist(strsplit(file[1],"_"))[2] # Grab username from filename
  r<-xmlRoot(data) # Grab root of xml file
  numlog<-length(names(r)) # Find number of session logs
  menuitem<-character() # Create empty char vector
  username<-character()
  licensekey<-character()
  licenseconfig<-character()
  timeopen<-character()
  timeclosed<-character()
  os<-character()
  vulcanversion<-character()
  
  # Loop through all sessions in xml file
  for(i in 1:numlog) 
  {
    nummenu<-length(names(r[[i]][[6]])) # Find length of Menuitem logs
    # If more than zero menu logs then loop through them
    lk<-xmlGetAttr(r[[i]][[2]],"LicenseKey")
    lc<-xmlGetAttr(r[[i]][[2]],"Configuration")
    vv<-r[[i]][[3]][[1]]$value
    to<-r[[i]][[1]][[1]]$value
    tc<-r[[i]][[7]][[1]]$value 
    opsis<-unname(xmlAttrs(r[[1]][[4]])[1])
    if(nummenu > 0) 
    {
      for(j in 1:nummenu)
      {
        tags<-sub(":.*","",xmlGetAttr(r[[i]][[6]][[j]],"Tag")) # Grab tags of menu items, remove anything after :
        menuitem<-c(menuitem,tags)
        username<-c(username,user)
        licensekey<-c(licensekey,lk)
        licenseconfig<-c(licenseconfig,lc)
        vulcanversion<-c(vulcanversion,vv)
        timeopen<-c(timeopen,to)
        timeclosed<-c(timeclosed,tc)
        os<-c(os,opsis)
      }
    }  
  }
  #ans<-summary(as.factor(vector))
  #function_used<-names(ans) # Get names of functions used
  #count<-unname(ans) # Get freq of usage
  #username<-rep(user,length(vector)) # Attach username
  df<-data.frame(username,menuitem,licensekey,licenseconfig,vulcanversion,timeopen,timeclosed,os)
  #df<-df[order(-df$count),]
  return(df)
}

