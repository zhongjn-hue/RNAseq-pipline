#!/usr/bin/bash nextflow

process STAR_INDEX {

    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir, mode: "copy"

    input:
    path(genome)
    path(gtf)

    output:
    path "STAR_index", emit: index

    script:
    """
    mkdir -p STAR_index
    STAR \
        --runThreadN $task.cpus \
        --runMode genomeGenerate \
        --genomeDir STAR_index \
        --genomeFastaFiles $genome \
        --sjdbGTFfile $gtf 
    """

    
}