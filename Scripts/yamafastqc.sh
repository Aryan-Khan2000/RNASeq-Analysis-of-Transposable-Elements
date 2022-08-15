#!/bin/sh
#SBATCH --partition=compute
#SBATCH --time 06:00:00
#SBATCH --account=da494
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8000
#SBATCH --job-name FastQC

module load bioconda
#module load jdk
conda activate pipelines_env
fastqc SRR*
mv *fastqc* /storage/akhan264/yamafastqc
