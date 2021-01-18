# This program retrieves the gene set definitions according to different repositories

if (!require("BiocManager")) {
  install.packages("BiocManager", ask =FALSE)
  library("BiocManager")
}

BiocManager::install("tidyverse", ask =FALSE)
if (!require("EnrichmentBrowser")) {
  BiocManager::install("EnrichmentBrowser", ask =FALSE)
  library("EnrichmentBrowser")
}


# Obtaining the gene sets
rm(list = ls())
kegg.gs <- getGenesets(org = "hsa", db = "kegg")
go.gs <- getGenesets(org = "hsa", db = "go")
go.gs.BP.GOdb <- getGenesets(org = "hsa", db = "go", onto="BP", mode="GO.db")

str(go.gs.BP.GOdb)
length(go.gs.BP.GOdb)
str(go.gs)

str(kegg.gs)
length(kegg.gs)

go.gs.GOdb <- getGenesets(org = "hsa", db = "go", go.onto = "BP", go.mode = "GO.db")
?get.go.genesets

BiocManager::install(update=TRUE)
BiocManager::version()

sessionInfo()
BiocManager::valid()
?BiocManager
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
