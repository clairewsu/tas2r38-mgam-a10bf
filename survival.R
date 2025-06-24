args=commandArgs(trailingOnly=T)
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
library(MatchIt)

#read in data of all the ppl with diabetes including demented and drug stuff
matchdata=read.csv(args[1])

#ratio 1
match=matchit(A10BF~SEX+NACCNE4S+RACE+NACCAGEB+NACCNVST+EDUC+A10A+A10BA+A10BX+A10BH+A10BG+
A10BB+A10BJ+A10BK+NACCDAYS,exact=~SEX+NACCNE4S+A10A+A10BA+A10BG,data=matchdata,ratio=1,distance="glmnet")
matched=match.data(match)
matched$time=ifelse(matched$DEMENTED=="1",matched$NACCFDYS,matched$NACCDAYS)
fit=survfit2(Surv(time, DEMENTED) ~ A10BF, data = matched)
matchedplot1=ggsurvplot(fit,
           data = matchedtzddifferent,
           pval = TRUE,
           conf.int = TRUE,
           risk.table = TRUE,
           palette = c("#E7B800", "#2E9FDF"),
           ggtheme = theme(axis.title.x = element_text(size =30),
axis.title.y=element_text(size=30),
axis.text.x=element_text(size=20),
axis.text.y=element_text(size=20),legend.text=element_text(size=20),legend.title=element_text(size=20)),
risk.table.fontsize=10,pval.size=10,xlab="days from first visit",ylab="dementia probability")

#ratio 2
match=matchit(A10BF~SEX+NACCNE4S+RACE+NACCAGEB+NACCNVST+EDUC+A10A+A10BA+A10BX+A10BH+A10BG+
A10BB+A10BJ+A10BK+NACCDAYS,exact=~SEX+NACCNE4S+A10A+A10BA+A10BG,data=matchdata,ratio=2,distance="glmnet")
matched=match.data(match)
matched$time=ifelse(matched$DEMENTED=="1",matched$NACCFDYS,matched$NACCDAYS)
fit=survfit2(Surv(time, DEMENTED) ~ A10BF, data = matched)
matchedplot2=ggsurvplot(fit,
           data = matchedtzddifferent,
           pval = TRUE,
           conf.int = TRUE,
           risk.table = TRUE,
           palette = c("#E7B800", "#2E9FDF"),
           ggtheme = theme(axis.title.x = element_text(size =30),
axis.title.y=element_text(size=30),
axis.text.x=element_text(size=20),
axis.text.y=element_text(size=20),legend.text=element_text(size=20),legend.title=element_text(size=20)),
risk.table.fontsize=10,pval.size=10,xlab="days from first visit",ylab="dementia probability")

ggsave("survival.plot.1.png",matchedplot1,w=5,h=8)
ggsave("survival.plot.2.png",matchedplot1,w=5,h=8)
