ParseMenuLog<-function(file)
{
  data<-xmlTreeParse(file) # Parse XML file
  user<-unlist(strsplit(file[1],"_"))[2] # Grab username from filename
  r<-xmlRoot(data) # Grab root of xml file
  numlog<-length(names(r)) # Find number of session logs
  vector<-character() # Create empty char vector
  
  # Loop through all sessions in xml file
  for(i in 1:numlog) 
  {
    nummenu<-length(names(r[[i]][[6]])) # Find length of Menuitem logs
    # If more than zero menu logs then loop through them
    if(nummenu > 0) 
    {
      for(j in 1:nummenu)
      {
        tags<-sub(":.*","",xmlGetAttr(r[[i]][[6]][[j]],"Tag")) # Grab tags of menu items, remove anything after :
        vector<-c(vector,tags)
      }
    }  
  }
  ans<-summary(as.factor(vector))
  function_used<-names(ans) # Get names of functions used
  count<-unname(ans) # Get freq of usage
  username<-rep(user,length(count)) # Attach username
  df<-data.frame(username,function_used,count)
  df<-df[order(-df$count),]
  return(df)
}

