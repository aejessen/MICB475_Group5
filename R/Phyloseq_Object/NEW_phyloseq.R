# phyloseq here

# install packages

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("phyloseq")


# install libraries to create phyloseq

library(phyloseq)
library(ape) # importing trees
library(tidyverse)
library(vegan)


# cleaning up meta

metafp <- "../anemia_metadata_updated.txt"
meta <- read_delim(metafp, delim="\t")

# cleaning up otu

otufp <- "../table_export/feature-table.txt"
otu <- read_delim(file = otufp, delim="\t", skip=1)

# cleaning up tax

taxfp <- "../table_export/taxonomy.tsv"
tax <- read_delim(taxfp, delim="\t")

# cleaning up phylotree

phylotreefp <- "../table_export/tree.nwk"
phylotree <- read.tree(phylotreefp)


# creating an OTU table

otu_mat <- as.matrix(otu[,-1])

# Make first column (#OTU ID) the rownames of the new matrix

rownames(otu_mat) <- otu$`#OTU ID`
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE)
class(OTU)


# formatting sample metadata

samp_df <- as.data.frame(meta[,-1])

# Make sampleids the rownames

rownames(samp_df)<- meta$'#SampleID'
SAMP <- sample_data(samp_df)
class(SAMP)


# formatting taxonomy

tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix() # Saving as a matrix
tax_mat <- tax_mat[,-1]

# Make sampleids the rownames

rownames(tax_mat) <- tax$`Feature ID`
TAX <- tax_table(tax_mat)
class(TAX)


# create phyloseq object

ap <- phyloseq(OTU, SAMP, TAX, phylotree)

# Remove non-bacterial sequences, if any

ap_filt <- subset_taxa(ap,  Domain == "d__Bacteria" & Class!="c__Chloroplast" & Family !="f__Mitochondria")

# Remove ASVs that have less than 5 counts total

ap_filt_nolow <- filter_taxa(ap_filt, function(x) sum(x)>5, prune = TRUE)
                             
# Remove samples with less than 100 reads
                             
ap_final <- prune_samples(sample_sums(ap_filt_nolow)>100, ap_filt_nolow)

                             
# rarefy samples

rarecurve(t(as.data.frame(otu_table(ap_final))), cex=0.1)
ap_rare <- rarefy_even_depth(ap_final, rngseed = 1, sample.size = 1000)
ap_rare_16888 <- rarefy_even_depth(ap_final, rngseed = 1, sample.size = 16888)

# save
save(ap_final, file="ap_final.RData")
save(ap_rare, file="ap_rare.RData")
save(ap_rare_16888, file="ap_rare_16888.RData")

