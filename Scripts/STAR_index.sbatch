#!/bin/sh

#SBATCH --job-name=star_genome_index
#SBATCH --partition=compute
#SBATCH --account=da494
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=8000
#SBATCH --time 12:00:00


module load bioconda
conda activate pipelines_env
STAR --runMode genomeGenerate --genomeDir /storage/akhan264/GRCm39_Tedder  --genomeFastaFiles /storage/akhan264/GRCm39_Tedder/GRCm39.genome.fa --sjdbGTFfile GRCm39_combined_genome_TEs.gtf
