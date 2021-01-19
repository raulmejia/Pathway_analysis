# This program retrieves the gene set definitions according to KEGG in a tsv way and as a list of characters
##################
### how to use this program
##################
# Rscript /Script/path/Get_Updated_KEGG-GeneSets_through_EnrichmentBrowserPackage.R /Path/2the/repo/code/Pathway_analysis A_label_for_your_run /Results/path 

# Pending features: include the options # onto <- "BP" / CC / MF
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
path_code <- c("/media/rmejia/mountme88/code/Pathway_analysis")
path_code <- normalizePath( path_code )

Label_for_yor_results <- myargs[2]    
# Label_for_yor_results <- "Run_19_01_2020_"

Folder_to_save_results <- myargs[3]
Folder_to_save_results <- normalizePath( Folder_to_save_results )
Folder_to_save_results <- "/media/rmejia/mountme88/Projects/Phosoholipidosis/Pathway_Analysis"
dir.create(Folder_to_save_results,recursive = TRUE)

############
## Loading libraries defined by the user
############
source( paste0(path_code,"/libraries/","list_of_chr_to_df.R") )

############
# Body's program
############
go.gs.BP.biomart.Symbol <- getGenesets(org = "hsa", db = "go", onto="BP", mode="biomart",
                                       gene.id.type = "SYMBOL") # Obtaining GO gene sets (as a list of characters)
# If you want another gene.id you could choose several biomart options´for the ids' for example: ENTREZID 
    saving_path_rds <- paste0(Folder_to_save_results,"/",Label_for_yor_results ,"go.gs.BP.biomart.Symbol.rds")
    saveRDS(go.gs.BP.biomart.Symbol, saving_path_rds)

go.gs.BP.biomart.Symbol_df <- list_of_chr_to_df( go.gs.BP.biomart.Symbol )

    saving_path_rdsmatrix <- paste0(Folder_to_save_results,"/",Label_for_yor_results ,"go.gs.BP.biomart.Symbol.asmatrix.rds")
    saveRDS(go.gs.BP.biomart.Symbol_df, saving_path_rdsmatrix)

    saving_path_tsvmatrix <- paste0(Folder_to_save_results,"/",  Label_for_yor_results ,"go.gs.BP.biomart.Symbol.asmatrix.tsv")
    write.table( go.gs.BP.biomart.Symbol_df , saving_path_tsvmatrix, quote = FALSE, sep="\t", col.names = FALSE, row.names = TRUE )


# More options to retrieve your gene sets https://rdrr.io/bioc/EnrichmentBrowser/man/getGenesets.html
