corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  # Calc number of complete obs for all files
  ob<-complete(directory,1:332)
  # Get subset of files that meet threshold
  completecases<-subset(ob,nobs > threshold)
  # Get the ids of the required files
  id<-completecases[[1]]
  
  cr_vec<-vector(mode="numeric",length=0)
  
  for(file in id)
  {
    # Create the complete filename from input
    f<-paste(sprintf("%03d",file),".csv",sep="")
    
    # Create the full filepath
    fpath<-file.path(directory,f)
    
    # Read in the required data file
    data<-read.csv(fpath)
    
    # Get subset of data which is correct
    j<-subset(data, !is.na(sulfate) & !is.na(nitrate))
    cr<-cor(j$sulfate,j$nitrate)
    #cr<-round(cr,digits=5)
    cr_vec<-c(cr_vec,cr)
  }
  return(cr_vec)
}
