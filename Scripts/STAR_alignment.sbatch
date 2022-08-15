#!/bin/sh

#SBATCH --job-name=star_genome_index
#SBATCH --partition=compute
#SBATCH --account=da494
#SBATCH --cpus-per-task=16
#SBATCH --time 12:00:00


module load bioconda
conda activate pipelines_env


for fastq in /storage/akhan264/unzip_final_fastp_trimmed/*_fastp_trimmed_agressive.fastq
do 
   echo $fastq
   OUT=$(basename $fastq .fastq)
   STAR --runThreadN ${SLURM_CPUS_PER_TASK} \
   --genomeDir /storage/akhan264/GRCm39_Tedder \
   --readFilesIn /storage/akhan264/unzip_final_fastp_trimmed/${OUT}.fastq \
   --outFileNamePrefix /storage/akhan264/GRCm39_Tedder/aligned_BAMs/${OUT}_ \
   --outSAMtype BAM SortedByCoordinate
done
