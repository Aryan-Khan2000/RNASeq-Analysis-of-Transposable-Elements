#!/bin/sh

#SBATCH --job-name=wget_yama
#SBATCH --partition=compute
#SBATCH --account=da494
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000
#SBATCH --time 05:00:00

cd /storage/akhan264/yamadataset
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648686/SRR648686.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648687/SRR648687.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648688/SRR648688.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648689/SRR648689.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648690/SRR648690.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648691/SRR648691.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648692/SRR648692.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648693/SRR648693.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648694/SRR648694.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648695/SRR648695.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648696/SRR648696.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR648/SRR648697/SRR648697.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649335/SRR649335.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649336/SRR649336.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649337/SRR649337.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649338/SRR649338.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649339/SRR649339.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649340/SRR649340.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649341/SRR649341.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649342/SRR649342.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR649/SRR649343/SRR649343.fastq.gz
