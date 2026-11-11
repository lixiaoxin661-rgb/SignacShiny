# SignacShiny
SignacShiny is an interactive R Shiny application for downstream analysis of processed scATAC-seq data. Built on Signac and Seurat, it supports quality control, cell filtering, dimensionality reduction, clustering, differential accessibility, gene activity, cell annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting. Alignment and initial peak calling are completed before import.

![SignacShiny workflow](www/workflow.svg)

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




### 2. Install Required R Packages & Run SignacShiny
+ **Manual Package Installation**    
  1.Open your R or RStudio environment.  
  2.Install the required packages:  
  
    ```r
    install.packages(c("bslib", "shiny", "shinyjs", "shinyBS", "shinyWidgets","shinybusy", "shinycssloaders", "shinydashboard", "shinydashboardPlus","ggplot2", "plotly", "patchwork", "cowplot", "dplyr", "purrr", "plyr","stringr", "sp", "Matrix", "ggseqlogo","matrixStats", "data.table", "DT", "irlba","systemfonts", "ggforce", "scatterpie"))  
  
    if (!requireNamespace("BiocManager", quietly = TRUE))
        install.packages("BiocManager")  
        
    BiocManager::install(c("MAST", "Seurat", "Signac", "SingleR", "SingleCellExperiment","ggseqlogo","BiocFileCache","AnnotationHub","BiocFileCache",
    "SummarizedExperiment", "Biobase", "MatrixGenerics","S4Vectors", "IRanges","GenomeInfoDb", "GenomicRanges","BiocGenerics","XVector", "Biostrings", "BiocIO", "rtracklayer", "BSgenome","BSgenome.Hsapiens.UCSC.hg19","GenomicFeatures", "AnnotationDbi", "AnnotationFilter", "ensembldb","EnsDb.Hsapiens.v75", "EnsDb.Hsapiens.v86", "EnsDb.Mmusculus.v79","org.Hs.eg.db", "GO.db","BSgenome.Hsapiens.UCSC.hg38","BSgenome.Hsapiens.NCBI.GRCH38", "BSgenome.Hsapiens.UCSC.hg19","BSgenome.Hsapiens.UCSC.mm10","HDO.db","clusterProfiler", "JASPAR2020"))
    ```
    ℹ️ A complete list of packages and versions can be found in the [sessionInfo](https://github.com/lixiaoxin661-rgb/SignacShiny/blob/main/sessionInfo) file.
    3.Run the application from the directory:
  
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
