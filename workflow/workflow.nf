#!/usr/bin/env nextflow

params.inputspectra = ''
params.inputsequence = ''
params.workflowParameters = ''

params.type = ''

_spectra_ch = Channel.fromPath( params.inputspectra )
_sequence_ch = Channel.fromPath( params.inputsequence )

TOOL_FOLDER = "$baseDir/bin"
params.publishdir = "nf_output"

process geneToReaction {
    publishDir "$params.publishdir/geneToReaction", mode: 'copy'

    input:
    file spectrum_results from _spectra_ch
    file sequence_results from _sequence_ch

    output:
    file "gene_to_reaction" into _results_ch

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

process compound_to_reaction {
    publishDir "$params.publishdir/compound_to_reaction", mode: 'copy'

    input:
    file results_folder from _results_ch

    output:
    file "$results_folder" into _results_ch2

    """
    python $TOOL_FOLDER/magi/workflow/magi_workflow_compound_to_reaction.py \
        --not_first_script \
        --output $results_folder
    """
}

process reaction_to_gene {
    publishDir "$params.publishdir/reaction_to_gene", mode: 'copy'

    input:
    file results_folder from _results_ch2

    output:
    file "$results_folder" into _results_ch3

    """
    python $TOOL_FOLDER/magi/workflow/magi_workflow_reaction_to_gene.py \
        --not_first_script \
        --output $results_folder
    """
}

process workflowscoring {
    publishDir "$params.publishdir/workflowscoring", mode: 'copy'

    input:
    file results_folder from _results_ch3

    output:
    file "$results_folder" into _results_ch4

    """
    python $TOOL_FOLDER/magi/workflow/magi_workflow_scoring.py \
        --not_first_script \
        --output $results_folder
    """
}

// Formatting results
process format_results {
    publishDir "$params.publishdir/results", mode: 'copy'

    input:
    file results_folder from _results_ch4

    output:
    file "*tsv"

    """
    python $TOOL_FOLDER/reformat.py \
        $results_folder
    """

}