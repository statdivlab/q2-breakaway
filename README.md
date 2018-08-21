# breakaway QIIME 2 plugin

[![Build Status](https://travis-ci.org/qiime2/q2-breakaway.svg?branch=master)](https://travis-ci.org/qiime2/q2-breakaway)
[![Coverage Status](https://coveralls.io/repos/github/qiime2/q2-breakaway/badge.svg?branch=master)](https://coveralls.io/github/qiime2/q2-breakaway?branch=master)

This repository contains the `breakaway` QIIME 2 plugin. `Breakaway` is in active development and is available in `R` (https://github.com/adw96/breakaway) or as a QIIME2 plugin (q2-breakaway).

To learn how to use `breakaway` in QIIME2, see https://qiime2.org.

`Breakaway` based in `R` and requires installation of `phyloseq` and `devtools` into your `conda` environment before installing `breakaway`. Please refer to the following instructions on how to set up `phyloseq` and `devtools` in your environment.

## Setting up your conda environment:
***
### Install phyloseq <br>
```conda install -c bioconda -c conda-forge bioconductor-phyloseq```


### Install devtools <br>
```conda install -c r r-devtools```

<br>
## QIIME user installation instructions:
***
### Step 1: Activate QIIME Environment <br>
```source activate qiime2-2018.6```

### Step 2: Install breakaway's plug-in <br>
```pip install git+https://github.com/statdivlab/q2-breakaway.git```

### Step 3: Check that breakaway is installed <br>
```qiime breakaway --help```
