#!/usr/bin/env nextflow

process VERSE_CONCAT {

    label 'process_low'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir, mode: "copy"

    input:
    path exon_counts

    output:
    path "verse_counts_matrix.txt", emit: counts_matrix

    script:
    """
    verse_concat.py -i ${exon_counts.join(' ')} -o verse_counts_matrix.txt
    """
}