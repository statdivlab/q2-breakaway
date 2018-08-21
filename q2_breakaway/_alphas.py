# ----------------------------------------------------------------------------
# Copyright (c) 2016-2018, QIIME 2 development team.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file LICENSE, distributed with this software.
# ----------------------------------------------------------------------------

import os
import tempfile
import hashlib
import subprocess
import pkg_resources

import biom
import skbio
import qiime2.util
import pandas as pd
import q2templates

from q2_types.sample_data import AlphaDiversityFormat
from q2_types.feature_data import DNAIterator

TEMPLATES = pkg_resources.resource_filename('q2_breakaway', 'assets')

def run_commands(cmds, verbose=True):
    if verbose:
        print("Running external command line application(s). This may print "
              "messages to stdout and/or stderr.")
        print("The command(s) being run are below. These commands cannot "
              "be manually re-run as they will depend on temporary files that "
              "no longer exist.")
    for cmd in cmds:
        if verbose:
            print("\nCommand:", end=' ')
            print(" ".join(cmd), end='\n\n')
        subprocess.run(cmd, check=True)

def alpha(table: biom.Table,
                metric: str) -> AlphaDiversityFormat:
    if table.is_empty():
        raise ValueError("The provided table object is empty")

    output = AlphaDiversityFormat()
    ## run the R script on the file
    with tempfile.TemporaryDirectory() as temp_dir_name:

        ## write the biom table to file
        input_name = os.path.join(temp_dir_name, 'table.tsv')
        with open(input_name, 'w') as fh:
            fh.write(table.to_tsv())


        cmd = ['run_new_richness.R', input_name, str(metric), str(output)]
        run_commands([cmd])
    return output


def plot(output_dir: str, alpha_diversity: AlphaDiversityFormat) -> None:
        
        cmd = ['plot_richness.R', str(alpha_diversity), str(output_dir)]
        run_commands([cmd])
        plot_breakaway = os.path.join(output_dir,'plot.png')
        index = os.path.join(output_dir, 'index.html')
        
        with open(index, 'w') as fh:
            fh.write('<!DOCTYPE html><head></head><body><img src="breakaway_plot.png" style="max-width: 100vw;max-height: 100vh;object-fit: contain" /></body></html>')
        






