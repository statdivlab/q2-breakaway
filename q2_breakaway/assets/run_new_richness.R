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
#my.metric <- args[[2]] #  "richness"
out.file <- args[[2]] # "/Users/amy/qiime2-workshop/tmp.tsv"

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

#Check if Tidyverse is install
if ("tibble" %in% installed.packages()[,"Package"]) {
    cat("You have tibble installed!\n\n")
} else {
    cat("Error: Tibble needs to be installed!\n\n")
}
library(tibble)

#Magrittr install
if ("magrittr" %in% installed.packages()[,"Package"]) {
    cat("You have magrittr installed!\n\n")
} else {
    cat("Error: Magrittr needs to be installed!\n\n")
    }
library(magrittr)

#Devtools install check
if ("devtools" %in% installed.packages()[,"Package"]) {
    cat("Thank god! devtools is already available\n\n")
} else {
    cat("Error: Need to install devtools!! \n\n")
    }


#Phyloseq install check
if ("phyloseq" %in% installed.packages()[,"Package"]) {
    cat("Great! phyloseq is already available\n\n")
} else {
    cat("Error: Phyloseq needs to be installed!\n\n")
}

library(phyloseq)


cat("Attempting to make phyloseq object...\n\n")

ps <- phyloseq(otu_table(the_otu_table, taxa_are_rows = TRUE))

class(ps)


#Breakaway check install
if ("breakaway" %in% installed.packages()[,"Package"]) {
    cat("Breakaway is installed! We're ready to go now. \n\n")
} else {
    devtools::install_github("adw96/breakaway")
}

library(breakaway)
# suppressWarnings(library(breakaway))
cat("breakaway R package version:", as.character(packageVersion("breakaway")), "\n")


### ESTIMATE DIVERSITY ###
cat("1) Estimate diversity\n")
    df <- summary(breakaway::breakaway(ps))

df <- df[c("sample_names","estimate","error","lower","upper", "name","model")]

### PRINT DIVERSITY ###
cat("2) Write diversity estimates\n")

write.table(df, out.file, sep = "\t",
            row.names = F,
            quote = F)

q(status=0)
