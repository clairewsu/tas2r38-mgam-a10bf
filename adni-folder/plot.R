library(lmerTest)
library(ggpubr)
library(ggsci)
library(ggeffects)
args = commandArgs(trailingOnly=TRUE)

pepo=args[1]
file2=args[2]
filesig=read.csv(pepo)
filereal=read.csv(file2)
filesig=subset(filesig,g1<1E-5&g2<1E-5)

for (i in filesig$X) {
m=lmer(as.numeric(filereal[[i]])~PTGENDER_name+PTEDUCAT_name+age*(g1+g2+g3)+apoe4+(1|RID),data=filereal)
prd=as.data.frame(ggpredict(m,c("age","g1","g2","g3")))
prd$gt=paste(prd$group,prd$facet,prd$panel,sep="")
prdtaster=subset(prd,gt %in% c("202","111","020"))
prdtaster$taster=prdtaster$gt
prdtaster$taster=gsub("020","non",prdtaster$taster)
prdtaster$taster=gsub("111","hetero",prdtaster$taster)
prdtaster$taster=gsub("202","super",prdtaster$taster)
plot=ggplot()+geom_line(data=filereal,aes(x=age,y=as.numeric(filereal[[i]]),group=
as.factor(RID),color=taster), size=0.1)+theme_classic()+geom_line(data=prdtaster, aes(x=x,y=predicted, group=taster, color=taster),size=1)+geom_ribbon(data=prdtaster,aes(x=x,ymin=conf.low, ymax=conf.high, group=taster), alpha=0.1)+scale_color_jco(breaks=c("super","hetero","non","other"))+xlim(60,100)+ylim(-.1,max(filereal[[i]]))+ylab(gsub("_combat","",i))
ggsave(file=paste("fs",i,"png",sep="."),plot,w=8,h=8)
}

