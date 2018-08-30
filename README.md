# `breakaway` QIIME2 plugin

[![Build Status](https://travis-ci.org/qiime2/q2-breakaway.svg?branch=master)](https://travis-ci.org/qiime2/q2-breakaway)
[![Coverage Status](https://coveralls.io/repos/github/qiime2/q2-breakaway/badge.svg?branch=master)](https://coveralls.io/github/qiime2/q2-breakaway?branch=master)

This repository contains the `breakaway` QIIME 2 plugin. `breakaway` is in active development and is available in `R` (https://github.com/adw96/breakaway) or as a QIIME2 plugin (q2-breakaway).

`breakaway` is based in `R` and requires installation of dependencies `phyloseq`, `devtools`, `ggplot2`,`magrittr`, `tibble`, `dplyr`,`withr`,`testthat`, and `praise` into your `conda` environment before installing `breakaway`. Please refer to the following instructions on how to install `breakaway` and its dependencies.


### Activate your QIIME Environment

- Here we activate our example version of QIIME, `qiime2-2018.8`. If you're not sure what your current version of QIIME is you can run `conda env list` in the command line to see a list of installed QIIME environments. Note: q2-breakaway is compatible only with version `qiime2-2018.8` and on.

```
source activate qiime2-2018.8
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
This is a Community Tutorial for q2-breakaway within the qiime2-2018.8 release.

`breakaway` is the premier package for statistical analysis of microbial
diversity. `breakaway` implements the latest and greatest estimates of
richness, as well as the most commonly used estimates. The `breakaway` philosophy is to estimate diversity, to put error bars on diversity estimates, and to perform hypothesis tests for diversity that use those error bars.

### Citing `breakaway`

The `R` package `breakaway` implements a number of different richness
estimates. Please cite the following if you use them:

  - `breakaway()`: Willis and Bunge (2015). Estimating diversity via frequency ratios. Biometrics.

### How to use q2-breakaway
- For this tutorial we will be using data from the "Moving Pictures" data. q2-breakaway requires input of a FeatureTable of frequency counts. We recommend using a FeatureTable that has been generated from `deblur`/`vsearch` or `dada2` in `R` with pool = TRUE to make sure that singletons have not been completely filtered out.

<a href="https://github.com/statdivlab/q2-breakaway/blob/master/data/table-deblur.qza?raw=true" download>table-deblur.qza</a>

```
qiime breakaway alpha \
--i-table table-deblur.qza \
--o-alpha-diversity richness-better.qza
```

You can export the results out of QIIME2 to see the richness estimates, confidence intervals, and model used by ```breakaway```.
```
qiime tools export \
richness-better.qza \
--output-dir richness
```

<a href="https://github.com/statdivlab/q2-breakaway/raw/master/data/alpha-diversity-deblur.tsv" download>alpha-diversity.tsv</a>

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

<center><img src = "https://github.com/paulinetrinh/q2-breakaway/blob/master/data/breakaway_plot.png?raw=true"></center>

And now there are error bars around our estimates! Note that some error bars are smaller than others. This is because those samples had few rare taxa, and so low uncertainty in estimating the number of missing taxa.

## Future Functionality (things to look forward to!)
- `kemp()`: Willis, A. & Bunge, J. (2015). Estimating diversity via frequency ratios. Biometrics.
- `betta()`: Willis, A., Bunge, J., & Whitman, T. (2017). Improved detection of changes in species richness in high diversity microbial communities. JRSS-C.
- `breakaway_nof1()`: Willis, A. (2016+). Species richness estimation with high diversity but spurious singletons. arXiv.
- `objective_bayes_*()`: Barger, K. & Bunge, J. (2010). Objective
    Bayesian estimation for the number of species. Bayesian Analysis.
