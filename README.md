# SignacShiny
SignacShiny is an interactive R Shiny application for downstream analysis of processed scATAC-seq data. Built on Signac and Seurat, it supports quality control, cell filtering, dimensionality reduction, clustering, differential accessibility, gene activity, cell annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting. Alignment and initial peak calling are completed before import.

![SignacShiny workflow](www/workflow.svg)

## Data and reproducibility status

The application imports processed scATAC-seq inputs. The server code also reads local files under `data/` for the bundled PBMC example, cached quality-control plots, and SingleR reference datasets. The expected relative paths and SHA-256 hashes are in [DATA_SHA256SUMS.txt](DATA_SHA256SUMS.txt). Place verified files at those exact paths before using the corresponding example or reference feature. A Git LFS pointer is not the data file.

**Server data:** The owner rehashed all 12 real files in `/srv/shiny-server/Signacshiny/data/`; they exist and match the server SHA-256 manifest. This establishes the server's private test inputs, not public GitHub availability. An authorized test clone on that server can use [scripts/link_server_test_data.sh](scripts/link_server_test_data.sh) to link only the 11 files read by the application and verify their hashes without copying or changing the formal data.

**GitHub data delivery:** This is a source-code release; it does **not** include the bundled PBMC example, cached QC objects, or SingleR reference files. An authenticated GitHub LFS download check returned 404 for all 12 previously tracked objects, so the unusable pointer files were removed. Five of those pointers also identified versions different from the server manifest; this does not imply the server files are wrong. See the [file-by-file data audit](DATA_AUDIT.md) and [runtime data directory](data/README.md). A source clone alone cannot run the bundled example or reference-backed features. Obtain the required files from the project maintainers for authorized use and verify their hashes before running those features. Redistribution permissions for the processed PBMC/QC files remain unconfirmed.

The seven SingleR reference datasets have [public celldex getters](https://bioconductor.org/packages/release/data/experiment/html/celldex.html). In an isolated test environment with `celldex` and `digest` installed, run `Rscript --vanilla scripts/prepare_celldex_references.R /path/to/stage/data` to create files with the object names and `label.fine` fields expected by `server.R`. An optional second argument, such as `NovershternHematopoietic`, prepares only that reference for a small first test. The script refuses to overwrite existing files and prints the SHA-256 of each generated file. **This route has not yet been executed against the server's R environment or shown to produce the server manifest hashes; it is not yet a validated replacement for those exact files.** Regenerated files may have different hashes from the server's serialized originals; record their own hashes and verify their SingleR behavior before distribution. Keep the processed PBMC and QC objects private until their provenance and distribution rights are confirmed.

For a user-supplied processed dataset, upload the peak matrix, fragments file and its `.tbi` index, and cell metadata through the application. The UI provides direct download links for the 10x Genomics PBMC 500 Next GEM example, including its [fragments file](https://cf.10xgenomics.com/samples/cell-atac/1.1.0/atac_pbmc_500_nextgem/atac_pbmc_500_nextgem_fragments.tsv.gz) and [index](https://cf.10xgenomics.com/samples/cell-atac/1.1.0/atac_pbmc_500_nextgem/atac_pbmc_500_nextgem_fragments.tsv.gz.tbi); verify the source terms before redistributing its files. The server manifest lists an optional copy under `data/zc/1/`, but the application does not reference that fixed directory. After obtaining authorized data, verify them from the project root with `sha256sum -c DATA_SHA256SUMS.txt` on Linux, or compare each file with `Get-FileHash -Algorithm SHA256` on Windows. Missing optional entries must be identified separately when checking only the files needed for a chosen workflow.

The committed [renv.lock](renv.lock) is an unchanged copy of the server snapshot. It records R 4.4.2, Bioconductor 3.20, Shiny 1.11.1, Signac 1.17.1, Seurat 5.2.1, and SingleR 2.8.0. These are lockfile records, not a live inventory of the server; see the [server runtime environment audit](RUNTIME_ENV_AUDIT.md). The lockfile omits `JASPAR2020` and the three `EnsDb.*` packages loaded at startup, and some genome packages selected later. It is therefore a provenance baseline, not yet a complete, tested restore recipe. The public source does not auto-activate renv or include the server's private package library. Runtime profiling uses `lobstr` when available and continues without memory figures when it is absent.

## Local Installation (Optional)

### 1. Download SignacShiny Source Code
You can obtain the source code in either of the following ways:
  + Clone the GitHub repository:
    ```bash
    git clone https://github.com/lixiaoxin661-rgb/SignacShiny.git
    ```
    Or

   + Download the ZIP file from: https://github.com/lixiaoxin661-rgb/SignacShiny
      The downloaded folder should be named SignacShiny-main.




### 2. Review dependencies and run SignacShiny
Use R 4.4.2 and Bioconductor 3.20 when comparing with the server snapshot. The manual package commands below describe required packages but have not been validated as a complete installation in a clean environment. Check the [renv.lock](renv.lock) baseline and the packages actually loaded by `global.R`, `ui.R`, and `server.R` before running the application. Do not treat a successful package installation as evidence that the missing runtime data are available.

+ **Manual package list for an isolated test environment**

  1. Open R or RStudio in the test environment.
  2. Install the packages for the chosen R/Bioconductor release:
  
    ```r
    install.packages(c("bslib", "shiny", "shinyjs", "shinyBS", "shinyWidgets","shinybusy", "shinycssloaders", "shinydashboard", "shinydashboardPlus","ggplot2", "plotly", "patchwork", "cowplot", "dplyr", "purrr", "plyr","stringr", "sp", "Matrix", "ggseqlogo","matrixStats", "data.table", "DT", "irlba","systemfonts", "ggforce", "scatterpie"))  
  
    if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")  
        
    BiocManager::install(c("MAST", "Seurat", "Signac", "SingleR", "SingleCellExperiment", "BiocFileCache", "AnnotationHub",
    "SummarizedExperiment", "Biobase", "MatrixGenerics", "S4Vectors", "IRanges", "GenomeInfoDb", "GenomicRanges", "BiocGenerics", "XVector", "Biostrings", "BiocIO", "rtracklayer", "BSgenome", "BSgenome.Hsapiens.UCSC.hg19", "GenomicFeatures", "AnnotationDbi", "AnnotationFilter", "ensembldb", "EnsDb.Hsapiens.v75", "EnsDb.Hsapiens.v86", "EnsDb.Mmusculus.v79", "org.Hs.eg.db", "org.Mm.eg.db", "GO.db", "BSgenome.Hsapiens.UCSC.hg38", "BSgenome.Hsapiens.NCBI.GRCh38", "BSgenome.Mmusculus.UCSC.mm10", "HDO.db", "clusterProfiler", "JASPAR2020", "TFBSTools", "motifmatchr"))
    ```
    The [sessionInfo](sessionInfo) file is an older Windows R 4.3.1 session, not the current server environment. The separate reference preparation script additionally requires `celldex` and `digest`.

  3. After real data are present and verified, run the application from the project directory:
  
    ```r
    shiny::runApp("/path/to/SignacShiny-main")
    ```
  
## Authors
Please do not hesitate to post an issue or contact the authors :

Siwen Xu: siwxu@gdpu.edu.cn

Yuyan Luo : 1620218029@qq.com

## Version and citation

The source repository is https://github.com/lixiaoxin661-rgb/SignacShiny. Cite the repository and the version or commit used in your analysis. A formal publication citation will be added when available.

## License

This project is distributed under the terms in [LICENSE](LICENSE).
