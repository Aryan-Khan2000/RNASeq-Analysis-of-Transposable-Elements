# Dissertation Project

During my time as a bioinformatics student I did a final year project that took my knowledge of genetics, statistics, and computer science to the test. This project was finding the pathways and mechanisms responsible for the regulation of transposable element expression.

# What are Transposable Elements and why are they important

Transposable elements (TEs) are mobile DNA sequences that can integrate from one part of the genome to another altering the germline of an organism. TEs take up almost half the genome in many species such as mice and humans which makes understanding how transposable elements are regulated important to understanding what mechanisms can trigger their expression. These transposable elements include LINEs, SINEs, and ERVs. Pathways such as methylation, pluripotency, and piRNAs are shown to repress the expression of transposable elements so understanding the pathways and mechanisms that regulate the expression of these pathways will be useful in understanding how TEs are repressed. 

# Aims and Methodology

The aim of this analysis is to identify the pathways and mechanisms responsible for regulating the expression of transposable elements in the mammalian germline. Performing RNASeq is a logical approach as it captures all expressed genes and not just a particular gene of interest. RNASeq analysis of raw sequence data used a customised pipeline containing a quality control, alignment, and differential expression analysis of the reads. These pipelines involved the use software programs Linux, Python, and R.

1.8 Aims and Objectives:
The aim of this research is to investigate the pathways and mechanisms regulating the expression of TEs which can be seen using gene ontology and RNASeq analysis. This will be done via RNASeq on raw sequence data using a pipeline  for quality control, alignment, and differential expression analysis of the raw sequences. Gene ontology will be performed using the data produced in the RNASeq pipeline to give a better understanding of the pathways and mechanisms involved.
Methods:
2.1 RNASeq Data Download
The RNASeq fastq files for the data come from the NCBI website with the Accession IDs of PRJNA669846 (Nicholls, unpublished data) and PRJNA178509 (Yamaguchi et al. 2013). As the files were in SRA format, the website ENA Browser (Leinonen et al. 2010) was used to get the files in fastq format. The files from PRJNA669846 contain fastq sequences from E15.5 that are either the 129S4 (129) or C57BL/6 (B6N) strains. For each strain there was a control RNASeq and a Dazl KO samples. Each one of the controls and Dazl KO had two runs done for each so in total eight RNASeq libraries. The files for PRJNA178509 contained fastq sequences from E9.5, E11.5 and E13.5 with multiple RNASeq for each timepoint with the strain C57BL/6 being used for these RNASeq. These fastq files were then downloaded on to LINUX on the Bradford HPC to run data analysis on.



Accession ID	Species	Strains	Instrument	Strategy	Source	Selection	Layout
PRJNA669846	Mus Musculus	129S4 and C57BL/6	Illumina HiSeq 2500	RNA-Seq	TRANSCRIPTOMIC	PolyA	SINGLE
PRJNA178509	Mus Musculus	C57BL/6	Illumina HiSeq 2000	RNA-Seq	TRANSCRIPTOMIC	cDNA	SINGLE

