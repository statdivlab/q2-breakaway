# ----------------------------------------------------------------------------
# Copyright (c) 2016-2018, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------
import importlib

import qiime2.plugin
from qiime2.plugin import Properties, Choices, Str

from q2_types.sample_data import SampleData, AlphaDiversity
from q2_types.feature_data import FeatureData, Sequence
from q2_types.feature_table import FeatureTable, Frequency

import q2_breakaway

plugin = qiime2.plugin.Plugin(
    name='breakaway',
    version=q2_breakaway.__version__,
    website='http://github.com/adw96/breakaway/',
    package='q2_breakaway',
    description=('breakaway is the premier package for statistical analysis of microbial diversity. breakaway implements the latest and greatest estimates of richness, as well as the most commonly used estimates. The breakaway philosophy is to estimate diversity, to put error bars on diversity estimates, and to perform hypothesis tests for diversity that use those error bars.'),
    short_description='breakaway estimates microbial diversity, along with error bars',
    citations=qiime2.plugin.Citations.load('citations.bib', package='q2_breakaway')
)


plugin.methods.register_function(
    function=q2_breakaway.alpha,
    inputs={'table': FeatureTable[Frequency]},
    outputs=[('alpha_diversity', SampleData[AlphaDiversity % Properties(["StandardError", "LowerConfidence", "UpperConfidence", "SampleNames", "MethodName", "ModelType"])])],
    parameters={},
    input_descriptions={
        'table': ('The feature table containing the samples for which alpha '
                  'diversity should be computed.')
    },
    output_descriptions={
        'alpha_diversity': 'Vector containing per-sample alpha diversities.'
    },
    name='Richness, better',
    description='Amy\'s opinionated ideas about richness as a q2, '
                'plug-in.'
)

plugin.visualizers.register_function(
    function=q2_breakaway.plot,
    inputs={'alpha_diversity': SampleData[AlphaDiversity % Properties(["StandardError", "LowerConfidence", "UpperConfidence", "SampleNames", "MethodName", "ModelType"])]},
    parameters={},
    input_descriptions={
        'alpha_diversity': ('Vector containing per-sample breakaway generated alpha diversities.')
    },
    name='Richness plot, better',
    description='Making better plots'
)
