#!/usr/bin/env nextflow

params.inputspectra = ''
params.inputsequence = ''
params.workflowParameters = ''

params.type = ''

_spectra_ch = Channel.fromPath( params.inputspectra )
_sequence_ch = Channel.fromPath( params.inputsequence )

TOOL_FOLDER = "$baseDir/bin"
params.publishdir = "nf_output"

process calculateResults {
    publishDir "$params.publishdir", mode: 'copy'

    input:
    file spectrum_results from _spectra_ch
    file sequence_results from _sequence_ch

    output:
    file "result_file.tsv"

    """
    python $TOOL_FOLDER/magi/workflow/magi_workflow_gene_to_reaction.py \
        --fasta $sequence_results \
        --compounds $spectrum_results \
        --level 1 \
        --final_weights 1.0 1.0 1.0 1.0 \
        --blast_filter 85 \
        --reciprocal_closeness 75 \
        --chemnet_penalty 4.0 \
        --output gene_to_reaction --mute
    """
}