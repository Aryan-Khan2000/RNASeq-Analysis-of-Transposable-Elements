#!/bin/sh

#SBATCH --job-name=star_genome_index
#SBATCH --partition=compute
#SBATCH --account=da494
#SBATCH --cpus-per-task=20
#SBATCH --time 24:00:00


module load bioconda
conda activate pipelines_env


for fastq in /storage/akhan264/unzip_yamadataset/*_fastp_trimmed.fastq
do 
   echo $fastq
   OUT=$(basename $fastq .fastq)
   STAR --runThreadN ${SLURM_CPUS_PER_TASK} \
   --genomeDir /storage/akhan264/GRCm39_Tedder \
   --readFilesIn /storage/akhan264/unzip_yamadataset/${OUT}.fastq \
   --outFileNamePrefix /storage/akhan264/GRCm39_Tedder/yama_aligned_BAMs/${OUT}_ \
   --outSAMtype BAM SortedByCoordinate
done
