args=commandArgs(trailingOnly=T)
library(ggpubr)
fp=read.csv(args[1])
ifg=read.csv(args[2])
phg=read.csv(args[3])
stg=read.csv(args[4])

fp$braak=factor(fp$braak,levels=c("6","5","4","3","2","1","0"))
ifg$braak=factor(ifg$braak,levels=c("6","5","4","3","2","1","0"))
phg$braak=factor(phg$braak,levels=c("6","5","4","3","2","1","0"))
stg$braak=factor(stg$braak,levels=c("6","5","4","3","2","1","0"))

fpbox=ggboxplot(data=fp,x="g1",y="mgam",color="braak",add="jitter")
ifgbox=ggboxplot(data=ifg,x="g1",y="mgam",color="braak",add="jitter")
phgbox=ggboxplot(data=phg,x="g1",y="mgam",color="braak",add="jitter")
stgbox=ggboxplot(data=stg,x="g1",y="mgam",color="braak",add="jitter")

plot=ggarrange(fpbox,ifgbox,phgbox,stgbox,nrow=2,ncol=2,common.legend=T,legend="top",
labels=c("fp","ifg","phg","stg"))

ggsave("msbb.box.script.png",plot,w=8,h=6)
