#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser(description="Extract Ensembl IDs and gene names from GTF.")
parser.add_argument("-i", "--input", help="Input GTF file", required=True)
parser.add_argument("-o", "--output", help="Output text file", required=True)
args = parser.parse_args()

seen = set()

with open(args.input, "r") as f, open(args.output, "w") as out:
    out.write("ensembl_id\tgene_name\n")
    for line in f:
        if line.startswith("#"):
            continue
        fields = line.strip().split("\t")
        if len(fields) < 9:
            continue
        if fields[2] != "gene":
            continue

        attributes = fields[8]
        gene_id = None
        gene_name = None
        for attr in attributes.strip().split(";"):
            attr = attr.strip()
            if attr.startswith("gene_id"):
                gene_id = attr.split('"')[1]
            elif attr.startswith("gene_name"):
                gene_name = attr.split('"')[1]

        if gene_id and gene_name and gene_id not in seen:
            out.write(f"{gene_id}\t{gene_name}\n")
            seen.add(gene_id)
