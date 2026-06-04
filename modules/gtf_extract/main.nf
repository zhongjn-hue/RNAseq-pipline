#!/usr/bin/env nextflow

process GTF_EXTRACT {

    label 'process_low'
    container 'ghcr.io/bf528/biopython:latest'
    publishDir params.outdir, mode: "copy"

    input:
    path gtf

    output:
    path "gene_map.txt", emit: gene_map

    script:
    """
    gtf_extract.py -i $gtf -o gene_map.txt
    """

}