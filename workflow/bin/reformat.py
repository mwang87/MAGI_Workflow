import argparse
import glob
import sys
import os
import pandas as pd

input_folder = sys.argv[1]

# Final Results
input_final_results_filename = os.path.join(input_folder, "magi_results.csv")
results_df = pd.read_csv(input_final_results_filename, sep=",")
results_df.to_csv("magi_results.tsv", sep="\t", index=False)

# Compound Results
input_final_results_filename = os.path.join(input_folder, "magi_compound_results.csv")
results_df = pd.read_csv(input_final_results_filename, sep=",")
results_df.to_csv("magi_compound_results.tsv", sep="\t", index=False)

# Gene Results
input_final_results_filename = os.path.join(input_folder, "magi_gene_results.csv")
results_df = pd.read_csv(input_final_results_filename, sep=",")
results_df.to_csv("magi_gene_results.tsv", sep="\t", index=False)