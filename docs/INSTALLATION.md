# Installation

Prepare the environment and data before launching SignacShiny. The server smoke test used R 4.4.2 and existing personal package libraries. A complete installation in a clean environment has not been validated. The recorded renv.lock is a dependency baseline, not a complete automatic restore recipe: JASPAR2020, the three EnsDb annotation packages, and some genome packages require separate attention.

This guide preserves the existing package list; availability of version-compatible dependencies must be checked for your R/Bioconductor release. See [runtime data requirements](../data/README.md) for the separate example and reference files. Local setup requires R/package installation even though subsequent analyses use a graphical interface.

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
Use R 4.4.2 and Bioconductor 3.20 when comparing with the server snapshot. The manual package commands below describe required packages but have not been validated as a complete installation in a clean environment. Check the [renv.lock](../renv.lock) baseline and the packages actually loaded by `global.R`, `ui.R`, and `server.R` before running the application. Do not treat a successful package installation as evidence that the missing runtime data are available.

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
    The separate reference preparation script additionally requires `celldex` and `digest`.

  3. After real data are present and verified, run the application from the project directory:
  
    ```r
    shiny::runApp("/path/to/SignacShiny-main")
    ```
  
