# Adaptive logistic regression via integrating gene mutation and RNA-seq for liver cancer diagnosis (ALRIGMR)
DATA/  
Liver-1.csv   - The first RNA-seq data for liver cancer  
Liver-2.txt   - The second RNA-seq data for liver cancer  
Mutation.txt   -The mutation data of liver cancer

The implementation of the codes requires the following four steps: (1) Data integration; (2)  lmQCM-based gene overlapping grouping; (3) Significance evaluation of genes and gene groups; (4) The ALRIGMR model. The corresponding files and comments are as follows:  

(1)This step is used to integrate RNA-seq and mutation data.  
R/Data_integration/DEG.R  -Implementation of algorithms for differential expression analysis  
R/Data_integration/DEG.csv  -Differential expression gene set for integrating mutation data

(2)This step is used to achieve overlapping grouping of genes.  
R/lmQCM.R  -lmQCM-based gene overlapping grouping

(3)This step is used to obtain the significance evaluation of genes and gene groups.  
R/Significance_evaluation_of_genes_and_gene_groups/ME.csv  -Module feature genes  
R/Significance_evaluation_of_genes_and_gene_groups/MI.csv  - Mutual information and conditional mutual information 
  
R/Significance_evaluation_of_genes_and_gene_groups/MU.csv  -Mutation rate of genes  
R/Significance_evaluation_of_genes_and_gene_groups/a.csv  -Media in algorithm implementation

(4)This step is used to build the ALRIGMR model.  
R/ALRIGMR/ALRIGMR.R  -Construction of ALRIGMR model  
R/ALRIGMR/data.csv  -Integrated data

The above contents can be communicated and discussed with corresponding authors.
