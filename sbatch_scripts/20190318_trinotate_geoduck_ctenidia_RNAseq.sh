#!/bin/bash
## Job Name
#SBATCH --job-name=transdecoder
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=25-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190318_trinotate_geoduck_ctenidia_RNAseq

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


wd="$(pwd)"


# Paths to input/output files
## Non-working directory locations
blastp_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_transdecoder_geoduck_ctenidia_RNAseq/blastp_out"
pfam_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_transdecoder_geoduck_ctenidia_RNAseq/pfam_out"
transdecoder_out_dir="/gscratch/scrubbed/samwhite/outputs/20190318_transdecoder_geoduck_ctenidia_RNAseq/Trinity.fasta.transdecoder_dir"

trinity_fasta="/gscratch/scrubbed/samwhite/outputs/20190215_trinity_geoduck_ctenidia_RNAseq/trinity_out_dir/Trinity.fasta"

## New folders for working directory
signalp_out_dir="${wd}/signalp_out"
tmhmm_out_dir="${wd}/tmhmm_out"
rnammer_out_dir="${wd}/RNAmmer_out"


blastp_out="${blastp_out_dir}/blastp.outfmt6"
pfam_out="${pfam_out_dir/pfam.domtblout}"
lORFs_pep="${transdecoder_out_dir}/longest_orfs.pep"
rnammer_out="${rnammer_out_dir}/Trinity.fasta.rnammer.gff"
signalp_out="${signalp_out_dir}/signalp.out"
tmhmm_out="${tmhmm_out_dir}/tmhmm.out"


# Paths to programs
rnammer_dir="/gscratch/srlab/programs/RNAMMER-1.2"
rnammer="${rnammer_dir}/rnammer"
signalp_dir="/gscratch/srlab/programs/signalp-4.1"
signalp="${signalp_dir}/signalp"
tmhmm_dir="/gscratch/srlab/programs/tmhmm-2.0c/bin"
tmhmm="${tmhmm_dir}/tmhmm"