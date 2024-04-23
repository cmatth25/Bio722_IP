trim_qc.sh uses fastQC/multiQC before and after trimming by fastp

QC_Summary.ipynb inspects the QC results.

Ultimately, human read decontamination was abandoned, which is likely more important in host derived samples than eDNA samples. Human DNA may be contamination or may reflect how much humans come into contact with the environments the samples were taken from and may pose an interesting question.
Human reads were removed after classification instead of before, since the kraken db contains a humany library in the database and eukaryotic reads were filtered out.
