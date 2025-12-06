library(lmerTest)
library(ggpubr)
library(scales)
library(tidyverse)

library(broom)
library(performance)
library(lme4)
library(parameters)

gtcdr=read.csv(file="../../gtcdr.csv")
colors=c("red","red","red","grey","red","red","red","red","red","red")

m=lmer(CDRSB~PTGENDER+PTEDUCAT+apoe4+pc1+pc2+pc3+pc4+pc5+age*(g1+g2+g3)+(1|RID),data=gtcdr)
std_params <- standardize_parameters(m)
df=as.data.frame(std_params)
df=df[-1,]
df=df[-c(4:8),]

df$Parameter=c("sex(female)","education","apoe4","age","g1","g2","g3","age*g1","age*g2","age*g3")
df$Parameter=factor(df$Parameter,levels=rev(c("sex(female)","education","apoe4","age","g1","g2","g3","age*g1","age*g2","age*g3")))

fixed_effects0=
ggplot(df, aes(x = Std_Coefficient, y = Parameter)) +
 geom_point(size = 3, color = colors) +
  geom_errorbarh(aes(xmin = CI_low, xmax = CI_high), height = 0.2) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey50") +
  scale_x_continuous(breaks = seq(-0.2, 0.5, by = 0.1)) +
theme_minimal(base_size = 14)

fixed_effects=
fixed_effects0+
annotate("text",
           x = mean(range(df$Std_Coefficient))-0.1,
            y = nrow(df) + 1,
            label = "Standardized Coefficient (β)")+
   coord_cartesian(clip = "off") + ylab("Predictor")

fixed_effects=
fixed_effects+
  theme(
    axis.title.x = element_blank(),   # remove bottom label
    axis.text.x = element_text(),
    axis.ticks.x = element_line(),
    plot.margin = margin(t = 30, r = 10, b = 10, l = 10)  # extra top space
  )

ggsave(file="CDRSUM.effects0.png",fixed_effects,w=4,h=5)

