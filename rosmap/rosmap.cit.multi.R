library(plyr)
library(cit)
library(doParallel)
library(pbapply)
library(WGCNA)
library(parallel)
library(data.table)
nperm=1000
ncores=8

args = commandArgs(trailingOnly=TRUE)
file=args[1]
input=fread(paste0(file, ".csv"),header=T,check.names=F,data.table=F)
sig=read.csv(paste0(file,".cor.sig.csv"))
output=paste0(file,".cit.output.csv")
if (file.exists(output)) {
file.remove(output)
}

input=subset(input,taster!="other")
genes=colnames(input)
genes=genes[grep("ENSG",genes)]
genes=intersect(genes,sig$gene)
candidate_T=genes
mediator2trait_CIT_list <- mclapply(X = candidate_T,mc.silent = FALSE, mc.cores = ncores, mc.preschedule = TRUE, mc.set.seed = 12345, function(T_i) {
                    l_i <- input$g1
                    g_i <- input$ENSG00000257335
                    t_i <- input[T_i]
                    print(T_i)
                    fdr.cit(list(res1 = cit.cp(L = l_i, G = g_i, T = t_i, n.perm = nperm)))
})
names(mediator2trait_CIT_list)=candidate_T
mediator2trait_CIT_df <- ldply(mediator2trait_CIT_list, rbind, .id = "Transgene")
write.csv(file=output,mediator2trait_CIT_df,row.names=F,quote=F)

