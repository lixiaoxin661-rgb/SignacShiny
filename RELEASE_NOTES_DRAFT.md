# SignacShiny v1.0.0 — release notes draft

**Status: not released.** Publish only after the runtime data and end-to-end Shiny checks listed below pass.

SignacShiny provides a graphical workflow for downstream analysis of processed scATAC-seq data. This candidate aligns the introductions and navigation across all 12 application pages with the manuscript, updates Help and About, and uses the original vector Figure 1 workflow in both the home page and README. It retains the server analysis code and its elapsed-time and optional memory reporting. It fixes the Cell Filtering `run_step()` call, the initial Cell Filtering plot tab selection, and the One vs One violin plot TIFF height input ID.

The repository includes the server snapshot's `renv.lock` as a dependency provenance record and documents known gaps in that lockfile. Invalid Git LFS pointer files have been removed. The server's 12 real data files passed SHA-256 checks, but this does not establish public GitHub delivery. An authorized private test clone can link the 11 files read by the code without copying them. The seven SingleR references have an experimental celldex preparation script; the processed PBMC example and QC caches still require a verified lawful acquisition or regeneration route.

Before publishing, verify real data retrieval and SHA-256 values from a fresh clone, the complete R dependency environment, all 12 pages and major analyses in an isolated Shiny instance, RNA assay differential analysis after gene activity creation, and result downloads. No performance benchmark results are claimed in this release draft.
