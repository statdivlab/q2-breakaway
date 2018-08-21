# `breakaway` QIIME 2 plugin

[![Build Status](https://travis-ci.org/qiime2/q2-breakaway.svg?branch=master)](https://travis-ci.org/qiime2/q2-breakaway)
[![Coverage Status](https://coveralls.io/repos/github/qiime2/q2-breakaway/badge.svg?branch=master)](https://coveralls.io/github/qiime2/q2-breakaway?branch=master)

This repository contains the `breakaway` QIIME 2 plugin. `Breakaway` is in active development and is available in `R` (https://github.com/adw96/breakaway) or as a QIIME2 plugin (q2-breakaway).

To learn how to use `breakaway` in QIIME2, see https://qiime2.org.

`Breakaway` is based in `R` and requires installation of `phyloseq` and `devtools` into your `conda` environment before installing `breakaway`. Please refer to the following instructions on how to set up `phyloseq` and `devtools` in your environment.

## Setting up your conda environment:

### Activate your QIIME Environment
- Here we activate our example version of QIIME, `qiime2-2018.6`. If you're not sure what your current version of QIIME is you can run `conda env list` in the command line to see a list of installed QIIME environments.

```source activate qiime2-2018.6```

### Install `phyloseq`
(Expected installation time ~2 minutes)

```conda install -c bioconda -c conda-forge bioconductor-phyloseq```

- Note: When installing select `y` to proceed with installation when prompted.


### Install `devtools` <br>
(Expected installation time ~2 minutes)

```conda install -c r r-devtools```
- Note: When installing select `y` to proceed with installation when prompted.


### Install `breakaway` <br>
```pip install git+https://github.com/paulinetrinh/q2-breakaway.git```

### Check that `breakaway` is installed <br>
```qiime breakaway --help```
