library(data.table)
library(WGCNA)
args = commandArgs(trailingOnly=TRUE)
file=args[1]
output=paste0(file,".cor.sig.csv")
if (file.exists(output)) {
file.remove(output)
}

exp=fread("~/projects/rosmap/data/rnaseq/Gene Expression (Normalized Counts and Differential Expression)/Filtered, Normalized, and Residualized Counts/ROSMAP_Residualized_counts_(diagnosis).tsv",header=T,check.names=F,data.table=F)
rownames(exp)=exp$feature
exp=exp[-1]
id=fread(paste0(file,".csv"),header=T,check.names=F,data.table=F)
cor=exp[colnames(exp)%in%id$specimenID]
corlist <- corAndPvalue(x = t(cor["ENSG00000257335",]), y = t(cor), method = "pearson")
cor_df <- data.frame(melt(corlist$cor)[,2:3], melt(corlist$p)[,3])
colnames(cor_df)[1]="gene"
colnames(cor_df)[2]="cor"
colnames(cor_df)[3]="pvalue"
cor_df$pfdr=p.adjust(cor_df$pvalue,method="fdr")
corsig=subset(cor_df,pfdr<.05)
write.csv(file=output,corsig,row.names=F,quote=F)
