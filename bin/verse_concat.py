#!/usr/bin/env python3

import argparse
import pandas as pd
import os

parser = argparse.ArgumentParser(description="Concatenate VERSE exon count files into a single counts matrix.")
parser.add_argument("-i", "--input", nargs="+", help="Input VERSE exon count files", required=True)
parser.add_argument("-o", "--output", help="Output concatenated counts matrix file", required=True)
args = parser.parse_args()

dfs = []

for f in args.input:
    sample = os.path.basename(f).replace(".exon.txt", "")
    df = pd.read_csv(f, sep="\t", comment="#", header=None)
    if df.shape[1] < 2:
        continue
    df = df.iloc[:, [0, 1]]
    df.columns = ["gene_id", sample]
    dfs.append(df)

if not dfs:
    raise ValueError("No valid VERSE exon count files found.")

merged = dfs[0]
for df in dfs[1:]:
    merged = pd.merge(merged, df, on="gene_id", how="outer")

merged = merged.fillna(0)
merged.to_csv(args.output, sep="\t", index=False)