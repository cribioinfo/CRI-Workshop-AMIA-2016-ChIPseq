# 2016 AMIA Pre-Symposium Workshop, ChIP-Seq Analysis, Extended Materials
**[Center for Research Informatics](http://cri.uchicago.edu/), University of Chicago**<br>
November 13, 2016<br>
8:30am-12:00pm<br>
**Instructor:** [Kyle Hernandez, Ph.D.](https://kmhernan.github.io/)<br>

The notebooks available here contain additional materials which you are free to explore on your own time. In addition, the
assets directory contains the images used in the notebooks.

### Pipeline

Within the `pipelines` directory you will find several files:

```
.
├── AMIA-ChIP-Seq-Pipeline.bds
├── config
│   ├── chipseq.cfg
│   ├── contrast.Ab1.IgG.cfg
│   ├── contrast.Ab1.input.cfg
│   ├── sample.Ab1.cfg
│   ├── sample.IgG.cfg
│   └── sample.input.cfg
├── data
│   ├── multiqc_data
│   │   ├── multiqc_fastqc.txt
│   │   ├── multiqc_general_stats.txt
│   │   └── multiqc_sources.txt
│   └── multiqc_report.html
├── RunAmiaPipeline.sh
└── utils
    ├── build_config_files.sh
    ├── estimate_frip.sh
    └── run_multiqc.sh
```

With the exception of the `data` directory, these files are all relevant to running the ChIP-seq pipeline. We used 
[BigDataScript](http://pcingola.github.io/BigDataScript) 
(BDS; Cingolani et al., 2015, [PMID:25189778](https://www.ncbi.nlm.nih.gov/pubmed/25189778)) to develop this pipeline. You 
can explore the `AMIA-ChIP-Seq-Pipeline.bds` file to see the source code of the pipeline. This BDS script takes four
command-line inputs:

1. `-configFile` - The main configuration file (`config/chipseq.cfg`)
2. `-contrastFiles` - One or more contrast configuration files (`config/contrast.Ab1.IgG.cfg`, `config/contrast.Ab1.input.cfg`)
3. `-runDir` - The path to the top-level output directory
4. `-logDir` - The path to the top-level logs directory

#### Configuration Files

BDS can natively handle simple key-value configuration files (`key = value`). This makes is relatively easy to use a single
BDS script across different datasets and computational systems. For our pipeline, we have three different
categories of configuration files.

**Main Configuration File**

Contains the paths to our reference genome and various software executables.

Example: `config/chipseq.cfg`

```
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
fripExe = /home/ubuntu/dev/chipseq/CRI-Workshop-AMIA-2016-ChIPseq/workshop_extended/pipelines/utils/estimate_frip.sh
```

**Contrast Configuration File**

These files contain the information needed to connect a control and treatment (IP) sample together.

Example: `config/contrast.Ab1.IgG.cfg`

```
# Contrasts
name = Ab1.IgG
ip_sample_id = Ab1
control_sample_id = IgG

ip_sample_config = /home/ubuntu/dev/chipseq/CRI-Workshop-AMIA-2016-ChIPseq/workshop_extended/pipelines/config/sample.Ab1.cfg 
control_sample_config = /home/ubuntu/dev/chipseq/CRI-Workshop-AMIA-2016-ChIPseq/workshop_extended/pipelines/config/sample.IgG.cfg
```

**Sample Configuration File**

These files contain the information for a single sample (e.g., a single IP sample or a single input control sample). The
contrast configuration files provide our BDS script with the paths to these files.

Example: `config/sample.Ab1.cfg`

```
name = Ab1
fastq = /home/ubuntu/data/chipseq/subset/input_files/Ab1.subset.fq.gz
readgroup_string = "@RG\tID:SRR1200652\tLB:SRR1200652\tSM:U2932.Ab1\tPU:SRX497418.SRR1200652.SAMN02692998.SRS579413"
```

_Note: the `readgroup_string` parameter provides our BWA aligner the readgroup metadata information. You can read [here](http://gatkforums.broadinstitute.org/gatk/discussion/6472/read-groups) about the various information contained in a read group_

#### Other Files

**`RunAmiaPipeline.sh`**

This bash script was developed to make it easier to run our BDS pipeline. It automatically sets up the paths, creates
the configuration files, and executes the BDS pipeline. It would likely need to be changed to run on your own system. It
executes the `utils/build_config_files.sh` script to create the configuration files with the correct paths.

**`utils/estimate_frip.sh`**

This bash script is a small utility to help with the estimation of our FRiP values. It first gets the total number of reads 
by counting the number of lines in our BED file created from our BAM file. It then counts the total number of overlapping 
peaks from our intersected BED file and divides it by the total number of reads.
