#!/usr/bin/env Rscript
## plot_richness


###################################################
# This R script ...
#
# Ex: Rscript plot.R ...
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

alpha.file <- args[[1]] # take in some tsv/txt file from QIIME AlphaDiversityFormat
out.path <- args[[2]] # "/Users/amy/qiime2-workshop/" Creating an output path

errQuit <- function(mesg, status=1) {
  message("Error: ", mesg)
  q(status=status)
}

### VALIDATE ARGUMENTS ###

# Input directory is expected to contain .fastq.gz file(s)
# that have not yet been filtered and globally trimmed
# to the same length.
if(!file.exists(alpha.file)) {
  errQuit("Input file does not exist.")
} else {
    alpha_estimates_table <- read.table(file = alpha.file,
                                        header = TRUE,
                                        sep = '\t',
                                        row.names = NULL)
}

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

#Install ggplot2
if ("ggplot2" %in% installed.packages()[,"Package"]) {
    cat("You have ggplot2 installed!\n\n")
} else {
    cat("Error: Magrittr needs to be installed!\n\n")
}
library(ggplot2)


### PLOT DIVERSITY ###
cat("1) Plot diversity estimates\n")


plot_alpha <- function(x, trim_plot = FALSE, ...) {
    
    df <- x
    
    if (all(is.na(df$estimate))) {
        stop("There are no estimates in this alpha_estimates object!")
    }
    
    my_gg <- ggplot2::ggplot(df) +
    ggplot2::geom_point(ggplot2::aes_string(x = "sample_names", y = "estimate")) +
    ggplot2::ylab("estimate of richness") +
    ggplot2::xlab("") +
    #ggplot2::labs(title = title) +
    ggplot2::theme_bw() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
    
    if (!(all(is.na(df$lower)) || all(is.na(df$upper)))) {
        my_gg <- my_gg +
        ggplot2::geom_segment(ggplot2::aes_string(x = "sample_names", xend = "sample_names", y = "lower", yend = "upper"))
    }
    
    if (!trim_plot) {
        fiven <- stats::fivenum(df$upper, na.rm = TRUE)
        iqr <- diff(fiven[c(2, 4)])
        if (!is.na(iqr)) {
            out <- df$upper < (fiven[2L] - 1.5 * iqr) | df$upper > (fiven[4L] + 1.5 * iqr)
            ylower <- min(0, 0.95*min(df$upper[!out]), na.rm = TRUE)
            yupper <- 1.05*max(df$upper[!out], na.rm = TRUE)
            
            my_gg <- my_gg +
            ggplot2::coord_cartesian(ylim = c(ylower,yupper))
        }
    }
    
    my_gg
}


myplot <- plot_alpha(alpha_estimates_table)
ggplot2::ggsave(filename = paste0(out.path,"/breakaway_plot.png"), plot = myplot, width = 10, height = 10)

q(status=0)
