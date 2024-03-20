#This function takes two variables.
# 1-the filtered abundance table with pathways in the first column and no rownames
# 2-the filtered metadata

DEseq2_function = function(abundance_table,metadata,col_of_interest){
  
  
  DESeq2_metadata <- metadata
  DESeq2_abundance_mat <- abundance_table %>% column_to_rownames("pathway")
  
  
  DESeq2_colnames <- colnames(DESeq2_metadata)
# Update the subject part to your own metadata column of interest
  DESeq2_colnames[DESeq2_colnames == col_of_interest] <- "Group_group_nonsense"
  colnames(DESeq2_metadata) <- DESeq2_colnames
  DESeq2_metadata = as.data.frame(DESeq2_metadata)
  DESeq2_metadata[,"Group_group_nonsense"] <- as.factor(DESeq2_metadata[,"Group_group_nonsense"])
  
  # Generate combinations of groups for comparison
  DESeq2_combinations <- utils::combn(unique(DESeq2_metadata[, "Group_group_nonsense"]), 2)
  DESeq2_results <- list()
  
  # Loop through combinations and perform DESeq2 analysis
  message("Performing pairwise comparisons with DESeq2...")
  for (i in seq_len(ncol(DESeq2_combinations))) {
    j <- DESeq2_combinations[, i]
    
    # Subsetting the data for the current combination of groups
    DESeq2_sub_group <- DESeq2_metadata$Group_group_nonsense %in% j
    DESeq2_metadata_sub <- DESeq2_metadata[DESeq2_sub_group,]
    DESeq2_abundance_mat_sub <- DESeq2_abundance_mat[, DESeq2_sub_group]
    DESeq2_abundance_mat_sub <- round(DESeq2_abundance_mat_sub)
    
    # Creating DESeq2 object and performing analysis
    DESeq2_object <- DESeq2::DESeqDataSetFromMatrix(
      countData = DESeq2_abundance_mat_sub,
      colData = DESeq2_metadata_sub,
      design = ~ Group_group_nonsense
    )
    DESeq2_object <- BiocGenerics::estimateSizeFactors(DESeq2_object, type = "poscounts")
    DESeq2_object_finish <- DESeq2::DESeq(DESeq2_object)
    DESeq2_results[[i]] <- DESeq2::results(DESeq2_object_finish)
    results = as.data.frame(DESeq2_results)
  }
  
  return(results)
}
