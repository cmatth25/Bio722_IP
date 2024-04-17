#!/usr/bin/env python
# coding: utf-8


# import libraries
import numpy as np
import pandas as pd
import sys

# 1. load tsv file filepath as a variable
filename = sys.argv[1] #Name of file
path = sys.argv[2] #path
file = path + filename #filepath
sample = filename.rsplit( ".", 1 )[ 0 ]
tax = pd.read_csv(file,sep='\t', header = None)

sample
sampleid = sample.rsplit("_", 1)[0]
sampleid

#rename columns
tax = tax.rename(columns={0: "contig", 1: "phylum"}, errors="raise")

#remove preceding P__ from phylum column
tax['phylum'] = tax['phylum'].str.replace('P__', '')

#add sample, reorder
tax['sample']=sampleid
tax = tax[['sample', 'contig', 'phylum']]

#save
file1=sampleid+'_ContigTax.tsv'
tax.to_csv(file1, sep="\t")

