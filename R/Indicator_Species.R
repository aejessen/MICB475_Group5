#load/install in the packages 
install.packages("indicspecies")
library(tidyverse)
library(phyloseq)
library(permute)
library(indicspecies)

#load in data
load("~/MICB475_Group5/R/NEW_phyloseq_core/updated_phyloseq/phyloseq/ap_rare.RData")

#### GENUS: Indicator Species/Taxa Analysis ####
# glom to Genus
mpt_genus <- tax_glom(ap_rare, "Genus", NArm = FALSE)
mpt_genus_RA <- transform_sample_counts(mpt_genus, fun=function(x) x/sum(x))
mpt_genus_RA

#ISA
isa_mpt_genus <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_genus_RA)$`disease_state`)
summary(isa_mpt_genus)
taxtable <- tax_table(ap_rare) %>% as.data.frame() %>% rownames_to_column(var="ASV")

ISA_genus_tbl <- isa_mpt_genus$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

#### SPECIES: Indicator Species/Taxa Analysis ####
# glom to Species
mpt_species <- tax_glom(ap_rare, "Species", NArm = FALSE)
mpt_species_RA <- transform_sample_counts(mpt_genus, fun=function(x) x/sum(x))
mpt_species_RA

#ISA
isa_mpt_species <- multipatt(t(otu_table(mpt_genus_RA)), cluster = sample_data(mpt_species_RA)$`disease_state`)
summary(isa_mpt_species)
taxtable <- tax_table(ap_rare) %>% as.data.frame() %>% rownames_to_column(var="ASV")

ISA_species_tbl <- isa_mpt_species$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(taxtable) %>%
  filter(p.value<0.05) %>% View()

write.table(ISA_species_tbl, file="~/MICB475_Group5/R/NEW_ISA_species_tbl.tsv")
write.table(ISA_genus_tbl, file="~/MICB475_Group5/R/NEW_ISA_genus_tbl.tsv")
