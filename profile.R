Rprof("test1.out")
replicate(n=1000,sapply(split(DT$pwgtp15,DT$SEX),mean))
Rprof("NULL")
summaryRprof("test1.out")


