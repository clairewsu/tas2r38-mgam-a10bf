library(lmerTest)

args = commandArgs(trailingOnly=TRUE)
file=args[1]
nacc=read.csv(paste0(file,".csv"))
output=paste0(file,".lm.output.txt")
if (file.exists(output)) {
file.remove(output)
}

for (i in colnames(nacc)[20:27]) {
m=lmer(as.numeric(nacc[[i]])~SEX+EDUC+as.factor(RACE)+as.factor(NACCNE4S)+NACCAGE.y+time*mgam+(1|NACCID),data=nacc)
print(i)
sink(output,type=c("output","message"),append=T)
cat("\n\n\n")
cat(i)
cat("\n\n\n")
sink()
capture.output(summary(m),file=output,append=T)
}
