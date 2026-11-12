# SignacShiny v1.0.0

SignacShiny is an R Shiny application for downstream analysis of processed single-cell ATAC-seq data. This source release includes the 12-page manuscript-aligned interface, the original vector workflow figure, and the tested analysis source.

## Features

The interface supports quality control, cell filtering, TF-IDF and SVD, dimensionality reduction and clustering, differential accessibility, gene activity analysis, SingleR annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting. Alignment and initial peak calling take place before import. Analysis methods and parameters are retained from the running server project.

## Runtime and installation

The tested personal server environment used R 4.4.2 with Signac 1.17.1, Seurat 5.2.1, SingleR 2.8.0, Shiny 1.10.0, TFBSTools 1.44.0, motifmatchr 1.28.0, JASPAR2020 0.99.10, and ggseqlogo 0.2.2 for the motif plot. See `README.md` and `RUNTIME_ENV_AUDIT.md` for the full dependency discussion. The included `renv.lock` records an older Shiny version and is not a fully verified restore recipe. After installing the required dependencies and placing authorized data at the documented paths, start the app with `shiny::runApp(".")` from the project root.

## Data requirements

The GitHub source archive does not contain the processed PBMC example, cached QC objects, or SingleR reference files. The former Git LFS pointers were unusable and have been removed. The running laboratory server has hash-verified private copies; this does not grant redistribution rights. Obtain the files through an authorized channel and check `DATA_SHA256SUMS.txt` before using the bundled example or reference-backed features. `README.md` and `DATA_AUDIT.md` list the paths and current availability. The separate celldex preparation script has not been validated as an exact replacement for the server files.

## Validation and limitations

The personal test environment ran the PBMC example (581 cells, 342 after default filtering), QC plots, TF-IDF, SVD/DepthCor, UMAP, clustering, Gene Activity Matrix, both RNA differential modes, SingleR annotation, genomic region plotting, One vs Rest motif analysis with a displayed sequence logo, and ALX3 footprinting. Selected CSV and PNG downloads were verified. The motif table's 633 records are not a claim of 633 significant hits. GO returned no enriched terms for the tested input. Custom Data upload, Motif One vs One, concurrent sessions, and all parameter paths have not completed full acceptance testing. The public Shiny Server environment must be checked separately after deployment.

## Authors, license, and citation

Current maintainer: Li Xiaoxin (2400507119@stu.gdpu.edu.cn; GitHub: lixiaoxin661-rgb). See `README.md` for original authors. Source code is provided under the repository's MIT license; data rights are separate. Cite the SignacShiny repository and this exact release tag or commit when reporting analyses.
