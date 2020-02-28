---
layout: post
title: DelBay19 Mapping Data Evaluation
date: '2020-02-04 22:04'
tags:
  - mapping
  - evaluation
  - MAPQ
  - bowtie2
categories:
  - WGS data analysis
---

In the past two day I was still working on the reads mapping/trimming, at this Wednesday I will start removing duplicates using the GATK pipeline.

- continue with pool4 data trimming and QC, add the result to google doc (done)

Please see google doc here [WGS_raw_data_evaluation](https://docs.google.com/document/d/15dQF1MDyHj72yQsQN51d8vmZZAIbdH2CGmbXM_0OR8A/edit)

Also read counts summary here [Read_counts_summary](https://docs.google.com/spreadsheets/d/10V7vTdNp7oagq4SlPPfOGA-kgmrmh4x6m4olKCdzB6E/edit#gid=126903255)

The MultiQC can be downloaded from here (if the links does not work, copy and paste the URL to browser)

[Pool1](https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool1.zip): 84 individuals, after removing negatives and 3 failed sample with reads < 200 (COH0419_043, CHO0419_047, and ARN0419_049)
https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool1.zip

[Pool2](https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool2.zip): 88 individuals, after removing negatives
https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool2.zip

[Pool3](https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool3.zip): 88 individuals, after removing negatives
https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool3.zip

[Pool4](https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool4.zip): 79 individuals, after removing negatives and 1 failed sample (ARN0419_039)
https://github.com/hg-zhao/hg-zhao.github.io/raw/master/MultiQC_results/DelBay19_pool4.zip

- continue with pool1&2 data mapping, also begin to map pool4 sample (first come with LV0719_001AMP, a lavae pool)

According to the MultiQC report, one of the individual (SR0419ch_327) in pool2 has shown odd GC content. We decided to drop this sample for current data analysis.

<img src="https://hg-zhao.github.io/images/2020-02-03-0.png" alt="img" width="800"/>

To run the mapping in a more efficient way, I created a new SLURM cluster.

```shell
manage_slurm new cbsumm02
#Creating Cluster with masterNode=cbsumm02
#BDHOST: cbsulsrv08.biohpc.cornell.edu
#TMP: /tmp
#TEMPL: /programs/config/slurm/configs/slurm_templ.conf
#BINDIR: /programs/config/slurm/setup_scripts
#Control node will be: cbsumm02
#Cluster machines: cbsumm02
#IP: 128.84.180.222
#SLURM cluster config file prepared in /programs/config/slurm/configs/slurm_cbsumm02.conf
#Cluster munge key prepared in /programs/config/slurm/configs/munge_cbsumm02.key
#Cluster cbsumm02 added to slurmdbd
#Appending cbsumm02 to slurm.conf
#Configuring/starting daemons on cbsumm02
#Defining a new account acc_cbsumm02_113929 on cluster cbsumm02
#Configuring user access to the cluster...
#Cluster cbsumm02 prepared
#...
#Done monitorSlurm
#Done.

manage_slurm list
#CLUSTER: cbsumm02
#  Machine	CPUs	memory (GB)
#  cbsumm02	24	126
#  Users: hz269

# To run the script
sbatch --cluster cbsumm02 --job-name=pool1_mapping --ntasks=10 --mem=60000 --mail-user=hz269@cornell.edu --mail-type=ALL  pool1_mapping.sh

# hint: the shell script must be put AFTER the parameter settings, otherwise the SLURM will stick with the default settings
# the pool1_mapping.sh looks like this:
# #!/bin/sh
# ./Bowtie2_mph.sh 6565_refCV_10fixchr.fa cv30 pool1.list /home/hz269/workdir/hz269/pool1_mapping/bamfiles > pool1_bt2.log

# do the same thing for pool2
```

- evaluate mapping results with different trimming parameters

currently we will stick with -q 20

- read SARC annual oyster report

[Delaware Bay Oyster Stock Assessment](https://hsrl.rutgers.edu/SAWreports/index.htm)


---

#### RESULTS

NA
