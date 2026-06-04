# RNAseq Nextflow Pipeline

The following README contains directions on how to run the RNAseq Nextflow pipeline.  

Our final project is based on [Chandra et al. 2022](https://doi.org/10.1038/s41467-022-34069-z),
which is focused on tyrosine kinase 2 (TYK2) knockout during pancreatic cell differentiation via RNAseq. In this project, we specifically reproduce the RNA-Sequencing and Differential Expression Sequencing analysis techniques in S5 of the reference publication, examine significant genes and pathways, and compare results to the original publication.  

This repository consists of the following files:  

| File(s) | Path | Description |
| :------- | :------ | :------- |
| Nextflow Pipeline     | `main.nf` | Consists of a full Nextflow pipeline that processes the RNAseq data from Chandra et al. 2022.    |
| RMarkdown Analysis  | `project02_analysis.Rmd`   | Consists of an RMarkdown report that runs analyses on our RNAseq data.   |
| RMarkdown Analysis HTML | `project02_analysis.html` | Consists of our RNAseq report in `.html` format. |
| RMarkdown Analysis PDF | `project02_analysis.pdf` | Consists of our RNAseq report in `.pdf` format. |
| GTF Parser | `bin/gtf_extract.py` | Consists of a Python script that extracts Ensembl IDs and gene names from our GTF file. |
| VERSE Concatenator | `bin/verse_concat.py` | Consists of a Python script that concatenates VERSE exon count files into a single counts matrix. |
| Nextflow Modules | `modules/` | Consists of all Nextflow modules and their `main.nf` files used to run the pipeline. |
| Nextflow Configuration | `nextflow.config` | Consists of all parameters and settings used to run the Nextflow pipeline. |  
| Significant Upregulated Genes List | `upreg_sig_genes.txt` | Consists of a list of all significant upregulated genes from our RMarkdown analysis. |
| Significant Downregulated Genes List | `downreg_sig_genes.txt` | Consists of a list of all significant downregulated genes from our RMarkdown analysis. |
| C2 Canonical Pathways | `c2.cp.v2025.1.Hs.symbols.gmt` | Consists of a gene set file from GSEA MSIGDB used for FGSEA analysis. |

Steps to successfully run the pipeline:
1. To run the Nextflow pipeline, please run the command:
```
nextflow run main.nf -profile singularity,local
```
2. Run the R Diffbind analysis.  

Feel free to change any file paths if necessary.
