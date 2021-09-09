#!/usr/bin/env nextflow

params.inputspectra = ''
params.inputsequence = ''
params.workflowParameters = ''

params.type = ''

_spectra_ch = Channel.fromPath( params.inputspectra )
_sequence_ch = Channel.fromPath( params.inputsequence )

TOOL_FOLDER = "$baseDir/bin"
params.publishdir = "nf_output"

process compound_to_reaction {
    publishDir "$params.publishdir/geneToReaction", mode: 'copy'

    input:
    file spectrum_results from _spectra_ch
    file sequence_results from _sequence_ch

    output:
    file "compound_to_reaction" into _results_ch

    """
    python $TOOL_FOLDER/magi/workflow_2/compound_to_reaction.py \
        --compounds $spectrum_results \
        --fasta $sequence_results \
        --diameter 12 \
        --cpu_count 8 \
        --use_precomputed_reactions True \
        --output compound_to_reaction
    """
}

process gene_to_reaction {
    publishDir "$params.publishdir/gene_to_reaction", mode: 'copy'

    input:
    file results_folder from _results_ch

    output:
    file "$results_folder" into _results_ch2

    """
    python $TOOL_FOLDER/magi/workflow_2/gene_to_reaction.py \
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
    python $TOOL_FOLDER/magi/workflow_2/reaction_to_gene.py \
        --not_first_script \
        --output $results_folder
    """
}

process scoring {
    publishDir "$params.publishdir/scoring", mode: 'copy'

    input:
    file results_folder from _results_ch3

    output:
    file "$results_folder" into _results_ch4

    """
    python $TOOL_FOLDER/magi/workflow_2/scoring.py \
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