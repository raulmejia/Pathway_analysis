# This program retrieves the gene set definitions according to KEGG in a tsv way and as a list of characters
##################
### how to use this program
##################
Rscript /Script/path/Get_Updated_KEGG-GeneSets_through_EnrichmentBrowserPackage.R /Path/2the/repo/code/Pathway_analysis A_label_for_your_run /Results/path 


##################
## Installing / loading required libraries
##################
if (!require("BiocManager")) {
  install.packages("BiocManager", ask =FALSE)
  library("BiocManager")
}
if (!require("tidyverse")) {
  BiocManager::install("tidyverse", ask =FALSE)
  library("tidyverse")
}
if (!require("EnrichmentBrowser")) {
  BiocManager::install("EnrichmentBrowser", ask =FALSE)
  library("EnrichmentBrowser")
}

############
## Variables defined by the user
############
myargs <- commandArgs(trailingOnly = TRUE)

path_code <- myargs[1]
    path_code <- normalizePath( path_code )

Label_for_yor_results <- myargs[2]    
# Label_for_yor_results <- "Run_19_01_2020_"

Folder_to_save_results <- myargs[3]
    Folder_to_save_results <- normalizePath( Folder_to_save_results )
    dir.create(Folder_to_save_results,recursive = TRUE)

############
## Loading libraries defined by the user
############
source( paste0(path_code,"/libraries/","list_of_chr_to_df.R") )

############
# Body's program
############
kegg.gs.SYMBOL <- getGenesets(org = "hsa", db = "kegg", mode="biomart", gene.id.type = "SYMBOL") # Obtaining KEGG gene sets
# If you want another gene.id you could choose several biomart options´for the ids' for example: ENTREZID 
    saving_path_rds <- paste0(Folder_to_save_results,"/",Label_for_yor_results ,"kegg.gs.SYMBOL.rds")
    saveRDS(kegg.gs.SYMBOL, saving_path_rds)
   
kegg.gs.SYMBOL_df <- list_of_chr_to_df( kegg.gs.SYMBOL )
    saving_path_tsvmatrix <- paste0(Folder_to_save_results,"/",  Label_for_yor_results ,"kegg.gs.SYMBOL_df.tsv")
write.table(kegg.gs.SYMBOL_df,saving_path_tsvmatrix, quote = FALSE, sep="\t", col.names = FALSE, row.names = TRUE )

# More options to retrieve your gene sets https://rdrr.io/bioc/EnrichmentBrowser/man/getGenesets.html
