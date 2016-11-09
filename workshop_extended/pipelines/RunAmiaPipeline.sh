#!/bin/bash
# This script simply runs the BDS pipeline for the AMIA data.
# This is only a small subset of the data so that it can run quickly.
# Kyle Hernandez
# Center for Research Informatics
# University of Chicago
# License LGPLv3

echo "---------------------------------------------------------------------"
echo "2016 AMIA Pre-symposium Workshop"
echo "Center for Research Informatics, University of Chicago"
echo "Kyle Hernandez, Ph.D."
echo "LGPLv3"
echo ""
echo "---------------------------------------------------------------------"
echo "---------------------------------------------------------------------"
echo "This script runs the ChIP-seq pipeline using BigDataScript and a small"
echo "subset of the data."
echo ""

# Get the pipeline directory 
repo=$(dirname $0)
repo=$(cd $repo && pwd)

# Build the config files
${repo}/utils/build_config_files.sh $repo

# make output directory if needed
odir="${repo}/data/sample_run"
if [ -d $odir ]; then rm -rf $odir; fi 
mkdir -p $odir 
echo "Top-level output directory of pipeline run: $odir"

## Run/Log dir
runDir="${odir}/run"
logDir="${odir}/logs"
echo "Analysis files output directory: $runDir"
echo "Log files output directory: $logDir"

## run 
script="${repo}/AMIA-ChIP-Seq-Pipeline.bds"
echo "Running the pipeline..."
echo `date`

cd $odir && export PATH=/home/ubuntu/.bds:$PATH && /usr/bin/time -v -o 2016-AMIA-ChIPSeq-Run.time \
bds $script -configFile ${repo}/config/chipseq.cfg \
-contrastFiles ${repo}/config/contrast.Ab1.input.cfg \
${repo}/config/contrast.Ab1.IgG.cfg \
-runDir $runDir -logDir $logDir > 2016-AMIA-ChIPSeq-Run.logs 2>&1

echo "Finished running..."
echo `date`
