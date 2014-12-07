complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  # Loop through files 
  
  # Create vector of total complete observations values
  nobs<-vector(mode="numeric",length=0)
    
  for(file in id)
  {
    # Create the complete filename from input
    f<-paste(sprintf("%03d",file),".csv",sep="")
    
    # Create the full filepath
    fpath<-file.path(directory,f)
    
    # Read in the required column
    data<-read.csv(fpath)
    
    # Get subset of data which is correct
    j<-subset(data, !is.na(sulfate) & !is.na(nitrate))
    # Get
    k<-dim(j)
    # add to the nobs vector
    nobs<-c(nobs,k[1])
  }
  # Create a data frame with the ids and nobs
  complete<-data.frame(id,nobs)
  return(complete) #return the complete data frame
}