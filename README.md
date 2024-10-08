# Metagenomic Biosynthetic potential
Independent project

Terrestrial and marine whole metagenome sequences from environmental DNA (eDNA) samples chosen from SRA filtered for depth (>20M reads), consistent sequencing methodology (Illumina paired end reads >= 150 bp) and representing diverse environmental and geographical areas. 20 samples will be selected with roughly equal representation between the two ecosystem types. Following preprocessing, including quality control and trimming by fastp, Kraken2 will be used to assign reads to taxa for relative abundance and taxonomic profiling of alpha and beta diversity by Bracken and KrakenTools. Top BGC containing taxa will be ranked, and enrichment for these taxa in ecosystem type and specific biomes will be determined by differential abundance. After taxonomic profiling, the QC'd reads will undergo assembly using MEGAHIT. The resulting metagenomic contigs will be run through antiSMASH 6.0 to identify BGCs for biosynthetic capacity of environmental metagenomes. 

dataset folder contains information about selected samples.
QC folder contains scripts used for trimming by fastp, qc by fastQC/multiQC and decontamination of human DNA by BBMap removehuman tool.
Classification folder contains scripts used for classification of QC'd reads for calculating relative abundances and for classifying Contigs.
Assembly folder contains scripts for the de novo assembly of contigs and filtering contigs.
antismash folder contains scripts for running antiSMASH and parsing outputs for BGC counts.
