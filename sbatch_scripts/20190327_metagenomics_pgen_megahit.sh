#!/bin/bash
## Job Name
#SBATCH --job-name=megahit
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
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190327_metagenomics_geo_megahit

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Load Open MPI module for parallel, multi-node processing

module load icc_19-ompi_3.1.2

# SegFault fix?
export THREADS_DAEMON_MODEL=1

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log


# variables
wd=$(pwd)
fastq_dir=/gscratch/srlab/sam/data/metagenomics/P_generosa
megahit=/gscratch/srlab/programs/megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin/megahit
bbmap_dir=/gscratch/srlab/programs/bbmap_38.34
cpus=28

## Inititalize arrays
fastq_array_R1=()
fastq_array_R2=()
names_array=()

# Create array of fastq R1 files
for fastq in ${fastq_dir}/*R1*.gz
do
  fastq_array_R1+=(${fastq})
done

# Create array of fastq R2 files
for fastq in ${fastq_dir}/*R2*.gz
do
  fastq_array_R2+=(${fastq})
done

# Create array of sample names
## Uses awk to parse out sample name from filename
for R1_fastq in ${fastq_dir}/*R1*.gz
do
  names_array+=($(echo ${R1_fastq} | awk -F"_" '{print $3 $4}'))
done

for fastq in ${fastq_dir}*.gz
do
  echo ${fastq} >> fastq.list.txt
done


for sample in ${!names_array[@]}
do
  mkdir ${sample} && cd ${sample}
  # Run Megahit using paired-end reads
  ${megahit} \
  -1 ${fastq_array_R1[sample]} \
  -2 ${fastq_array_R2[sample]} \
  --num-cpu-threads ${cpus} \
  --out-prefix ${sample}

  # Determine coverage
  ## Align reads with BBmap BBwrap
  ${bbmap_dir}/bbwrap.sh \
  ref=megahit_out/${sample}.contigs.fa \
  in1=${fastq_array_R1[sample]} \
  in2=${fastq_array_R2[sample]} \
  out=${sample}.aln.sam.gz

  ## Output contig coverage
  ${bbmap_dir}/pileup.sh \
  in=${sample}.aln.sam.gz \
  out=${sample}.coverage.txt
done
