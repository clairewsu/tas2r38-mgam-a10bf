args = commandArgs(trailingOnly=TRUE)
file=args[1]
msbbgt=read.csv(paste0(file,".csv"))
output=paste0(file,"g1.lm.output.txt")
output2=paste0(file,"g2.lm.output.txt")
output3=paste0(file,"g3.lm.output.txt")
if (file.exists(output)) {
file.remove(output)
}
if (file.exists(output2)) {
file.remove(output2)
}
if (file.exists(output3)) {
file.remove(output3)
}

for (i in colnames(msbbgt)[1:19]) {
m=lm(as.numeric(msbbgt[[i]])~sex+pmi+apoe4+ageDeath+g1,data=msbbgt)
n=lm(as.numeric(msbbgt[[i]])~sex+pmi+apoe4+ageDeath+g2,data=msbbgt)
o=lm(as.numeric(msbbgt[[i]])~sex+pmi+apoe4+ageDeath+g3,data=msbbgt)
print(i)
sink(output,type=c("output","message"),append=T)
cat("\n\n\n")
cat(i)
cat("\n\n\n")
sink()
sink(output2,type=c("output","message"),append=T)
cat("\n\n\n")
cat(i)
cat("\n\n\n")
sink()
sink(output3,type=c("output","message"),append=T)
cat("\n\n\n")
cat(i)
cat("\n\n\n")
sink()
capture.output(summary(m),file=output,append=T)
capture.output(summary(n),file=output2,append=T)
capture.output(summary(o),file=output3,append=T)
}
