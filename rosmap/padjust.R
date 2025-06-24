args=commandArgs(trailingOnly=T)
p=read.csv(args[1],row.names=1)
library(tidyr)
library(dplyr)
a=read.csv("~/projects/rosmap/data/annotation/chr7.cis.csv")
p=subset(p,rownames(p)%in%a$gene)

thefunction=function(x){
x=gsub("<","",x)
x=ifelse(x=="",2e-16,x)
x=as.numeric(x)
x=p.adjust(x,method=args[2])
}

p1=sapply(p,thefunction)
p1=as.data.frame(p1)
rownames(p1)=rownames(p)
p1=p1[7]
colnames(p1)[1]="adjusted"
p2=cbind(p,p1)
write.csv(file=paste0(args[2],".adjusted.",args[1]),p2,quote=F)
