args=commandArgs(trailingOnly=TRUE)
a=args[1]
b=args[2]
c=args[3]
output="rosmap.sig.csv"
if (file.exists(output)) {
file.remove(output)
}

for (i in c(a,b,c)) {
 print(i)
 sink(output,type=c("output","message"),append=T)
 cat("\n\n\n")
 cat(i)
 cat("\n\n\n")
 sink()
 for (j in c(1:3)) { 
 rosmap=read.csv(paste0("fdr.adjusted.",i,".g",j,".pvalue.csv"))
 rosmap=subset(rosmap,adjusted<.05)
 print(rosmap)
 capture.output(rosmap,file=output,append=T)
 }
}

