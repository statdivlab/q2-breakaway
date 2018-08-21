# breakaway QIIME 2 plugin

[![Build Status](https://travis-ci.org/qiime2/q2-breakaway.svg?branch=master)](https://travis-ci.org/qiime2/q2-breakaway)
[![Coverage Status](https://coveralls.io/repos/github/qiime2/q2-breakaway/badge.svg?branch=master)](https://coveralls.io/github/qiime2/q2-breakaway?branch=master)

This package contains the breakaway QIIME 2 plugin. To learn how to use this, see https://qiime2.org.

Install phyloseq 
```conda install -c bioconda -c conda-forge bioconductor-phyloseq```

jsonlite
```conda install -c r r-jsonlite```

Install devtools
```conda install -c r r-devtools``` 

QIIME user installation instructions: 
Step 1: Activate QIIME Environment 
```source activate qiime2-2018.6``` 

Step 2: Install breakaway's plug-in 
```pip install git+https://github.com/statdivlab/q2-breakaway.git```

Step 3: Check that breakaway is installed 
```qiime breakaway --help``` 
