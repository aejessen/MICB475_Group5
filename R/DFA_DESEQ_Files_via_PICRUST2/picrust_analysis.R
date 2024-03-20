##### Install packages #####
# Start by installing all necessary packages when asked if you want to install
# from source, please just type Yes in the terminal below

# If you don't have BiocManager, here is the code to install it
# A lot of you probably already have this so you can skip
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# Create a list of all the packages you need to install
pkgs <- c("ALDEx2", "SummarizedExperiment", "Biobase", "devtools", 
          "ComplexHeatmap", "BiocGenerics", "metagenomeSeq", 
          "Maaslin2", "edgeR", "lefser", "limma", "KEGGREST", "DESeq2")

# Use the above list to install all the packages using a for loop
for (pkg in pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE))
    BiocManager::install(pkg)
}
# when asked if you want to update all, some or none please type "n" for none

# After installing all of its above dependencies, install ggpicrust2
install.packages("ggpicrust2")

#### Load packages ####
# Load all necessary libraries
library(readr)
library(ggpicrust2)
library(tibble)
library(tidyverse)
library(ggprism)
library(patchwork)
library(DESeq2)
library(ggh4x)


#### Import files and preparing tables ####
#Importing the pathway PICrust2
abundance_file <- "pathway_abundance.tsv"
abundance_data <- read_delim(abundance_file, 
                             delim = "\t", 
                             col_names = TRUE, 
                             trim_ws = TRUE,
                             skip = 1)
abundance_data =  as.data.frame(abundance_data)
colnames(abundance_data)[1] <- "pathway"

#Import your metadata file, adjust filter to do the correct categories
# Only need to change the filter in this line in order to run the entire code! 
metadata <- read_delim("../anemia_metadata_updated.txt") |> 
      filter(disease_state %in% c("stunted_healthy",
                                  "non-stunted_anemic"))
colnames(metadata)[1] <- "sampleID"


#Example Looking at subject number
#If you have multiple variants, filter your metadata to include only 2 at a time!!!
# What combinations do we want to do? I'll start with:
#     non-stunted_healthy
#     stunted_healthy
#     non-stunted_anemic
#     stunted_anemic

# 1. Anemia column
# 2. Stunting column
# 3. 


#Remove NAs for your column of interest 
metadata = metadata[!is.na(metadata$disease_state),]

#Filtering the abundance table to only include samples that are in the filtered metadata
column_names = metadata$'sampleID'
column_names = append(column_names, "pathway")
abundance_data_filtered = abundance_data[, colnames(abundance_data) %in% column_names] #This step is the actual filtering

#Removing individuals with no data that caused a problem for pathways_daa()
abundance_data_filtered =  abundance_data_filtered[, colSums(abundance_data_filtered != 0) > 0]

#Ensuring the rownames for the abundance_data_filtered is empty. This is required for their functions to run.
rownames(abundance_data_filtered) = NULL

#verify samples in metadata match samples in abundance_data
abun_samples = rownames(t(abundance_data_filtered[,-1])) #Getting a list of the sample names in the newly filtered abundance data
# Remember to change the name!
metadata = metadata[metadata$`sampleID` %in% abun_samples,] #making sure the filtered metadata only includes these samples

#### DESEq ####
#Perform pathway DAA using DESEQ2 method
abundance_daa_results_df <- pathway_daa(abundance = abundance_data_filtered %>% 
                                              column_to_rownames("pathway"), 
                                        metadata = metadata, 
                                        group = "disease_state", 
                                        daa_method = "DESeq2")

# Annotate MetaCyc pathway so they are more descriptive
metacyc_daa_annotated_results_df <- pathway_annotation(pathway = "MetaCyc", 
                                                       daa_results_df = abundance_daa_results_df, 
                                                       ko_to_kegg = FALSE)

# Filter p-values to only significant ones
# Should we be doing this with the adjusted p-vals instead?
feature_with_p_0.05 <- abundance_daa_results_df |>
                        filter(p_values < 0.05)
feature_with_adj_p_0.05 <- abundance_daa_results_df |>
                        filter(p_adjust < 0.05)

#Changing the pathway column to description for the results 
feature_desc = inner_join(feature_with_adj_p_0.05,
                          metacyc_daa_annotated_results_df, 
                          by = "feature")
feature_desc$feature = feature_desc$description
feature_desc = feature_desc[,c(1:7)]
colnames(feature_desc) = colnames(feature_with_adj_p_0.05)

#Changing the pathway column to description for the abundance table
abundance = abundance_data_filtered %>% 
      filter(pathway %in% feature_with_adj_p_0.05$feature)
colnames(abundance)[1] = "feature"
abundance_desc = inner_join(abundance,metacyc_daa_annotated_results_df, 
                            by = "feature")
abundance_desc$feature = abundance_desc$description
#this line will change for each dataset. 34 represents the number of samples in the filtered abundance table
abundance_desc = abundance_desc[,-c((ncol(abundance_data_filtered) - 1):ncol(abundance_desc))] 

# Generate a heatmap
pathway_heatmap(abundance = abundance_desc %>% column_to_rownames("feature"), 
                metadata = metadata, 
                group = "disease_state")

# Generate pathway PCA plot
pathway_pca(abundance = abundance_data_filtered |>
                  column_to_rownames("pathway"), 
            metadata = metadata, 
            group = "disease_state")

# Generating a bar plot representing log2FC from the custom deseq2 function

# Go to the Deseq2 function script and update the metadata category of interest

# Lead the function in
source("DESeq2_function.R")

# Run the function on your own data
res =  DEseq2_function(abundance_data_filtered, metadata, "disease_state")
res$feature = rownames(res)
res_desc = inner_join(res,metacyc_daa_annotated_results_df, by = "feature")
res_desc = res_desc[, -c(8:13)]
#View(res_desc)

# Filter to only include significant pathways
#     pvalue or padj
sig_res = res_desc |>
  filter(padj < 0.05)
# You can also filter by Log2fold change

sig_res <- sig_res[order(sig_res$log2FoldChange),]
sig_res_plot <- ggplot(data = sig_res, aes(y = reorder(description, sort(as.numeric(log2FoldChange))), x= log2FoldChange, fill = pvalue))+
  geom_bar(stat = "identity")+ 
  theme_bw()+
  labs(x = "Log2FoldChange", 
       y = "Pathways")
sig_res_plot
