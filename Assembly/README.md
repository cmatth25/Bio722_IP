20000ContigFilter.sh and 5000ContigFilter.sh are initial attempts at filter. ContigFilter.sh accepts filter length arg.

Workflow is as follows:

1: AssembleMegahit.sh

2: Quast_noref.sh

3: n50Summary.sh

4: ContigCountAll.sh

5: ContigFilter.sh

6: ContigCountFiltered.sh
