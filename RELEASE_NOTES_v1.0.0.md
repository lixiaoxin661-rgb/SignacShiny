# SignacShiny v1.0.0 — release notes draft

**Status: draft. v1.0.0 has not been tagged or published.** The source parity, data acquisition, and deployment checks below must be closed before publication.

## Software overview

SignacShiny is an R Shiny application for downstream analysis of processed single-cell ATAC-seq data. It uses Signac and Seurat and provides a browser interface for quality control, cell filtering, dimensionality reduction, clustering, differential analysis, gene activity, cell annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting.

## Major features and usage

The interface contains 12 analysis pages with manuscript-aligned descriptions and an original vector workflow figure. Import a processed dataset using the Custom Data inputs, or use the PBMC example after placing authorized, hash-verified example data in `data/`. Run the pages in workflow order and download results from the relevant plot and table panels. Initial alignment and peak calling are outside this application.

## System requirements and installation

The server snapshot lockfile records R 4.4.2 and Bioconductor 3.20. Package names and preliminary install commands are in `README.md`. The lockfile is a historical baseline and does not yet constitute a complete, independently verified restore recipe. The personal stage reportedly uses ggplot2 4.0.3, patchwork 1.3.2, TFBSTools 1.44.0, motifmatchr 1.28.0, DirichletMultinomial 1.48.0, and JASPAR2020 0.99.10; exact live package inventory and system library linkage remain to be captured. A complete release must state and verify the final runtime requirements.

## Example data requirements

The public source branch does not contain the 12 previously broken Git LFS payloads. The server has real files with recorded SHA-256 hashes, but the five processed PBMC/QC objects have no confirmed redistribution permission or verified public reconstruction route. `DATA_AUDIT.md`, `DATA_SHA256SUMS.txt`, and `data/README.md` identify the expected files and their current status. A source clone alone is not sufficient to run the bundled example. This is a release blocker until a lawful, tested data delivery route is available and documented.

## Verified functionality and known limitations

The personal staging instance loaded the 581-cell PBMC example; default filtering left 342 cells. QC, dimensionality reduction, clustering, gene activity, RNA differential analysis and CSV downloads, SingleR annotation, genomic region plotting, Motif Enrichment (One vs Rest), a motif sequence logo, and an ALX3 footprint curve with PNG download have browser evidence in `server_stage_browser_test_20261112.md`. The 633 displayed motif records are not 633 significant hits; visible adjusted p-values must be interpreted individually. GO enrichment returned a no-result warning in the tested example. Custom Data upload, Motif One vs One, and other unlisted parameter paths have not completed independent acceptance tests. The running personal-stage source has not yet been compared byte-for-byte with this branch, so these results cannot yet be attributed to a release commit.

The app retains elapsed-time and memory monitoring. Its current shared global variables present a potential multi-session isolation risk; behavior under concurrent users has not been validated. The formal Shiny Server account's dependency availability has not been verified.

## Citation, authorship, and license

Cite the SignacShiny repository and the exact release tag or commit used for analysis. See `README.md` for the listed authors. The source code is distributed under the repository's MIT `LICENSE`; this does not establish redistribution rights for external or processed data. A formal manuscript citation can be added after publication details are finalized.
