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
    python $TOOL_FOLDER/template_script.py \
        "$spectra_folder" \
        "result_file.tsv"
    """
}