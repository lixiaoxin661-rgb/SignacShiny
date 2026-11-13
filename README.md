# SignacShiny

**An interactive web application for downstream analysis of single-cell chromatin accessibility data.**

SignacShiny brings a Signac- and Seurat-based scATAC-seq workflow into an R Shiny interface. Researchers can adjust parameters, explore results, and export figures and tables without writing R code during analysis. It accepts processed scATAC-seq data; read alignment and initial peak calling are performed before import.

## Online Application

The Shiny application is available at [https://xulabgdpu.cpolar.top/Signacshiny/](https://xulabgdpu.cpolar.top/Signacshiny/).

[Releases](https://github.com/lixiaoxin661-rgb/SignacShiny/releases) · [Installation](docs/INSTALLATION.md) · [Data requirements](data/README.md) · [Issues](https://github.com/lixiaoxin661-rgb/SignacShiny/issues)

## Workflow

![SignacShiny analysis workflow](www/workflow.svg)

## Features

- **Quality assessment and filtering:** inspect fragment counts, TSS enrichment, nucleosome signal, reads in peaks, and blacklist ratios; select cell-filtering thresholds.
- **Dimensionality reduction and clustering:** perform TF-IDF normalization and SVD/LSI, inspect depth correlations, and explore UMAP or t-SNE embeddings and graph-based clusters.
- **Differential analysis:** compare peaks or gene activity scores using one-versus-rest or pairwise cluster comparisons.
- **Biological interpretation:** calculate gene activity, annotate cell types with SingleR references, visualize genomic regions, and perform GO enrichment.
- **Regulatory analysis and export:** explore motif enrichment, sequence logos, and transcription factor footprints; export supported figures and result tables.

## Getting started

1. Download a [source release](https://github.com/lixiaoxin661-rgb/SignacShiny/releases), or clone the repository:

   ```bash
   git clone https://github.com/lixiaoxin661-rgb/SignacShiny.git
   ```

2. Follow the [installation guide](docs/INSTALLATION.md) to prepare R dependencies and required data.
3. Start the application from R:

   ```r
   shiny::runApp("/path/to/SignacShiny")
   ```

4. Choose **Example Data** when its local files are available, or **Custom Data** to upload a peak matrix, fragments file, matching `.tbi` index, and cell metadata. Select the appropriate reference annotation, then follow the modules from quality control to downstream analysis.

**Data are supplied separately.** Source releases do not bundle the processed PBMC example, cached QC plots, or SingleR reference objects. See [data requirements](data/README.md) before using these features. Downloading the source alone does not provide a complete analysis environment.

## Validation

An earlier source revision was run in an isolated personal server directory with R 4.4.2, existing dependencies, and verified local data. Example import, QC, filtering, TF-IDF, SVD, UMAP, and clustering completed; the example contained 581 cells before filtering and 342 afterward. This test did not cover every downstream module, custom upload, concurrent sessions, or installation in a clean environment.

## Authors

Siwen Xu — [siwxu@gdpu.edu.cn](mailto:siwxu@gdpu.edu.cn)

Li Xiaoxin — [2400507119@stu.gdpu.edu.cn](mailto:2400507119@stu.gdpu.edu.cn)

For software questions and reproducible bug reports, please [open an issue](https://github.com/lixiaoxin661-rgb/SignacShiny/issues).

## Citation

When using SignacShiny, cite this repository and the release version or commit used in your analysis. Also cite the underlying methods and packages used in your workflow. A publication citation will be added when available.

## License

SignacShiny is distributed under the [MIT License](LICENSE). Existing copyright notices and project history are retained.
