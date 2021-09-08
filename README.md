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
wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.12.0+-x64-linux.tar.gz
tar -xzvf ncbi-blast-2.12.0+-x64-linux.tar.gz
cp ncbi-blast-2.12.0+/bin/blastp . 
cp ncbi-blast-2.12.0+/bin/makeblastdb .
```

### ProteoSAFe considerations

Even after deployment, there is a need to run setup.py