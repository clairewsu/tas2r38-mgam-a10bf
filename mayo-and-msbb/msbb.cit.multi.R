library(plyr)
library(cit)
library(doParallel)
library(pbapply)
library(WGCNA)
library(parallel)
nperm=1000
ncores=8

args = commandArgs(trailingOnly=TRUE)
file=args[1]
input=read.csv(paste0(file, ".csv"))
output=paste0(file,".cit.output.csv")
#if (file.exists(output)) {
#file.remove(output)
#}

candidate_T=colnames(input)
candidate_T=candidate_T[grep("ENSG", candidate_T)]
mediator2trait_CIT_list <- mclapply(X = candidate_T,mc.silent = FALSE, mc.cores = ncores, mc.preschedule = TRUE, mc.set.seed = 12345, function(T_i) {
                    l_i <- input$g1
                    g_i <- input$mgam.x
                    t_i <- input[T_i]
                    print(T_i)
                    fdr.cit(list(res1 = cit.cp(L = l_i, G = g_i, T = t_i, n.perm = nperm)))
})
names(mediator2trait_CIT_list)=candidate_T
mediator2trait_CIT_df <- ldply(mediator2trait_CIT_list, rbind, .id = "Transgene")
write.csv(file=output,mediator2trait_CIT_df,row.names=F,quote=F)

