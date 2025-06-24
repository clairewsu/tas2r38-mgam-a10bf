args = commandArgs(trailingOnly=TRUE)
file=args[1]
aa=args[2]
rosmapgt=read.csv(paste0(file,".gt.csv"))
output=paste0(file,".",aa,".lm.output.txt")
if (file.exists(output)) {
file.remove(output)
}

for (i in colnames(rosmapgt)[22:928]) {
m=lm(as.numeric(rosmapgt[[i]])~msex+educ+RIN+pmi+apoe4+age_death+get(aa)+as.factor(sequencingBatch),data=rosmapgt)
print(i)
sink(output,type=c("output","message"),append=T)
cat("\n\n\n")
cat(i)
cat("\n\n\n")
sink()
capture.output(summary(m),file=output,append=T)
}
