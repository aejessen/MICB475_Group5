# core microbiome analysis
# March 8, 2024

Biocmanager::install("microbiome")
install.packages("ggVennDiagram")

library(tidyverse)
library(phyloseq)
library(microbiome)
library(ggVennDiagram)

# using non-rarefied data for core microbiome analysis
load("ap_final.RData")
# convert to relative abundance
ap_RA <- transform_sample_counts(ap_final, fun=function(x) x/sum(x))
ap_anemic <- subset_samples(ap_RA, `anemia`=="anemic")
ap_stunted <- subset_samples(ap_RA, `stunting`=="Stunted")
ap_not_anemic <- subset_samples(ap_RA, `anemia`=="normal")
ap_not_stunted <- subset_samples(ap_RA, `stunting`=="Normal")

# setting prevalence
anemic_ASVs <- core_members(ap_anemic, detection=0.001, prevalence = 0.10)
stunted_ASVs <- core_members(ap_stunted, detection=0.001, prevalence = 0.10)
not_anemic_ASVs <- core_members(ap_not_anemic, detection=0.001, prevalence = 0.10)
not_stunted_ASVs <- core_members(ap_not_stunted, detection=0.001, prevalence = 0.10)

# identify taxonomic groups
tax_table(prune_taxa(anemic_ASVs,ap_final))
tax_table(prune_taxa(not_anemic_ASVs,ap_final))
tax_table(prune_taxa(stunted_ASVs,ap_final))
tax_table(prune_taxa(not_stunted_ASVs,ap_final))

# graph relative abundance
# please expand the plots window for better visualization
prune_taxa(anemic_ASVs,ap_RA) %>%
  plot_bar(fill="Genus") +
  facet_wrap(.~`anemia`, scales ="free")

prune_taxa(not_anemic_ASVs,ap_RA) %>%
  plot_bar(fill="Genus") +
  facet_wrap(.~`anemia`, scales ="free")

prune_taxa(stunted_ASVs,ap_RA) %>%
  plot_bar(fill="Genus") +
  facet_wrap(.~`stunting`, scales ="free")

prune_taxa(not_stunted_ASVs,ap_RA) %>%
  plot_bar(fill="Genus") +
  facet_wrap(.~`stunting`, scales ="free")

                                 
# venn diagram
                                 
core_list_0_20 <- list(Anemic = anemic_ASVs, Not_Anemic = not_anemic_ASVs, Stunted = stunted_ASVs, Not_Stunted = not_stunted_ASVs)

# draft venn with 0 detection and 0.2 prevalence
                                 
draft_venn_0_20 <- ggVennDiagram(x = core_list_0_20,
                                 category.names = c("Anemia", "Healthy", "Stunted", "Non-Stunted")) +
  scale_fill_gradient(low = "#F4FAFE", high = "#4981BF")

                                 
draft_venn_0_20

ggsave("venn_0_20_Apr11.png", draft_venn_0_20, height=14, width=10)
