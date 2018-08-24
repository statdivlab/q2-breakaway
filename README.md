# `breakaway` QIIME2 plugin

[![Build Status](https://travis-ci.org/qiime2/q2-breakaway.svg?branch=master)](https://travis-ci.org/qiime2/q2-breakaway)
[![Coverage Status](https://coveralls.io/repos/github/qiime2/q2-breakaway/badge.svg?branch=master)](https://coveralls.io/github/qiime2/q2-breakaway?branch=master)

This repository contains the `breakaway` QIIME 2 plugin. `Breakaway` is in active development and is available in `R` (https://github.com/adw96/breakaway) or as a QIIME2 plugin (q2-breakaway).

To learn how to use `breakaway` in QIIME2, see https://qiime2.org.

`Breakaway` is based in `R` and requires installation of dependencies `phyloseq`, `devtools`, `ggplot2`,`magrittr`, `tibble`, `dplyr`,`withr`,`testthat`, and `praise` into your `conda` environment before installing `breakaway`. Please refer to the following instructions on how to install `breakaway` and its dependencies.


### Activate your QIIME Environment

- Here we activate our example version of QIIME, `qiime2-2018.6`. If you're not sure what your current version of QIIME is you can run `conda env list` in the command line to see a list of installed QIIME environments.

```
source activate qiime2-2018.6
```

### Install `breakaway` dependencies

(Expected installation time ~3-5 minutes)

```
conda install -c bioconda -c conda-forge bioconductor-phyloseq r-devtools r-tibble r-magrittr r-dplyr r-withr r-testthat r-praise unzip
```

- Note: When installing select `y` to proceed with installation when prompted.


### Install  `breakaway`  and `q2-breakaway`

```
pip install git+https://github.com/statdivlab/q2-breakaway.git
qiime dev refresh-cache
```


### Check that `breakaway` is installed <br>

```
qiime breakaway --help
```


# QIIME2 Tutorial: Using q2-breakaway
This is a Community Tutorial for q2-breakaway within the qiime2-2018.6 release.

`breakaway` is the premier package for statistical analysis of microbial
diversity. `breakaway` implements the latest and greatest estimates of
richness, as well as the most commonly used estimates. Understanding the
drivers of microbial diversity is an important frontier of microbial
ecology, and investigating the diversity of samples from microbial
ecosystems is a common step in any microbiome analysis.

### Citing breakaway

The `R` package `breakaway` implements a number of different richness
estimates. Please cite the following if you use them:

  - `breakaway()`: Willis, A. & Bunge, J. (2015).
    Estimating diversity via frequency ratios. Biometrics.

### How to use q2-breakaway
- For this tutorial we will be using data from the "Moving Pictures" data. q2-breakaway requires input of a FeatureTable of frequency counts. We recommend using a FeatureTable that has been generated from `deblur`/`vsearch` or `dada2` in `R` with pool = TRUE to make sure that singletons have not been completely filtered out. 

<a href="https://raw.githubusercontent.com/paulinetrinh/data/master/table-deblur.qza" download>table-deblur.qza</a>

```
qiime breakaway alpha \
--i-table table-deblur.qza \
--p-metric richness \
--o-alpha-diversity richness-better.qza
```

You can export the results out of QIIME2 to see the richness estimates, confidence intervals, and model used by ```breakaway```.
```
qiime tools export \
richness-better.qza \
--output-dir richness
```

<a href="https://raw.githubusercontent.com/paulinetrinh/data/master/alpha-diversity-deblur.tsv" download>alpha-diversity.tsv</a>

We see that Kemp, Poisson, and Negative Binomial models were used to generate our confidence intervals! Let's visualize our estimates and their error bars.

```
qiime breakaway plot \
--i-alpha-diversity richness-better.qza \
--o-visualization richness-better-plot
```

To view...
```
qiime tools view richness-better-plot.qzv
```

And now there are error bars around our estimates! 
