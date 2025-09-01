args=commandArgs(trailing=T)
library(matchit)
library(knitr)
library(dplyr)
library(survival)
library(ggplot2)
library(tibble)
library(lubridate)
library(ggsurvfit)
library(gtsummary)
library(tidycmprsk)
library(survminer)

data=read.csv(args[1]) #all the people with t2d that has demo and drug data etc excluding demented ppl

match=matchit(A10BF~SEX+NACCNE4S+RACE+NACCAGEB+NACCNVST+EDUC+A10A+A10BA+A10BX+A10BH+A10BG+A10BB+A10BJ+A10BK+NACCDAYS,exact=~SEX+NACCNE4S+A10A+A10BA+A10BG,data=data,ratio=1,distance="glmnet")
matched=match.data(match)
matched$time=ifelse(matched$DEMENTED=="1",matched$NACCFDYS,matched$NACCDAYS)
fit=survfit2(Surv(time, DEMENTED) ~ A10BF, data = matched)
surv= ggsurvplot(
  fit,
  data = match,
  risk.table = TRUE,       # add risk table
  tables.height = 0.25,    # proportion of space for risk table
  tables.theme = theme_cleantable(),
  risk.table.y.text = T,
  palette = c("#E7B800", "#2E9FDF"),
  xlab="days from first visit")
png("survplot.png",w=6,h=6,res=600,units="in")
surv
dev.off()
