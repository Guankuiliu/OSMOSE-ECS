rm(list=ls())
setwd("~/Prj/Workstudio/scenarios/Figs/fig02_biomass&yield")

library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(cowplot)

# dir.create("./fig02_saved")
Biocolor<-colorRampPalette(brewer.pal(8, "RdYlBu"))

bio<-read.csv("Changeresults.csv", header = T, sep = ",")
bio$species <- factor(bio$species,
                      levels = c("SAP", "JFS", "JA", "SP", "PCM", "BS", "SYC", "WC", "SC", "CM", "LH", "JSM"))
bio$target <- factor(bio$target, levels = c("all", "low", "middle", "high"))
bio$F <- factor(bio$F)
bio$Functional.group <- factor(bio$Functional.group,
                               levels = c("high trophic", "middle trophic", "low trophic"))

###############################################################################
###########     Biomass change relative to the baseline scenario    ###########
###############################################################################

B_all <-ggplot(bio[bio$target=="all",],aes(x=species,y=Biochange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 9.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "Relative Biomass Change",subtitle = "Fishing for all trophic")
ggsave("./fig02_saved/B_all.pdf", plot = B_all, width = 8, height = 6, units = "in", dpi = 300)


B_low <-ggplot(bio[bio$target=="low",],aes(x=species,y=Biochange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 4.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "",subtitle = "Fishing for low trophic")
ggsave("./fig02_saved/B_low.pdf", plot = B_low, width = 8, height = 6, units = "in", dpi = 300)

B_middle <-ggplot(bio[bio$target=="middle",],aes(x=species,y=Biochange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 9.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "",subtitle = "Fishing for middle trophic")
ggsave("./fig02_saved/B_middle.pdf", plot = B_middle, width = 8, height = 6, units = "in", dpi = 300)

B_high<-ggplot(bio[bio$target=="high",],aes(x=species,y=Biochange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 4.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "",subtitle = "Fishing for high trophic")
ggsave("./fig02_saved/B_high.pdf", plot = B_high, width = 8, height = 6, units = "in", dpi = 300)

Bio_relative <- plot_grid(B_all, B_low, B_middle, B_high, nrow=4)
ggsave("./fig02_saved/Bio_relative.pdf", plot = Bio_relative, width = 16, height = 18, units = "in", dpi = 300)

###############################################################################
############     Yield change relative to the baseline scenario    ############
###############################################################################

Y_all <-ggplot(bio[bio$target=="all",],aes(x=species,y=Yieldchange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 9.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "Relative Biomass Change",subtitle = "Fishing for all trophic")
ggsave("./fig02_saved/Y_all.pdf", plot = Y_all, width = 8, height = 6, units = "in", dpi = 300)

Y_low <-ggplot(bio[bio$target=="low",],aes(x=species,y=Yieldchange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 4.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "",subtitle = "Fishing for low trophic")
ggsave("./fig02_saved/Y_low.pdf", plot = Y_low, width = 8, height = 6, units = "in", dpi = 300)

Y_middle <-ggplot(bio[bio$target=="middle",],aes(x=species,y=Yieldchange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 9.5))+
  labs(x="Scenario",y = "Relative biomass change",title = "",subtitle = "Fishing for middle trophic")
ggsave("./fig02_saved/Y_middle.pdf", plot = Y_middle, width = 8, height = 6, units = "in", dpi = 300)

Y_high<-ggplot(bio[bio$target=="high",],aes(x=species,y=Yieldchange,fill=F))+
  geom_bar(stat='identity',position=position_dodge(0.9),color="black")+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_manual(values = Biocolor(19))+
  # coord_cartesian(ylim=c(-1, 4.5))+
  labs(x="Scenario",y = "Relative yield change",title = "",subtitle = "Fishing for high trophic")
ggsave("./fig02_saved/Y_high.pdf", plot = Y_high, width = 8, height = 6, units = "in", dpi = 300)

Yield_relative <- plot_grid(Y_all, Y_low, Y_middle, Y_high, nrow=4)
ggsave("./fig02_saved/Yield_relative.pdf", plot = Yield_relative, width = 16, height = 18, units = "in", dpi = 300)


###############################################################################
#######################     Biomass change absolute     #######################
###############################################################################

## Data aggregation
bgroup <- bio[c("Biomass.sim", "Yield.sim", "target", "F", "Functional.group")] %>%
  group_by(F, target, Functional.group) %>%
  summarize_at(c("Biomass.sim", "Yield.sim"), sum, na.rm = TRUE) 

bg_all<-ggplot(bgroup[bgroup$target=="all",],aes(x=F,y=Biomass.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set1",name="Functional group")+
  # coord_cartesian(ylim=c(0,8500))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Biomass(×1000 ton)",title="Biomass",subtitle = c("Fishing for all trophic"))
ggsave("./fig02_saved/bg_all.pdf", plot = bg_all, width = 8, height = 6, units = "in", dpi = 300)


bg_low<-ggplot(bgroup[bgroup$target=="low",],aes(x=F,y=Biomass.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set1",name="Functional group")+
  # coord_cartesian(ylim=c(0,8500))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Biomass(×1000 ton)",subtitle = "Fishing for low trophic")
ggsave("./fig02_saved/bg_low.pdf", plot = bg_low, width = 8, height = 6, units = "in", dpi = 300)

bg_middle<-ggplot(bgroup[bgroup$target=="middle",],aes(x=F,y=Biomass.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set1",name="Functional group")+
  # coord_cartesian(ylim=c(0,8500))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Biomass(×1000 ton)",subtitle = "Fishing for middle trophic")
ggsave("./fig02_saved/bg_middle.pdf", plot = bg_middle, width = 8, height = 6, units = "in", dpi = 300)

bg_high<-ggplot(bgroup[bgroup$target=="high",],aes(x=F,y=Biomass.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set1",name="Functional group")+
  # coord_cartesian(ylim=c(0,8500))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Biomass(×1000 ton)",subtitle = "Fishing for high trophic")
ggsave("./fig02_saved/bg_high.pdf", plot = bg_high, width = 8, height = 6, units = "in", dpi = 300)


yg_all<-ggplot(bgroup[bgroup$target=="all",],aes(x=F,y=Yield.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set2",name="Functional group")+
  # coord_cartesian(ylim=c(0,850))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Yield(×1000 ton)",title="Yield",subtitle = "Fishing for all trophic")
ggsave("./fig02_saved/yg_all.pdf", plot = yg_all, width = 8, height = 6, units = "in", dpi = 300)

yg_low<-ggplot(bgroup[bgroup$target=="low",],aes(x=F,y=Yield.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set2",name="Functional group")+
  # coord_cartesian(ylim=c(0,850))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Yield(×1000 ton)",subtitle = "Fishing for low trophic")
ggsave("./fig02_saved/yg_low.pdf", plot = yg_low, width = 8, height = 6, units = "in", dpi = 300)

yg_middle<-ggplot(bgroup[bgroup$target=="middle",],aes(x=F,y=Yield.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set2",name="Functional group")+
  # coord_cartesian(ylim=c(0,850))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Yield(×1000 ton)",subtitle = "Fishing for middle trophic")
ggsave("./fig02_saved/yg_middle.pdf", plot = yg_middle, width = 8, height = 6, units = "in", dpi = 300)

yg_high<-ggplot(bgroup[bgroup$target=="high",],aes(x=F,y=Yield.sim/1000,fill=Functional.group))+
  geom_bar(stat='identity',position="stack",colour="black",size=1)+
  theme_bw()+
  theme(plot.subtitle=element_text(colour="black",face = "bold.italic"),
        text=element_text(colour="black",face = "bold",family="serif",size=18),
        axis.text.y = element_text(colour="black",face = "bold.italic"),
        legend.title =  element_text(colour="black",face = "bold.italic"),
        axis.text.x = element_text(colour="black",vjust=0.5,size=15,face = "bold.italic"))+
  scale_fill_brewer(palette="Set2",name="Functional group")+
  # coord_cartesian(ylim=c(0,850))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.background = element_blank())+
  labs(x="F",y = "Yield(×1000 ton)",subtitle = "Fishing for high trophic")
ggsave("./fig02_saved/yg_high.pdf", plot = yg_high, width = 8, height = 6, units = "in", dpi = 300)

bio_yield_group <- plot_grid(bg_all,yg_all,bg_low,yg_low,bg_middle,yg_middle,bg_high,yg_high,nrow=4,labels=LETTERS[1:8])
ggsave("./fig02_saved/Bio_Yield_Func-group.pdf", plot = bio_yield_group, width = 16, height = 18, units = "in", dpi = 300)




