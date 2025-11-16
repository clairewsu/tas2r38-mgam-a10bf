library(lmerTest)

args = commandArgs(trailingOnly=TRUE)
file=args[1]
adsp=read.csv(paste0(file,".csv"))
output=paste0(file,".lm.output.txt")
if (file.exists(output)) {
file.remove(output)
}

for (i in colnames(adsp)[20:217]) {
adsp=subset(adsp,i>0)
m=lmer(as.numeric(adsp[[i]])~PHC_Sex+PHC_Education+apoe4+PHC_Age_T1*(g1+g2+g3)+(1|RID),data=adsp)
print(i)
sink(output,type=c("output","message"),append=T)
cat("\n\n\n")
cat(i)
cat("\n\n\n")
sink()
capture.output(summary(m),file=output,append=T)
}
