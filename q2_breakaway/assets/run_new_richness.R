#!/usr/bin/env Rscript

###################################################
# This R script ...
#
# Ex: Rscript run_new_richness.R ...
####################################################

####################################################
#             DESCRIPTION OF ARGUMENTS             #
####################################################
# NOTE: ALL ARGUMENTS ARE POSITIONAL!
#
### FILE SYSTEM ARGUMENTS ###
#
# 1) File path to input csv file. 
#    Ex: path/to/input_file.csv
#

cat(R.version$version.string, "\n")
args <- commandArgs(TRUE)

otu.file <- args[[1]] # "/Users/amy/qiime2-workshop/test_otus.csv"
my.metric <- args[[2]] #  "richness"
out.file <- args[[3]] # "/Users/amy/qiime2-workshop/tmp.tsv"

# otu.file <- "/Users/amy/qiime2-workshop/test_otus.csv"
# my.metric <- "shannon"

errQuit <- function(mesg, status=1) {
  message("Error: ", mesg)
  q(status=status)
}

### VALIDATE ARGUMENTS ###

# Input directory is expected to contain .fastq.gz file(s)
# that have not yet been filtered and globally trimmed
# to the same length.
if(!file.exists(otu.file)) {
  errQuit("Input file does not exist.")
} else {
  # QIIME has OTUs as rows
  the_otu_table <- read.table(file = otu.file,
                          skip = 0, 
                          header = F,
                          #col.names = T
                          row.names = NULL
  )[, -1]
  colnames(the_otu_table) <- colnames(read.csv(otu.file, nrows=1, skip=1, sep = "\t"))[-1]
  
  
  # the_otu_table <- t(the_otu_table)
  # need check to figure out if samples are rows or columns
}

print(head(the_otu_table))

### LOAD LIBRARIES ###

#TODO: do loop for packages

cat(installed.packages()[,"Package"])

#Tidyverse install
if ("tibble" %in% installed.packages()[,"Package"]) {
    cat("You have tibble installed!\n\n")
} else {
    devtools::install_github("tidyverse/tibble")
}
cat("Whoo! You have tibble now!\n\n")
library(tibble)

#Magrittr install
if ("magrittr" %in% installed.packages()[,"Package"]) {
    cat("You have magrittr installed!\n\n")
} else {
    cat("Embarking on the journey that is installing magrittr...\n\n")
    try1 <- try(install.packages("magrittr"), silent = T)
    if (class(try1) == "try-error") {
        #cat("Didn't work the first time.")
        #try1 <- try(install.packages("tidyverse", repos='http://cran.us.r-project.org'), silent = T)
        errQuit("Could not install tidyverse.")
    }
}
cat("Whoo! You have magrittr now!\n\n")
library(magrittr)

#Devtools install (Will be installed in the README into the conda environment)
if ("devtools" %in% installed.packages()[,"Package"]) {
    cat("Thank god! devtools is already available\n\n")
} else {
    cat("Embarking on the journey that is installing devtools...\n\n")
    try1 <- try(install.packages("devtools"), silent = T)
    if (class(try1) == "try-error") {
        #cat("Didn't work the first time.")
        #try1 <- try(install.packages("devtools", repos='http://cran.us.r-project.org'), silent = T)
        errQuit("Could not install devtools.")
    }
}
cat("Hooray! You have devtools!\n\n")

#Phyloseq doesn't need fto be installed here. Will be installed in conda environment in the README
if ("phyloseq" %in% installed.packages()[,"Package"]) {
    cat("Thank god! phyloseq is already available\n\n")
} else {
    source('http://bioconductor.org/biocLite.R')
    biocLite('phyloseq', dependencies=TRUE)
}

library(phyloseq)

cat("Hooray! You have phyloseq!\n\n")


cat("Attempting to make phyloseq object...\n\n")

ps <- phyloseq(otu_table(the_otu_table, taxa_are_rows = TRUE))

class(ps)

cat("Embarking on the journey that is installing breakaway...\n\n")

devtools::install_github("paulinetrinh/breakaway")
library(breakaway)
# suppressWarnings(library(breakaway))
cat("breakaway R package version:", as.character(packageVersion("breakaway")), "\n")


### ESTIMATE DIVERSITY ###
cat("1) Estimate diversity\n")
if (my.metric == "chao_bunge"){
    df <- summary(breakaway::chao_bunge(ps))
}
if (my.metric == "richness"){
    df <- summary(breakaway::breakaway(ps))
}

### PRINT DIVERSITY ###
cat("2) Write diversity estimates\n")

write.table(df, out.file, sep = "\t",
            row.names = F,
            quote = F)

q(status=0)
