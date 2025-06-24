library(data.table)
library(dplyr)
library(stringr)

args=commandArgs(trailingOnly=T)
file=args[1]
nacc=fread("~/projects/nacc/data/new/investigator_nacc69.csv",header=T,check.names=F,data.table=F)
match=read.csv(paste0(file,".csv"))
output=paste0(file,".diff.txt")
if (file.exists(output)) {
file.remove(output)
}

match=match[colnames(match)%in%c("NACCID","NACCAGEB","NACCNE4S","SEX","EDUC","RACE","A10A","A10BA","A10BB",
"A10BF","A10BG","A10BH","A10BJ","A10BK","A10BX")]
other=nacc[colnames(nacc)%in%c("NACCID","NACCVNUM","HISPANIC","NACCMOM","NACCDAD","TOBAC100","ALCOHOL","ABUSOTHR",
"NACCBMI","CVHATT","CVCHF","CVANGINA","CVOTHR","CVDCOG","CVDSIGNS","DEP","BIPOLDX","SCHIZOP","ANXIET","DELIR",
"PTSDDX","OTHPSY","DEL","HALL","AGIT","DEPD","ANX","ELAT","APA","DISN","IRR","MOT","NITE","APP","HYPCHOL",
"VB12DEF","NACCAHTN","NACCLIPL","NACCNSD","NACCADEP","NACCAPSY","NACCPDMD","NACCAANX","HXHYPER")]
other=subset(other,NACCVNUM=="1")
other=inner_join(other,match)

other$familydement=ifelse(str_count(paste0(other$NACCMOM,other$NACCDAD),"1")>0,1,0)
other$heart=ifelse(str_count(paste0(other$CVHATT,other$CVCHF,other$CVANGINA,other$CVOTHR),"1")>0,1,0)
other$cvd=ifelse(str_count(paste0(other$CVDCOG,other$CVDSIGNS),"1")>0,1,0)
other$neuro=ifelse(str_count(paste0(other$DEP,other$BIPOLDX,other$SCHIZOP,other$ANXIET,other$DELIR,other$PTSDDX,
other$PSY),"1")>0,1,0)
other$neuropsy=ifelse(str_count(paste0(other$DEL,other$HALL,other$AGIT,other$DEPD,other$ANX,other$ELAT,other$APA,
other$DISN,other$IRR,other$MOT,other$NITE,other$APP),"1")>0,1,0)

for(i in 44:3){
 a=sum(other[[i]]=="-4")
 if(a>57){
  print(colnames(other)[i]) 
  other[-i]
  }
 }

print("--tests--")

fisher=c("NACCNE4S","SEX","HISPANIC","TOBAC100","ALCOHOL","ABUSOTHR","HYPCHOL","VB12DEF","NACCAHTN","NACCLIPL",
"NACCNSD","NACCADEP","NACCAPSY","NACCPDMD","NACCAANX","HXHYPER","familydement","heart","cvd","neuro","neuropsy",
"A10BA","A10BB","A10BF","A10BG","A10BH","A10BJ","A10BK","A10BX")

for(i in fisher){
 if(i%in%colnames(other)){
  print(i)
  sink(output,type=c("output","message"),append=T)
  cat("\n\n\n")
  cat(i)
  cat("\n\n\n")
  cat(table(other$A10BF,other[[i]]))
  cat("\n\n\n")
  sink()
  capture.output(fisher.test(table(subset(other,i!="-4")$A10BF,subset(other,i!="-4")[[i]])),file=output,append=T)
  }
 }
 
if("EDUC"%in%colnames(other)){
  print("EDUC")
  sink(output,type=c("output","message"),append=T)
  cat("\n\n\n")
  cat("EDUC")
  cat("\n\n\n")
  sink()
  capture.output(t.test(EDUC~A10BF,data=other),file=output,append=T)
}

if("NACCAGEB"%in%colnames(other)){
  print("NACCAGEB")
  sink(output,type=c("output","message"),append=T)
  cat("\n\n\n")
  cat("NACCAGEB")
  cat("\n\n\n")
  sink()
  capture.output(t.test(NACCAGEB~A10BF,data=other),file=output,append=T)
} 
if("NACCBMI"%in%colnames(other)){
  print("NACCBMI")
  sink(output,type=c("output","message"),append=T)
  cat("\n\n\n")
  cat("NACCBMI")
  cat("\n\n\n")
  sink()
  capture.output(t.test(NACCBMI~A10BF,data=subset(other,NACCBMI<300&NACCBMI>0)),file=output,append=T)
 }
