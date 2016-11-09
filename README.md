# 2016 AMIA Pre-Symposium Workshop, ChIP-Seq Analysis
**[Center for Research Informatics](http://cri.uchicago.edu/), University of Chicago**<br>
November 13, 2016<br>
8:30am-12:00pm<br>
**Instructor:** [Kyle Hernandez, Ph.D.](https://kmhernan.github.io/)<br>

### Overview

In this 1-hour session, participants will learn about the basics of what ChIP-seq is, the kinds of questions,
it can answer, and gain some hands-on experience with real ChIP-seq data. All of this will be done on Amazon's
EC2 cloud environment.

### Format

Both the lectures and hands-on documentation were developed using [Jupyter](http://jupyter.org/) notebooks. The first
two parts of this session will be in lecture format. The first section will provide you with a basic understanding of 
ChIP-seq experiments and experimental design suggestions. The second session will introduce you to the basic workflow of
analyzing ChIP-seq data with a particular focus on detecting ChIP-seq peaks and quality control. After these lectures we
will move on to our hands-on activity which uses a Jupyter notebook with [R](https://irkernel.github.io/) to annotate 
and visualize our data. Finally, we will combine the RNA-seq results with our ChIP-seq results.

### Dataset

Our example data comes from a [published paper](https://www.ncbi.nlm.nih.gov/pubmed/25499759) that explores PRDM11 
and lymphomagenesis. We will use the data from the Ab1 and RNAPII factors as well as both control samples. You are 
welcome to explore the full dataset on GEO ([GSE56065](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE56065)).

> Fog et al., 2015, Loss of PRDM11 promotes MYC-driven lymphomagenesis, Blood 125:1272-1281 

### Other information

There are two main Jupyter notebooks for this session:

* `01.Run_ChIPseq.tutorial.ipynb`
* `02.Run_ChIPseq.hands_on.ipynb`

If something goes wrong, the `02.Run_ChIPseq.hands_on.rendered.ipynb` notebook can be used which has all the outputs rendered.
In addition, the `workshop_extended` directory contains notebooks with more information that you can browse on your own time.

### License

These materials are licensed via [LGPLv3](https://www.gnu.org/licenses/lgpl-3.0.en.html) with a copy available in this repository.
