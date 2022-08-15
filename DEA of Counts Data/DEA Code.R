
library(DESeq2)
library(ggplot2)
library(ggrepel)
library(pheatmap)

countData <- read.csv("C:/Users/Akhan/Documents/DEA of Counts Data/AK_summed_duplicates.csv", header = TRUE, sep = ",")
metaData <- read.csv("C:/Users/Akhan/Documents/DEA of Counts Data/AK_counts_info.csv", header = TRUE, sep = ",")
metaDatalabel <- read.csv("C:/Users/Akhan/Documents/DEA of Counts Data/AK_counts_info - Copy.csv", header = TRUE, sep = ",", row.names = 2)

dds <- DESeqDataSetFromMatrix(countData=countData, 
                              colData=metaData, 
                              design= ~dazlKO+strain+timePoint, tidy = TRUE) # tidy = TRUE

dds <- estimateSizeFactors(dds)
keep <- rowSums(counts(dds, normalized=TRUE) >= 50) >= 3
dds <- dds[keep,]

dds <- DESeq(dds)

dds$timePoint <- factor(dds$timePoint, levels = c("E9.5", "E11.5", "E13.5", "E15.5"))

res <- results(dds)

#This produces plotcounts in "Gene-Name" Gene was put in to create plotcount
d <- plotCounts(dds, gene="Gene-Name", intgroup="timePoint", returnData = TRUE,
                normalized = TRUE)
library("ggplot2")
ggplot(d, aes(x=timePoint, y=count)) + 
  geom_point(position=position_jitter(w=0.1,h=0)) + 
  scale_y_log10() +
  geom_text_repel(aes(label = row.names(metaDatalabel)), ggrepel.max.overlaps = Inf) +
  ggtitle("Gene-Name")


resOrdered <- res[order(res$padj),]
select_genes<-rownames(subset(resOrdered, padj))
rld <- rlog(dds, blind=FALSE)

#To produce heatmaps of the TEs
TE_fac <- select_genes[c(10589, 11081, 11643, 14904, 2089, 4086, 12517, 13865, 11338, 12749, 13900, 12033, 14186, 15179, 17740, 19601, 12772, 15354, 6383, 10692, 3554, 7880, 1284, 2213, 4059, 2122, 5435, 11655)]
df <- as.data.frame(colData(dds)[,c("dazlKO","timePoint")])
pheatmap(assay(rld)[TE_fac,], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=FALSE, annotation_col=df)

sine_fac <- select_genes[c(6933, 10027, 5238, 5964, 8878, 5588, 6724, 7392, 
                           5124,  7195, 7995, 5397, 4837, 6349,
                           5701, 6280, 6006, 6923)]
df <- as.data.frame(colData(dds)[,c("dazlKO","timePoint")])
pheatmap(assay(rld)[sine_fac,], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=FALSE, annotation_col=df)

erv_fac <- select_genes[c(1102, 11410, 5716, 9085, 19311, 11364, 17685, 13262, 13553, 10750, 9261, 3408, 5908, 9950, 4296)]
df <- as.data.frame(colData(dds)[,c("dazlKO","timePoint")])
pheatmap(assay(rld)[erv_fac,], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=FALSE, annotation_col=df)

#To produce volcano plots
dazlc <- results(dds, alpha = 0.001, contrast=c("dazlKO","control","treated"))
summary(dazlc)
dazlcOrdered <- dazlc[order(dazlc$padj),] 
head(dazlcOrdered)
write.csv(as.data.frame(dazlcOrdered), 
          file="dazlcOrdered.csv")
dazlcres <- read.csv("C:/Users/Akhan/Documents/DEA of Counts Data/dazlcOrdered.csv",row.names = 1)
dazlcresTE <- dazlcres[c("L1Lx_I", "L1Lx_II", "L1Lx_IV", "L1Lx_III", "L1MdA_I", "L1MdA_II", "L1MdA_III",  
                       "L1MdA_IV", "L1MdA_V", "L1MdA_VII", "L1MdA_VI", "L1MdF_II", "L1MdF_III", "L1MdF_V",
                       "L1MdF_I", "L1MdF_IV",  "L1MdFanc_II", "L1MdFanc_I", "L1MdGf_I", "L1MdGf_II", "L1MdMus_II", 
                       "L1MdMus_I", "L1MdTf_II", "L1MdTf_I", "L1MdTf_III",  "L1MdV_I", "L1MdV_III", "L1MdV_II"),]
ggplot(dazlcresTE, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point() +
  geom_text_repel(aes(label = row.names(dazlcresTE)), ggrepel.max.overlaps = Inf)

dazlcresTOP <- dazlcres[1:20,]
ggplot(dazlcresTOP, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point() +
  geom_text_repel(aes(label = row.names(dazlcresTOP)), ggrepel.max.overlaps = Inf)

dazlcresERV <- dazlcres[c("IAP-d-int",       "IAP1-MM_I",       "IAP1-MM_LTR",    
                        "IAPEz-int",       "IAPLTR1_Mm",      "IAPLTR1a_Mm",    
                        "IAPLTR2_Mm",      "ERVB2_1A-I_MM",   "ERVB4_1-I_MM",   
                        "ERVB4_1B-I_MM",   "ERVB4_1B-LTR_MM", "ERVB4_1C-LTR_Mm",
                        "ETnERV-int",      "ETnERV2-int",     "ETnERV3-int"),]
ggplot(dazlcresERV, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point() +
  geom_text_repel(aes(label = row.names(dazlcresERV)), ggrepel.max.overlaps = Inf)

dazlcresSINE <- dazlcres[c("B1F", "B1F1", "B1F2", "B1_Mm", "B1_Mur1", "B1_Mur2",
                         "B1_Mur3", "B1_Mur4", "B1_Mus1", "B1_Mus2", "B2_Mm1a", "B2_Mm1t",
                         "B2_Mm2",  "B2m", "B3",  "B3A", "B4",   "B4A"),]
ggplot(dazlcresSINE, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point() +
  geom_text_repel(aes(label = row.names(dazlcresSINE)), ggrepel.max.overlaps = Inf)

ggplot(dazlcres, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point() +
  expand_limits(x = 0, y = 0)
