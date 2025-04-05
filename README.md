# ONT DNA Methylation Analysis – Blowfly Epigenomics

This repository contains a Snakemake-based pipeline for detecting and analysing **5-methylcytosine (5mC)** patterns using **Oxford Nanopore Technologies (ONT)** data from *Calliphora stygia* and *Calliphora hilli* blowfly populations. The goal is to compare methylation profiles between native and invasive populations, as part of a broader investigation into the genomic and epigenomic drivers of biological invasion success.

---

## Directory Structure

```bash
project/
├── data/                # Raw and preprocessed ONT reads (linked, not stored)
├── results/             # All outputs: BAMs, methylation calls, plots, stats
├── workflow/            # Snakemake rules and scripts
├── config/              # Config files for pipeline control
├── envs/                # Conda environments per tool
├── logs/                # Log files for debugging and transparency
├── notebooks/           # Jupyter/RMarkdown for exploratory analysis
├── Snakefile            # Entrypoint for the workflow
└── README.md            # This file
```

# Workflow

Step                        | Tool                      | Description
---------------------------|---------------------------|-----------------------------------------------
Quality Control             | NanoPlot, pycoQC          | ONT-specific read quality summaries
Read Alignment              | minimap2                  | Fast, long-read aligner with -ax map-ont preset
Indexing                    | samtools, megalodon       | Required for downstream methylation calls
Methylation Calling         | megalodon + remora        | Signal-level 5mC calling, state-of-the-art
Conversion to bedMethyl     | modbam2bed, megalodon_extras | Format for downstream stats/visualisation
Statistical Analysis        | R (bsseq, DSS), MethCP    | Differential methylation between groups
Visualisation               | methylartist, IGV, R      | Heatmaps, genome browser tracks, violin plots

~under development