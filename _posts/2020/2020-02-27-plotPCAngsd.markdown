---
comments: true
title: plotPCAngsd_R_script
date: '2020-02-27 19:00'
tags:
  - angsd
  - plot
  - PCA
  - R
categories:
  - tools
---

I edited the plotPCAngsd_mod.R script to facilitate the labeling of individaul points under certain x & y-axis values.  

The R script can be download [here](https://hg-zhao.github.io/scripts/plotPCAngsd_label.R) or my github site https://github.com/hg-zhao/hg-zhao.github.io/blob/master/scripts/plotPCAngsd_label.R

### usage

```shell

Rscript -i infile.covar -c component1-component2 -a annotation.file -o outfile.pdf --x_min minimum_x_value --x_max maximum_x_vlaue --y_min minimum_y_value --y_max maximum_y_value

# an example run on my wild populations

Rscript --verbose plotPCAngsd_label.R -i wild_227_D100maxD450_minQ20_minMAF05_SNPe6_no227inv.cov.npy -c 1-2 -a wild_227.txt -o wild_227_D100maxD450_minQ20_minMAF05_SNPe6_no227inv.PCAngsd.WGS.pc1-2.pdf --x_min 0 --x_max 1 --y_min 0 --y_max 1

```
<img src="https://hg-zhao.github.io/images/wild_227_D100maxD450_minQ20_minMAF05_SNPe6_no227inv.PCAngsd.WGS.pc1-2_test1-page-001.jpg" alt="img" width="800"/>

What if I want to narrow the range and only include the left four individuals

```shell

Rscript --verbose plotPCAngsd_label.R -i wild_227_D100maxD450_minQ20_minMAF05_SNPe6_no227inv.cov.npy -c 1-2 -a wild_227.txt -o wild_227_D100maxD450_minQ20_minMAF05_SNPe6_no227inv.PCAngsd.WGS.pc1-2.pdf --x_min -0.3 --x_max -0.15 --y_min -0.1 --y_max 0.1

```
<img src="https://hg-zhao.github.io/images/wild_227_D100maxD450_minQ20_minMAF05_SNPe6_no227inv.PCAngsd.WGS.pc1-2_test2-page-001.jpg" alt="img" width="800"/>

### Important notes:

1. a start run with --x_min 0 --x_max 0 --y_min 0 --y_max settings allows the plot without labels - good for visualizing overall patterns

2. may need to change the eigen$value and eigen$vactor at line 44 and 54.

3. the annotation file is a tab-delimited text file. IID is individual ID, and CLUSTER is population ID. A example file looks like,

| FID  | IID | CLUSTER |
| -----| ----| --------|
| 1    | ARN0419_001 | ARN |
| 2    | ARN0419_002 | ARN |
| 3    | ARN0419_003 | ARN |




