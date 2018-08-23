# ----------------------------------------------------------------------------
# Copyright (c) 2016-2018, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------

from setuptools import setup, find_packages

import versioneer


setup(
    name="q2-breakaway",
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    url="https://qiime2.org",
    license="BSD-3-Clause",
    packages=find_packages(),
    author="Amy Willis",
    description="breakaway is the premier package for statistical analysis of microbial diversity. breakaway implements the latest and greatest estimates of richness, as well as the most commonly used estimates. Understanding the drivers of microbial diversity is an important frontier of microbial ecology, and investigating the diversity of samples from microbial ecosystems is a common step in any microbiome analysis.",
    scripts=['q2_breakaway/assets/run_new_richness.R',
             'q2_breakaway/assets/plot_richness.R'],
    package_data={
        'q2_breakaway': ['citations.bib']
    },
    ## where qiime learns about existance of a plugin
    entry_points={
        "qiime2.plugins":
        ["q2-breakaway=q2_breakaway.plugin_setup:plugin"]
    },
    zip_safe=False,
)
