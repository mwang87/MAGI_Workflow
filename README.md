# MAGI 1 Setup

## Setup

```
conda create -n magi1 -f magi/magi_env.yml
conda install -n magi1 -c bioconda nextflow
cd magi 
python setup.py
```

### Getting BLAST

```
cd workflow/blastbin
wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.12.0/ncbi-blast-2.12.0+-x64-linux.tar.gz
tar -xzvf ncbi-blast-2.12.0+-x64-linux.tar.gz
cp ncbi-blast-2.12.0+/bin/blastp . 
cp ncbi-blast-2.12.0+/bin/makeblastdb .
```

### ProteoSAFe considerations

Even after deployment, there is a need to run setup.py

### Missing Files

graphml file is missing for magi 1, need to install after setup.py from Ben. 

# MAGI 2 Setup

## Setup

You need to run the BLAST setup for MAGI 1 to get MAGI 2 running. 

```
conda env create -n magi2 -f magi/magi_2_env.yml
python ./setup_magi2.py
```

We will need to update the path in the file "magi_2_user_settings.py" to this:

```
repo_location = r'magi'
```