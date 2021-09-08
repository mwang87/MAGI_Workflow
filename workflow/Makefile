run_test_magi1:
	nextflow run workflow.nf \
		-resume \
		--inputspectra=../tests/metabolite_64.csv \
		--inputsequence=../tests/SG12_Paenibacillus_OAE614.txt

run_test_magi2:
	nextflow run workflow_magi2.nf \
		-resume \
		--inputspectra=./bin/magi/tests/full_workflow_test/random_smiles.csv \
		--inputsequence=./bin/magi/tests/full_workflow_test/s_coelicolor_genes_fasta_smallset.faa