Classify reads:

krakenbuild.sh build std kraken db

brackenbuild.sh for all read lengths of kraken reports for bayesian re-estimation of abundances

ClassifyKraken2.sh is used to classify sequences, output kraken reports for analysis

bracken.sh to estimate abundances

combinekreport.sh to pull together individual sample reports into one file

brackenprocessing.sh to filter to desired taxonomic level and reformat

bracken_data_transpose.ipynb contains data processing for relative abundance plotting

Classify assembled contigs:

ContigClassification.sh classifies filtered contigs, kraken output used for conversion using KrakenTools kraken2_translate.py

ContigTaxonomy.sh uses kraken2_translate.py tool from KrakenTools to convert kraken taxid to full taxonomy

ExtractContigPhyla.sh extracts phyla for each contig where applicable

Convertloop.sh uses ContTaxConvert.py to process the Contig classification taxa outputs for all samples
