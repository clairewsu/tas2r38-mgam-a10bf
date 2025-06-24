library(data.table)

args=commandArgs(trailingOnly=T)
file=args[1]
output=paste0(file,".code.csv")
if (file.exists(output)) {
file.remove(output)
}

code1=read.csv("code.csv",header=F)
drug=read.csv(paste0(file,".csv"))
drug$code=0
code1$V2=toupper(code1$V2)

for(i in rownames(drug)){
 for(j in rownames(code1)){
  drug[i,"code"]=ifelse(drug[i,"drug"]%like%code1[j,2],code1[j,1],drug[i,"code"])
#  print(paste(j,drug[i,"drug"],code1[j,2]))
  } 
 print(i)
 }
 
write.csv(file=output,drug,row.names=F,quote=F)
