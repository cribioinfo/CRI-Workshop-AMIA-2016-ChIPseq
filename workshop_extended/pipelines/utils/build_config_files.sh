#!/bin/bash
# Kyle Hernandez
# Center for Research Informatics
# University of Chicago
# License LGPLv3

repo=$1

##############################################################################
# Make the chipseq config
chipseqCfg="${repo}/config/chipseq.cfg"
echo "Writing main config: $chipseqCfg"
cat >$chipseqCfg <<EOL
# 2016 AMIA
# University of Chicago
# Center for Research Informatics
# Kyle Hernandez
#
# This is a basic configuration file for BDS

# Reference file
# This should already be indexed!
reference = /home/ubuntu/data/reference/GRCh38.primary_assembly.chr19.genome.fa

# Threads to use for multithreaded tools
maxThreads = 2

## FastQC 
fastqcExe = /home/ubuntu/software/fastqc-0.11.5/fastqc

## Trimmomatic
trimmomaticExe = /home/ubuntu/software/trimmomatic-0.36/trimmomatic-0.36.jar
# Adapter fastas
adapterFasta = /home/ubuntu/software/trimmomatic-0.36/adapters/TruSeq3-SE.fa

## BWA
bwaExe = /home/ubuntu/software/bwa-0.7.15/bwa

## Sambamba
sambambaExe = /home/ubuntu/software/sambamba-0.6.4/sambamba

## Q
qExe = /home/ubuntu/software/charite-Q-9766321/bin/Q

## Bedtools
intersectExe = /home/ubuntu/software/bedtools2/bin/intersectBed
bamToBedExe = /home/ubuntu/software/bedtools2/bin/bamToBed

## MACS2
macsExe = /home/ubuntu/anaconda2/envs/macs2/bin/macs2

## Deeptools
deeptoolsExe = /home/ubuntu/anaconda2/envs/deeptools/bin/bamCoverage

## FRIP script
fripExe = ${repo}/utils/estimate_frip.sh
EOL

##############################################################################
# Make the Ab1-IgG contrast config
ab1_igg_cfg="${repo}/config/contrast.Ab1.IgG.cfg"
echo "Writing Ab1-IgG contrast config: $ab1_igg_cfg" 
cat >$ab1_igg_cfg <<EOL
# Contrasts
name = Ab1.IgG
ip_sample_id = Ab1
control_sample_id = IgG

ip_sample_config = ${repo}/config/sample.Ab1.cfg 
control_sample_config = ${repo}/config/sample.IgG.cfg
EOL

##############################################################################
# Make the Ab1-input contrast config
ab1_input_cfg="${repo}/config/contrast.Ab1.input.cfg"
echo "Writing Ab1-input contrast config: $ab1_input_cfg" 
cat >$ab1_input_cfg <<EOL
# Contrasts
name = Ab1.input
ip_sample_id = Ab1
control_sample_id = input

ip_sample_config = ${repo}/config/sample.Ab1.cfg 
control_sample_config = ${repo}/config/sample.input.cfg
EOL

 
##############################################################################
# Make the Ab1 sample config
ab1_cfg="${repo}/config/sample.Ab1.cfg"
echo "Writing Ab1 sample config: $ab1_cfg"
cat >$ab1_cfg <<EOL
name = Ab1
fastq = /home/ubuntu/data/chipseq/subset/input_files/Ab1.subset.fq.gz
readgroup_string = "@RG\tID:SRR1200652\tLB:SRR1200652\tSM:U2932.Ab1\tPU:SRX497418.SRR1200652.SAMN02692998.SRS579413"
EOL

##############################################################################
# Make the IgG sample config
igg_cfg="${repo}/config/sample.IgG.cfg"
echo "Writing IgG sample config: $igg_cfg"
cat >$igg_cfg <<EOL
name = IgG 
fastq = /home/ubuntu/data/chipseq/subset/input_files/IgG.subset.fq.gz
readgroup_string = "@RG\tID:SRR1200655\tLB:SRR1200655\tSM:U2932.IgG\tPU:SRX497421.SRR1200655.SAMN02692999.SRS579416"
EOL

##############################################################################
# Make the input sample config
input_cfg="${repo}/config/sample.input.cfg"
echo "Writing input sample config: $input_cfg"
cat >$input_cfg <<EOL
name = input
fastq = /home/ubuntu/data/chipseq/subset/input_files/input.subset.fq.gz
readgroup_string = "@RG\tID:SRR1200656\tLB:SRR1200656\tSM:U2932.input\tPU:SRX497422.SRR1200656.SAMN02692997.SRS579417"
EOL