Table 2.1 - Depicts the RNASeq files with the details of how the raw RNA sequences are made (Nicholls, unpublished data) (Yamaguchi et al. 2013).
2.2 Data Analysis 
The code for all the data analysis scripts used can be found in Chapter 5.0, Code Availability
2.2.1 Quality Control
To check the quality of the raw sequences, FastQC v0.11.9 (Andrews, 2010) was used using default parameters. FastQC analyses fastq data, and reports criteria such as average base quality using phred scores, and the presence of any overrepresented sequences in the data, typically adaptors, but also PCR artefacts. Fastp v0.23.1 (Chen et al., 2018) was used to trim the poor-quality sequences and adapters to increase the quality of the data. A minimum phred score of 30 was used as it provides a 99.9% degree of accuracy with a 0.1% margin of error of the quality of the data (Zhang et al. 2017). The minimum sequence length used was 25 to remove polyT repeats. The adapters removed include the SMART-Seq oligonucleotide sequence - GTATCAACGCAGAGTACT, and the Clontech SMART CDS Primer II A - AAGCAGTGGTATCAACGCAGAGTAC. FastQC was then performed again to check the quality of the reads after trimming was performed. 
2.2.2 Alignment
Alignment refers to mapping sequence reads to a reference genome. This alignment can be used in transcriptome analysis to compare levels of gene expression in both sequences for differential gene expression analysis (Musich et al. 2021) (Grant et al. 2011). The mouse reference genome (GRCm39) and the GRCm39 annotation GTF were obtained from GENCODE (date accessed, 09/07/22). Because this experimental setup is focused on TEs it was important to ensure that the annotation contained location information for these elements. To this end, a bespoke TE annotation was downloaded for this genome from (HammellLab, n. d.) and merged the annotation files prior to creating a genome index. Using both the reference genome and combined GTF file a genome index was created using STAR v2.7 (Dobin et al. 2013). Alignment of the trimmed sequences was then performed using STAR with the following parameters – runMode alignReads which was done for alignment, --genomeDir “filepath” to use the genome index created with the merged annotation files, --outSAMtype BAM SortedbyCoordinate to produce BAM files, --runThreadN 12, --readFilesIn to use the trimmed fastq sequences, and –outFileNamePrefix to export the files produced from the alignment. To produce multi-mapped read counts the tool mmquant v1.3 (Zytnicki 2017) using the BAM files created with the combined GTF and -g which gives the gene names produced the reads counts of the sequences instead of gene IDs. Multi-mapping reads were permitted to ensure there was no loss of data as unique mapping removes reads mapping to multiple places, which may mean losing important data (Deschamps-Francoeur et al. 2020). 

2.2.3 Differential Expression Analysis
For differential expression analysis of the data DESeq2 (Love et al. 2014) was used within R (Team 2013). As a txt file was generated from mmquant it had to be converted into a csv file for compatibility with R. This conversion was done using jupyter notebook (Perkel 2018).Then as there were duplicates of the genes within the read counts file the duplicates genes were merged and summed using jupyter notebook. The duplicated genes may have been due to TEs mapping to unique parts of the genome so multiple TEs with the same name were present within the count data.DESeq2, ggplot2 (Wickham 2016), pheatmap (Kolde and Kolde 2018), and ggrepel (Slowikowski et al. 2018) was used for differential expression analysis. DESeq2 was responsible for producing the differential expression of the genes and had a function called plotPCA to produce PCA plots. The package ggplot2 was involved in the creation of figures such as volcano plots and count plots with the aid of ggrepel for plot labels. The package pheatmap was used to create heatmap figures. Genes used in the plotting of the volcano plots and heatmaps can be found in tables 2.2, 2.3, 2.4, 2.5, and 2.6. To also provide conditions for the count data such as timepoints of the age, strain, and whether the sample was control or Dazl KO of the mice and to provide labels for the samples, Excel files were created. These output figures were then further edited using Adobe Illustrator to aid interpretation.

 
Figure 2.1 - RNASeq analysis workflow. Raw sequences were first checked quality using FastQC, with adapters and low-quality reads trimmed using Fastp. Reads were then aligned to the GRCm39 reference mouse genome using STAR. mmquant was performed to get count mapped reads. Differential expression analysis was performed using DESeq2 to generate figures to display the count reads. This figure was created using BioRender.



Gene
Lin28a
Nanog
Prdm14
Klf5
Klf2
Utf1
Zfp42
Pou5f1
Zic3
Esrrb
Sox2
Sall4
Ifitm3
Tcl1
Tdgf1
Tfcp2l1
Nr0b1

Table 2.2 - Naïve and general pluripotency factors in mice used to identify how the expression of these pluripotency factors would be affected in the RNASeq samples (Nicholls et al, 2019).

Gene
Asz1
Btbd18
Ddx4
Exd1
Fkbp6
Gpat2
Henmt1
Mael
Mov10l1
Mybl1
Piwil1
Piwil2
Piwil4
Pld6
Pnldc1
Tdrd1
Tdrd5
Tdrd6
Tdrd7
Tdrd9
Tdrd12
Tdrkh

