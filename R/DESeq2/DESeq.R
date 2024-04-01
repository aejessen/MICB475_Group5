# if you didn't install the DESeq2 package, run the following
BiocManager::install("DESeq2")

#!/usr/bin/env Rscript
library(tidyverse)
library(phyloseq)
library(DESeq2)



#### Load data ####
# Load in the NON-rarefied version!
load("new_phyloseq/phyloseq_coremicrobiome/ap_final.RData")
ap_normal <- subset_samples(ap_final, 
                            anemia == "normal")
ap_anemic <- subset_samples(ap_final, 
                            anemia == "anemic")
# anemia:   Levels: anemic  or normal
# stunting: Levels: Stunted or Normal 



#### DESeq ####

# Change between ap_anemic and ap_normal to compare the different anemia groups 
# regarding the stunting variable
mpt_deseq <- phyloseq_to_deseq2(ap_anemic, 
                                ~`stunting`)
#DESEQ_mpt <- DESeq(mpt_deseq)

## NOTE: If you get a zeros error, then you need to add '1' count to all reads
mpt_plus1 <- transform_sample_counts(ap_anemic, 
                                     function(x) x+1)
mpt_deseq <- phyloseq_to_deseq2(mpt_plus1, ~`stunting`)
DESEQ_mpt <- DESeq(mpt_deseq)
res <- results(DESEQ_mpt, 
               tidy=TRUE, 
               #this will ensure that No is your reference group by putting it last
               contrast = c("stunting",
                            "Stunted",
                            "Normal"))
View(res)

# Look at results 



## Volcano plot: effect size VS significance
ggplot(res) +
  geom_point(aes(x=log2FoldChange, 
                 y=-log10(padj)))

## Make variable to color by whether it is significant + large change
vol_plot <- res %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>2) |>
  ggplot() +
  geom_point(aes(x=log2FoldChange, 
                 y=-log10(padj), 
                 col=significant))

### Change the save name!
ggsave(filename="vol_plot_anemic_stunted_vs_not.png",
       vol_plot)

# To get table of results
sigASVs <- res |>
  filter(padj<0.01 & abs(log2FoldChange)>2) |>
  dplyr::rename(ASV=row)
View(sigASVs)

# Get only asv names
sigASVs_vec <- sigASVs |>
  pull(ASV)

# Prune phyloseq file
mpt_DESeq <- prune_taxa(sigASVs_vec,ap_final)
sigASVs <- tax_table(mpt_DESeq) |>
      as.data.frame() |>
      rownames_to_column(var="ASV") |>
      right_join(sigASVs) |>
      arrange(log2FoldChange) |>
      mutate(Genus = make.unique(Genus)) |>
      mutate(Genus = factor(Genus, 
                            levels=unique(Genus)))

sigBarPlot <- ggplot(sigASVs) +
  geom_bar(aes(x=Genus, 
               y=log2FoldChange), 
           stat="identity") +
  geom_errorbar(aes(x=Genus, 
                    ymin= log2FoldChange-lfcSE, 
                    ymax= log2FoldChange+lfcSE)) +
  theme(axis.text.x = element_text(angle= 90, 
                                   hjust= 1, 
                                   vjust= 0.5))
# Have to save this one manually since ggsave() formats it horribly
sigBarPlot
