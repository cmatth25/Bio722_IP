#!/usr/bin/env python
# coding: utf-8

# In[12]:


# import libraries
import numpy as np
import pandas as pd
import json
import sys


filename = sys.argv[1] #Name of file
path = sys.argv[2] #path
file = path + filename #filepath
sample = filename.rsplit( ".", 1 )[ 0 ] #sample name is file without extension
sampleid = sample.rsplit("_", 1)[0] #remove underscores and anything to strip down to sample ID
antismash = json.load(open(file))

#get 2 nested json structures
bgcs = pd.DataFrame(antismash["timings"])
data =  pd.DataFrame(antismash["records"])

#contigs
bgcids = list(bgcs.columns)
#retrieve contig indices
bgcindex=[]
for i in range(len(data)):
    for item in range(len(bgcids)):
        if data['id'][i] == bgcids[item]:
            bgcindex.append(i)
        else:
            pass


#retrieve info from data json
bgctable = pd.DataFrame(columns=['sample','contig','BGC category','BGC product', 'core start', 'core end'])

for i in range(len(bgcindex)):
    for j in range(len(data['areas'][bgcindex[i]])):
        for k in range(len(data['areas'][bgcindex[i]][j]['protoclusters'])):
            bgct=data['areas'][bgcindex[i]][j]['protoclusters']['0']['category']
            prod=data['areas'][bgcindex[i]][j]['protoclusters']['0']['product']
            cstart=data['areas'][bgcindex[i]][j]['protoclusters']['0']['core_start']
            cend=data['areas'][bgcindex[i]][j]['protoclusters']['0']['core_end']
            df=pd.DataFrame({'sample':[sampleid],'contig':[bgcids[i]], 'BGC category':[bgct], 'BGC product':[prod], 'core start':[cstart], 'core end':[cend]})
            bgctable=pd.concat([bgctable,df],ignore_index=True)

#one hot encode BGC types and make unique contig ID
bgccat = pd.get_dummies(bgctable['BGC category'])
bgccount = bgctable.join(bgccat)
bgccount['contigID'] = bgccount['sample'] + '_' + bgccount['contig']
contigID = bgccount.pop('contigID')
bgccount.insert(0, 'contigID', contigID)

bgctotal = bgccount.drop(['contig','BGC category','BGC product'],axis=1)

#oreo df for sum BGC types
list1 = list(bgctotal.columns)
list1.remove('sample')
list1.remove('contigID')

#sum by contig, sample
bgcsumcontig = bgctotal.groupby('contigID')[list1].sum(numeric_only=True)
bgcsumsample = bgctotal.groupby('sample')[list1].sum(numeric_only=True)

#save
file1=sample+'_bgc_long.tsv'
file2=sample+'_bgc_contigsum.tsv'
file3=sample+'_bgc_samplesum.tsv'
bgccount.to_csv(file1, sep="\t")
bgcsumcontig.to_csv(file2, sep="\t")
bgcsumsample.to_csv(file3, sep="\t")



