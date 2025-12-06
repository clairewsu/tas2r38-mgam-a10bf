library(ComplexHeatmap)
library(circlize)
p<-read.csv(file="pvalue.csv")
p<-read.csv(file="pvalue.csv",row.names=1,check.names=F)
logp<-p[-4]
logp<-log(logp)/log(10)
col_fun = colorRamp2(c(-16, -1), c("red", "white"))
col_fun2 = colorRamp2(c(0, 0.5), c("white", "blue"))
Heatmap(as.matrix(logp),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top", 
col=col_fun,row_names_side = "left",
cell_fun = function(j, i, x, y, width, height, fill) {
         grid.text(p1[i, j], x, y, gp = gpar(fontsize = 10))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value")
Heatmap(as.matrix(logp),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top", 
col=col_fun,row_names_side = "left",
cell_fun = function(j, i, x, y, width, height, fill) {
         grid.text(p1[i, j], x, y, gp = gpar(fontsize = 10))},
Heatmap(as.matrix(logp),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top", 
col=col_fun,row_names_side = "left",
cell_fun = function(j, i, x, y, width, height, fill) {
         grid.text(p[i, j], x, y, gp = gpar(fontsize = 10))},
width = ncol(p)*unit(20, "mm"), height = nrow(p)*unit(10, "mm"), name="p-value")
p1<-p[-4]
logp1<-logp
Heatmap(as.matrix(logp1),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top", 
col=col_fun,row_names_side = "left",
cell_fun = function(j, i, x, y, width, height, fill) {
         grid.text(p1[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
Heatmap(as.matrix(logp1),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top", 
col=col_fun,row_names_side = "left",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
p1[4,1]="<2e-16"
p1[10,1]="<2e-16"
logp1s<-logp1
p1s<-p1
Heatmap(as.matrix(logp1s),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun,row_names_side = "left",                                            
cell_fun = function(j, i, x, y, width, height, fill) {                          
         if( p1s[i,j] == "<2e-16" | as.numeric(p1s[i,j])<0.05)
         grid.text(p1s[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
p1s<-formatC(p1, format = "e", digits = 2)
p1s$sex<-formatC(p1$sex, format = "e", digits = 2)
Heatmap(as.matrix(logp1s),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun,row_names_side = "left",                                            
cell_fun = function(j, i, x, y, width, height, fill) {                          
         if( p1s[i,j] == "<2e-16" | as.numeric(p1s[i,j])<0.05)
         grid.text(p1s[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
p1s$age_death<-as.character(formatC(p1$age_death, format = "e", digits = 2)
p1s$age_death<-as.character(formatC(p1$age_death, format = "e", digits = 2))
Heatmap(as.matrix(logp1s),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun,row_names_side = "left",                                            
cell_fun = function(j, i, x, y, width, height, fill) {                          
         if( p1s[i,j] == "<2e-16" | as.numeric(p1s[i,j])<0.05)
         grid.text(p1s[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
p2<-p[4]
Heatmap(p2,cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun2,show_row_names=F,                                                  
cell_fun = function(j, i, x, y, width, height, fill) {                          
         grid.text(sprintf("%.2f",p2[i, j]), x, y, gp = gpar(fontsize = 11))},
width = ncol(p2)*unit(20, "mm"), height = nrow(p2)*unit(10, "mm"), name="r^2")
h1s<-
Heatmap(as.matrix(logp1s),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun,row_names_side = "left",                                            
cell_fun = function(j, i, x, y, width, height, fill) {                          
         if( p1s[i,j] == "<2e-16" | as.numeric(p1s[i,j])<0.05)
         grid.text(p1s[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
h2<-                                                                            
Heatmap(p2,cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun2,show_row_names=F,                                                  
cell_fun = function(j, i, x, y, width, height, fill) {                          
         grid.text(sprintf("%.2f",p2[i, j]), x, y, gp = gpar(fontsize = 11))}, 
width = ncol(p2)*unit(20, "mm"), height = nrow(p2)*unit(10, "mm"), name="r^2",  
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "r^2") 
h1s+h2
decorate_heatmap_body("p-value", {                                              
grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 2))})            
decorate_heatmap_body("r^2", {                                                  
grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 2))})            
col_fun2 = colorRamp2(c(0, 1), c("white", "blue"))
h2<-                                                                            
Heatmap(p2,cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun2,show_row_names=F,                                                  
cell_fun = function(j, i, x, y, width, height, fill) {                          
         grid.text(sprintf("%.2f",p2[i, j]), x, y, gp = gpar(fontsize = 11))}, 
width = ncol(p2)*unit(20, "mm"), height = nrow(p2)*unit(10, "mm"), name="r^2",  
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "r^2") 
h1s+h2
decorate_heatmap_body("p-value", {                                              
grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 2))})            
decorate_heatmap_body("r^2", {                                                  
grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 2))})            
colnames(logp1s)[1]="SI"
Heatmap(as.matrix(logp1s),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun,row_names_side = "left",                                            
cell_fun = function(j, i, x, y, width, height, fill) {                          
         if( p1s[i,j] == "<2e-16" | as.numeric(p1s[i,j])<0.05)
         grid.text(p1s[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
colnames(logp1s)[2]="age"
colnames(p2)="adjusted"
h1s<-
Heatmap(as.matrix(logp1s),cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun,row_names_side = "left",                                            
cell_fun = function(j, i, x, y, width, height, fill) {                          
         if( p1s[i,j] == "<2e-16" | as.numeric(p1s[i,j])<0.05)
         grid.text(p1s[i, j], x, y, gp = gpar(fontsize = 11))},
width = ncol(p1)*unit(20, "mm"), height = nrow(p1)*unit(10, "mm"), name="p-value",
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "p-value")
h2<-                                                                            
Heatmap(p2,cluster_columns = F,cluster_rows=F, column_names_rot = 45,column_names_side = "top",
col=col_fun2,show_row_names=F,                                                  
cell_fun = function(j, i, x, y, width, height, fill) {                          
         grid.text(sprintf("%.2f",p2[i, j]), x, y, gp = gpar(fontsize = 11))}, 
width = ncol(p2)*unit(20, "mm"), height = nrow(p2)*unit(10, "mm"), name="r^2",  
column_title_gp = gpar(fontsize = 18, fontface = "bold"), column_title = "r^2") 
h1s+h2
decorate_heatmap_body("p-value", {                                              
grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 2))})            
decorate_heatmap_body("r^2", {                                                  
grid.rect(gp = gpar(fill = "transparent", col = "black", lwd = 2))})            

