#!/bin/bash
# Kyle Hernandez
# Center for Research Informatics
# University of Chicago
# License LGPLv3
# This bash script runs multiqc for the ChIP-seq dataset and outputs it into
# the workshop_extended/pipeline/data directory of the repository.
idir="/home/ubuntu/data/chipseq/fullset/fastqc"

# Get the pipeline directory 
repo=$(dirname $(dirname $0))
repo=$(dirname $(cd $repo && pwd))

odir="${repo}/data"

# run
multiqc="/home/ubuntu/anaconda2/envs/multiqc/bin/multiqc"
cd $idir && $multiqc -d --title "ChIP Seq Dataset" -f -o $odir . 
