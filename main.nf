include {FASTQC} from './modules/fastqc'
include { GTF_EXTRACT } from './modules/gtf_extract'
include { STAR_INDEX } from './modules/star_index'
include { STAR_ALIGN } from './modules/star_align'
include { MULTIQC } from './modules/multiqc'
include { VERSE } from './modules/verse'
include { VERSE_CONCAT } from './modules/verse_concat'

workflow {

    // create input channel of paired-end reads
    Channel.fromFilePairs(params.reads)
    | set { align_ch }

    //Channel.fromFilePairs(params.reads).set { align_ch }

    // separate into single-reads for FASTQC
    fastqc_ch = align_ch
        .flatMap { sample_id, reads -> reads.collect { read -> tuple(sample_id, read)}}
        
    //Channel.fromFilePairs(params.reads).transpose().set{ fastqc_ch }

    FASTQC(fastqc_ch)

    // build STAR genome index
    GTF_EXTRACT(params.gtf)
    STAR_INDEX(params.genome, params.gtf)

    // run STAR_ALIGN with STAR_INDEX output
    STAR_ALIGN(align_ch, STAR_INDEX.out.index)

    // create a channel called multiqc_ch to create a single channel 
    // that contains a list with all of the output files from FASTQC 
    // and STAR logs for every sample
    multiqc_ch = FASTQC.out.zip
        .mix(STAR_ALIGN.out.log)
        .map { tuple -> tuple[1] } 
        .collect()
        .map { files -> files.flatten() }

    // call MULTIQC
    MULTIQC(multiqc_ch)

    // call verse
    VERSE(STAR_ALIGN.out.bam, params.gtf)

    // concatenate all VERSE outputs
    verse_concat_ch = VERSE.out.counts.map { it[1] }.collect()
    VERSE_CONCAT(verse_concat_ch)
}
