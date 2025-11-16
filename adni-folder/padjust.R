args=commandArgs(trailingOnly=T)
p=read.csv(args[1],row.names=1)
library(tidyr)

thefunction=function(x){
x=gsub("<","",x)
x=ifelse(x=="",2e-16,x)
x=as.numeric(x)
x=p.adjust(x,method=args[2])
}

p1=sapply(p,thefunction)
rownames(p1)=rownames(p)
write.csv(file=paste0(args[2],".adjusted.",args[1]),p1,quote=F)
