# This program retrieves the gene set definitions according to different repositories
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
## Loading libraries defined by the user
############


############
## Variables defined by the user
############
path_code <- c("/media/rmejia/mountme88/code/Pathway_analysis")
path_code <- normalizePath( path_code )

source( paste0(path_code,"/libraries/","list_of_chr_to_df.R") )

# Obtaining the gene sets
rm(list = ls())
kegg.gs <- getGenesets(org = "hsa", db = "kegg")
go.gs <- getGenesets(org = "hsa", db = "go")
go.gs.BP.GOdb <- getGenesets(org = "hsa", db = "go", onto="BP", mode="GO.db")

go.gs_toy <- go.gs[1:10]
go.gs_df <- list_of_chr_to_df(go.gs)


go.gs.GOdb <- getGenesets(org = "hsa", db = "go", go.onto = "BP", go.mode = "GO.db")
?get.go.genesets


go.gs.GOdb <- getGenesets(org = "hsa", db = "go", onto = "BP", go.mode = "GO.db")
go.gs.GOdb <- getGenesets(org = "hsa", db = "go")

go.gs.GOdb <- getGenesets(org = "hsa", db = "go", onto = "BP", mode = "GO.db")
?getGenesets

# Alternatively:
# downloading from BioMart 
# this may take a few minutes ...
go.gs.biomart <- getGenesets(org = "hsa", db = "go", mode = "biomart")

# The same function can read tab separated pathways from a file, for example:
# hsa.gs <- getGenesets(gmt.file)


# More options to retrieve your gene sets https://rdrr.io/bioc/EnrichmentBrowser/man/getGenesets.html

# (7) writing gene sets to file
writeGMT(gs, gmt.file)
