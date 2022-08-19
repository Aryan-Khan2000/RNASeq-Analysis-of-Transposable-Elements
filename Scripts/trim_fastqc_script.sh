#!/bin/sh
#SBATCH --partition=compute
#SBATCH --time 02:00:00
#SBATCH --account=da494
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8000
#SBATCH --job-name FastQC

cd /storage/akhan264/fastp_trimmed_SMART_seq
module load bioconda
module load jdk
conda activate pipelines_env
fastqc SRR*
#mv *fastqc* /storage/akhan264/trimmed_fastqc_results
