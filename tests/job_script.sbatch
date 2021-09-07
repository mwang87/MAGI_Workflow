#!/bin/bash -l
#SBATCH -N 1
#SBATCH --exclusive
#SBATCH --error="/global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/log.err"
#SBATCH --output="/global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/log.out"
#SBATCH --qos=jgi_shared
#SBATCH -A pkscell
#SBATCH -C skylake
#SBATCH -t 8:00:00
#SBATCH -L project
#SBATCH --mail-user=bpbowen@lbl.gov
#SBATCH --mail-type=FAIL,TIME_LIMIT

source /global/common/software/m2650/python-cori/bin/activate
export HDF5_USE_FILE_LOCKING=FALSE

date -u > /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/start_time.txt

umask 002

python /project/projectdirs/metatlas/projects/metatlas_reactions/workflow/helpertools/nersc_memmonitor.py > /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/memory.txt &

magi_path=/global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/magi

python $magi_path/workflow/magi_workflow_gene_to_reaction.py \
--fasta /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/SG12_Paenibacillus_OAE614.txt \
--compounds /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/metabolite_64.csv \
--level 1 \
--final_weights 1.0 1.0 1.0 1.0 \
--blast_filter 85 \
--reciprocal_closeness 75 \
--chemnet_penalty 4.0 \
--output /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614 --mute

if [ $? -eq 0 ] && [ ! -f /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete ]; then
  python $magi_path/workflow/magi_workflow_compound_to_reaction.py --not_first_script --output /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614
else touch /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete; fi
if [ $? -eq 0 ] && [ ! -f /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete ]; then
  python $magi_path/workflow/magi_workflow_reaction_to_gene.py --not_first_script --output /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614
else touch /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete; fi
  if [ $? -eq 0 ] && [ ! -f /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete ]; then
python $magi_path/workflow/magi_workflow_scoring.py --not_first_script --output /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614
  else touch /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete; fi
if [ $? -eq 0 ] && [ ! -f /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete ]; then
  date -u > /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/end_time.txt
else touch /global/cfs/cdirs/metatlas/projects/custom_magitasks/custom_magijobs/SG12_Paenibacillus_OAE614/admin/incomplete; fi
