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
kegg.gs <- getGenesets(org = "hsa", db = "kegg")
go.gs.BP.GOdb <- getGenesets(org = "hsa", db = "go", onto="BP", mode="GO.db")
go.gs.BP.biomart <- getGenesets(org = "hsa", db = "go", onto="BP", mode="biomart")

go.gs.BP.biomart <- getGenesets(org = "hsa", db = "go", onto="BP", mode="biomart",
                                gene.id.type = "SYMBOL")
go.gs.CC.biomart <- getGenesets(org = "hsa", db = "go", onto="CC", mode="biomart",
                                gene.id.type = "SYMBOL")

positive_grepl_BP <- lapply(go.gs.BP.biomart , function(x){any(grepl("ABCA4",as.character(x))) })
go.gs.BP.biomart_ABCA4 <- go.gs.BP.biomart[ unlist(positive_grepl_BP) ]

positive_grepl_CC <- lapply(go.gs.CC.biomart , function(x){any(grepl("ABCA4",as.character(x))) })
go.gs.CC.biomart[ unlist(positive_grepl_CC) ]


go.gs_toy <- go.gs[1:10]
go.gs_df <- list_of_chr_to_df(go.gs)
kegg.gs_df <- list_of_chr_to_df( kegg.gs ) 
go.gs.BP.GOdb_df <- list_of_chr_to_df( go.gs.BP.GOdb )
go.gs.BP.GOdb.Symbol.ABCA4_df <- list_of_chr_to_df( go.gs.BP.biomart_ABCA4 )





# The same function can read tab separated pathways from a file, for example:
# hsa.gs <- getGenesets(gmt.file)


# More options to retrieve your gene sets https://rdrr.io/bioc/EnrichmentBrowser/man/getGenesets.html

# (7) writing gene sets to file
# writeGMT(gs, gmt.file)
