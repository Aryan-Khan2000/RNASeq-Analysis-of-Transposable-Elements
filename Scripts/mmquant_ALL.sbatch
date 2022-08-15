#!/bin/sh
#SBATCH --partition=compute
#SBATCH --time=96:00:00
#SBATCH --account=da494
#SBATCH --cpus-per-task=29
#SBATCH --job-name=mmquant

module load bioconda
conda activate pipelines_env

mmquant -r /storage/akhan264/GRCm39_Tedder/combined_aligned_BAMs/*_Aligned.sortedByCoord.out.bam -a /storage/akhan264/GRCm39_Tedder/GRCm39_combined_genome_TEs.gtf -o /storage/akhan264/GRCm39_Tedder/mmquant_results/ALL_samples_GRCm39_TEs_threaded_counts.txt -g -t ${SLURM_CPUS_PER_TASK}
