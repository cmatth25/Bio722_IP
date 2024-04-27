#visualize final project#####
rm(list=ls())

library(ggplot2)
library(tidyverse)
library(dplyr)
library(ggrepel)
library(ggsci)
library(corrplot)
library(Hmisc)
library(gridExtra)
library(grid)
library(ggsignif)
library(MASS)
library(DHARMa)
library(emmeans)


setwd("C:/Users/cmatt/Dropbox/Craig/Bio722/breport")
#setwd("/Users/craigmatthews/Dropbox/Craig/Bio722/breport")
getwd()

##Relative abundance%+#####

abund <- read.csv("relative_abundance.csv")
abund %>% mutate(ecosystem = as_factor(ecosystem))
abund %>% mutate(sample = as_factor(sample))

#pivot long, all percentages in one column
abund_piv <- pivot_longer(abund,cols = 2:29)

#create stacked bar
rel_abund <- ggplot(abund_piv) +
  geom_bar(aes(sample,value,fill=name), position = "stack", stat = "identity") +
  scale_fill_igv()+
  scale_y_continuous(expand = c(0,0))+
  facet_grid(~ ecosystem, scales = "free")+
  ylab("Relative Abundance (%)")+
  xlab("Sample")+
  labs(fill = "Phyla")

#format plot
rel_abund + theme_classic() + theme(axis.text.x = element_text(angle = 90), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 
p1 = rel_abund+ theme_classic() + theme(axis.text.x = element_text(angle = 90), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 



#save
png(filename="rel_abund.png", width = 2174, height = 1532, res = 300) 
p1
plot(p1)
dev.off()

##barplots of pooled total BGCs per ecosystem####

###phylum####

taxa <- read.csv("C:/Users/cmatt/Dropbox/Craig/Bio722/MG_AS_out/json_outs/BGC_taxa_count.csv")
#taxa <- read.csv("/Users/craigmatthews/Dropbox/Craig/Bio722/MG_AS_out/json_outs/BGC_taxa_count.csv")
list(taxa$phylum)

####taxa pooled percentage per within ecosystem#####

taxa_plot <- ggplot(taxa) +
  geom_bar(aes(phylum,Percentage,fill=ecosystem), stat = "identity", position = position_dodge2(preserve = "single")) +
  scale_fill_d3()+
  scale_y_continuous(limits = c(0,70), expand = c(0,0))+
  scale_x_discrete(limits=c("Acidobacteriota","Actinomycetota","Bacillota","Bacteroidota","Bdellovibrionota","Cyanobacteriota","Nitrososphaerota","Planctomycetota","Pseudomonadota","Thermodesulfobacteriota","Other"))+
  ylab("Percent total BGCs (%)")+
  xlab("")+
  labs(fill = "Ecosystem")

taxa_plot + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 
p2 = taxa_plot + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 

#save
png(filename="taxa_BGC_perc.png", width = 2174, height = 1532, res = 300) 
p2
plot(p2)
dev.off()

####taxa counts#####

taxa_count <- ggplot(taxa) +
  geom_bar(aes(phylum,Count,fill=ecosystem), stat = "identity", position = position_dodge2(preserve = "single")) +
  scale_fill_d3()+
  scale_y_continuous(expand = c(0,0))+
  ylab("Total BGCs")+
  xlab("Phyla")+
  labs(fill = "Ecosystem")

taxa_count + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 
p3 = taxa_count + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 

#save
png(filename="taxa_BGC_count.png", width = 2174, height = 1532, res = 300) 
p3
plot(p3)
dev.off()

####filtered taxa to >=4 #####
#filter counts >=4 for more abundance, potentially for comparison


filtered_taxa <- taxa %>% filter(phylum %in% c('Actinomycetota','Bacillota','Bacteroidota','Pseudomonadota'))
filtered_taxa

filter_taxa_plot <- ggplot(filtered_taxa) +
  geom_bar(aes(phylum,Percentage,fill=ecosystem), stat = "identity", position = position_dodge2(preserve = "single")) +
  scale_fill_d3()+
  scale_y_continuous(limits = c(0,60), expand = c(0,0))+
  ylab("Percent BGCs (%)")+
  xlab("Phyla")+
  labs(fill = "Ecosystem")

filter_taxa_plot + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 
p4 = filter_taxa_plot + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm")) 

#save
png(filename="filter_taxa_BGC_perc.png", width = 2174, height = 1532, res = 300) 
p4
plot(p4)
dev.off()

#for potential comparison of pooled data, seems inadvisable
filtered_contigency <- pivot_wider(filtered_taxa, id_cols = "ecosystem", names_from = "phylum",values_from = "Count")

contigency <- pivot_wider(taxa, id_cols = "ecosystem", names_from = "phylum",values_from = "Count")
contigency <- contigency[ , colSums(is.na(contigency)) == 0]



###BGC types####
eco_BGC <- read.csv("BGC_eco_count.csv")
eco_BGC %>% mutate(ecosystem = as_factor(ecosystem))

eco_BGC_prop <- read.csv("BGC_eco_prop.csv")
eco_BGC_prop %>% mutate(ecosystem = as_factor(ecosystem))

#pivot table longer to plot
BGC_piv <- pivot_longer(eco_BGC_prop,cols = 2:6)

BGC_piv$value <- BGC_piv$value*100

####BGC type percentages within ecosystem#####

BGC_type_plot <- ggplot(BGC_piv) +
  geom_bar(aes(name,value,fill=ecosystem), stat = "identity", position = position_dodge2(preserve = "single")) +
  scale_fill_d3()+
  scale_y_continuous(limits = c(0,36), expand = c(0,0))+
  scale_x_discrete(limits=c("NRPS","PKS","RiPP","terpene","other"))+
  ylab("Percent total BGCs (%)")+
  xlab("BGC category")+
  labs(fill = "Ecosystem")

BGC_type_plot + theme_classic() + theme(axis.text.x = element_text(), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm"))
p5 = BGC_type_plot + theme_classic() + theme(axis.text.x = element_text(), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm"))

#save
png(filename="filter_BGC_type_perc.png", width = 2174, height = 1532, res = 300) 
p5
plot(p5)
dev.off()

##Correlation of BGC counts, etc####

#load table, correlation data
corr <- read.csv("read_contig_BGC.csv")

table <- read.csv("read_contig_BGC_perc.csv")

####table#####
#prepare data for table 1 in report
table <- table[,c(1,8,2:7,9,10)]
table <- table[order(table$ecosystem),]

colnames(table) <- c("Sample", "Ecosystem" ,"Reads", "Read Length", "Total Contigs", "N50", "Filtered Contigs","BGC Count", "Filtered Contig Percent", "BGC Contig Percent")
png("SampleAssembly.png", height = 25*nrow(table), width = 100*ncol(table))
grid.table(table,rows = NULL)
dev.off()

###Correlation####

#coefficients
coeffs <- rcorr(as.matrix(corr[,2:7]), type="spearman")[[1]]
coeffs

#significance
pvalue <- rcorr(as.matrix(corr[,2:7]), type="spearman")[[3]]
pvalue

#column, row names
colnames(coeffs) <- c("reads", "read length", "total contigs", "N50", "filtered contigs","BGC Count")
rownames(coeffs) <- c("reads", "read length", "total contigs", "N50", "filtered contigs","BGC Count")

colnames(pvalue) <- c("reads", "read length", "total contigs", "N50", "filtered contigs","BGC Count")
rownames(pvalue) <- c("reads", "read length", "total contigs", "N50", "filtered contigs","BGC Count")

####plot####
#view
corrplot(coeffs, 
         method = "pie", 
         p.mat = pvalue, 
         sig.level = 0.05,
         insig = "blank",       
         type="upper",
         tl.srt=45,
         tl.col = "black")
#save
png(filename="corr_plot.png", width = 2000, height = 2000, res = 300) 
cplt <- corrplot(coeffs, 
              method = "pie", 
              p.mat = pvalue, 
              sig.level = 0.05,
              insig = "blank",       
              type="upper",
              tl.srt=45,
              tl.col = "black") 
dev.off()
#okay with error


#attempt at stats here######
#simple model ecosystem and BGC type
#negative binomial model

##BGC types####
#load data for BGC type stats
type_model <- read.csv("BGC_type_sample.csv")
type_model_piv <- pivot_longer(type_model,cols = 4:8)
type_model_piv[is.na(type_model_piv)] <- 0

fit <-  glm.nb(value ~ ecosystem*name, data = type_model_piv)
sim <- simulateResiduals(fittedModel = fit, n = 500)
plot(sim, asFactor = FALSE)
#sim QQ look like a decent fit

#compare ecosystem
emm <- emmeans(fit, specs= ~ ecosystem|name, type = "response") #response to compare within name (BGC type)
emm
summary(contrast(emm, adjust = "mvt"), infer = c(TRUE,TRUE)) #multivariate adj

#no significant difference between Marine and Terrestrial, will compare just to see but pairwise not meaningful. 

##taxa ####
#load data
taxa_model <- read.csv("taxa_sample_BGC.csv")
taxa_model_piv <- pivot_longer(taxa_model,cols = 4:20)
taxa_model_piv[is.na(taxa_model_piv)] <- 0

#fit nb model
fit_taxa <-  glm.nb(value ~ ecosystem*name, data = taxa_model_piv)
sim_taxa <- simulateResiduals(fittedModel = fit, n = 500)
plot(sim_taxa, asFactor = FALSE)
#simulated QQ plot looks okay

#compare BGC type, ecosystem, same idea
emm_taxa <- emmeans(fit_taxa, specs= ~ ecosystem|name, type = "response")
emm_taxa
contrast_taxa = summary(contrast(emm_taxa, adjust = "mvt"), infer = c(TRUE,TRUE))
contrast_sig = subset(contrast_taxa, p.value <= 0.05)
contrast_taxa

#few taxa significantly different
#plot significance with low abundance taxa grouped

taxa_toplot <- read.csv("Other_taxa_toplot.csv")
taxa_toplot_piv <- pivot_longer(taxa_toplot,cols = 4:14)
taxa_toplot_piv[is.na(taxa_toplot_piv)] <- 0

##boxplots####

#box plot taxa w/ significance

bp_taxa <- ggplot(taxa_toplot_piv, aes(x=name, y=value, fill = ecosystem)) + 
  geom_boxplot(outlier.shape = NA)+
  geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(1), dotsize = 0.175, alpha = 0.6)+
  scale_fill_d3()+
  scale_y_continuous(limits = c(0,75), expand = c(0,0))+
  geom_signif(annotation = "*",
              y_position = 30, xmin = 2.75, xmax = 3.25, tip_length = c(0,0)) +
  geom_signif(annotation = "**",
              y_position = 22, xmin = 3.75, xmax = 4.25, tip_length = c(0,0)) +
  geom_signif(annotation = "*",
              y_position = 17, xmin = 5.75, xmax = 6.25, tip_length = c(0,0)) +
  scale_x_discrete(limits=c("Acidobacteriota","Actinomycetota","Bacillota","Bacteroidota","Bdellovibrionota","Cyanobacteriota","Nitrososphaerota","Planctomycetota","Pseudomonadota","Thermodesulfobacteriota","Other"))+
  ylab("BGC Count")+
  xlab("Phylum")+
  labs(fill = "Ecosystem")

bp_taxa + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm"))
bp1 <- bp_taxa + theme_classic() + theme(axis.text.x = element_text(angle = 90, hjust=0.95,vjust=0.2), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm"))

#save
png(filename="box_BGC_taxa.png", width = 2174, height = 1532, res = 300) 
bp1
plot(bp1)
dev.off()

#plot BGC type box plot

bp_type <- ggplot(type_model_piv, aes(x=name, y=value, fill = ecosystem)) + 
  geom_boxplot(outlier.shape = NA)+
  geom_dotplot(binaxis='y', stackdir='center', position=position_dodge(1), dotsize = 0.4, alpha = 0.6)+
  scale_fill_d3()+
  ylab("BGC Count")+
  xlab("BGC category")+
  labs(fill = "Ecosystem")

bp_type + theme_classic() + theme(axis.text.x = element_text(), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm"))
bp2 <- bp_type + theme_classic() + theme(axis.text.x = element_text(), legend.title = element_text( size=8), legend.text=element_text(size=7), legend.key.size = unit(0.3, "cm"))
#save
png(filename="box_BGC_type.png", width = 2174, height = 1532, res = 300) 
bp2
plot(bp2)
dev.off()