Table 2.3 - piRNA biogenesis factors in mice to be used to identify how the expression of these piRNA biogenesis factors would be affected in the RNASeq samples obtained from a gene ontology database (MGI 2022) 

Gene 
L1Lx_I
L1Lx_II 
L1Lx_IV
L1Lx_III
L1MdA_I
L1MdA_II 
L1MdA_III
L1MdA_IV
L1MdA_V
L1MdA_VII
L1MdA_VI
L1MdF_II 
L1MdF_III 
L1MdF_V
L1MdF_I
L1MdF_IV
L1MdFanc_II
L1MdFanc_I
L1MdGf_I
L1MdGf_II
L1MdMus_II
L1MdMus_I 
L1MdTf_II
L1MdTf_I
L1MdTf_III
L1MdV_I
L1MdV_III
L1MdV_II

Table 2.4 - Sub-families of Line-1 TEs found in mice to be used to identify how the expression of these TEs would be affected in the RNASeq samples using a mixture of genes located in reads count file and from the paper from (Zoch et al. 2020).

Gene
B1F
B1F1
B1F2
B1_Mm
B1_Mur1
B1_Mur2
B1_Mur3
B1_Mur4
B1_Mus1
B1_Mus2
B2_Mm1a
B2_Mm1t
B2_Mm2
B2m
B3
B3A
B4
B4A

Table 2.5 - SINE TEs found in mice used to identify how the expression of these TEs would be affected in the RNASeq samples using a mixture of genes located in reads counts file and from the paper (Ichiyanagi et al. 2021). 

Gene
IAP-d-int
IAP1-MM_I
IAP1-MM_LTR
IAPEz-int
IAPLTR1_Mm
IAPLTR1a_Mm
IAPLTR2_Mm
ERVB2_1A-I_MM
ERVB4_1-I_MM
ERVB4_1B-I_MM
ERVB4_1B-LTR_MM
ERVB4_1C-LTR_Mm
ETnERV-int
ETnERV2-int
ETnERV3-int

Table 2.6 –ERV TEs found in mice used to identify how the expression of these TEs would be affected in the RNASeq samples using a mixture of genes located in reads counts file and from the paper  (Zoch et al. 2020).

2.3 Gene Ontology performed using DAVID
Gene ontology was performed to see whether certain functions or pathways were overrepresented in the differentially expressed genes. In order to do this,  the csv file was exported containing all genes that showed a greater than 2-fold differential expression between the control and the Dazl KO samples, with <0.001 adjusted p-value. This csv file contained the top 1000 genes ordered by the highest adjusted p-value which was put it in to the website g:Profiler (g:Profiler 2022) to convert the gene names into ENSEMBL geneID. This was then exported as a csv file, as DAVID (Sherman et al. 2022) requires geneIDs. Then within excel the multi-mapped genes were removed as they had no ENSEMBL geneID. Then the list of ENSEMBL gene ids was copied into DAVID and the identifier to ENSEMBL gene ids was set and the gene list was selected. After this the gene ontology (GO) tab was selected and GOTERM_BP_DIRECT was selected, which refers to the gene ontology biological pathways. The EASE value was set to 0.0001 to display the genes with a p-value below 0.0001 and the display was set to Bonferroni to reduce chance of false positives and accounts for multi-hypothesis testing which resulted in four biological pathways being shown. Each pathway had a p-value below 0.0001 and had between 32 and 47 genes within each pathway. However, the only pathway that had Bonferroni below 0.05 and a p-value below 0.0001 was the cellular response to DNA damage stimulus.




![image](https://github.com/Aryan-Khan2000/RNASeq-Analysis-of-Transposable-Elements/assets/93936591/0545cdef-f710-48a2-b494-e71d5c150d48)

Figure 2.1 - RNASeq analysis workflow. Raw sequences were first checked quality using FastQC, with adapters and low-quality reads trimmed using Fastp. Reads were then aligned to the GRCm39 reference mouse genome using STAR. mmquant was performed to get count mapped reads. Differential expression analysis was performed using DESeq2 to generate figures to display the count reads. This figure was created using BioRender.
