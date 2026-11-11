# SignacShiny 发布前界面逐页核对

依据：用户确认的 12 页 PPT、主任务文件、`change_audit.md` 及论文 `SignacShiny_FINALV2.docx` 的功能术语。核对的是源码文本；浏览器渲染及完整功能仍待服务器独立测试。

| PPT 页 | 模块 | 最终位置 | 文字逐字核对 | 论文功能 |
|---|---|---|---|---|
| 1 | Home | `ui.R:202` | 通过 | Home |
| 2 | Quality Control | `ui.R:260` | 通过 | Quality Control |
| 3 | Cell Filtering | `ui.R:333` | 通过 | Cell Filtering |
| 4 | Dimensionality Reduction & Clustering | `ui.R:407` | 通过 | Dimensionality Reduction & Clustering |
| 5 | One vs Rest | `ui.R:577` | 通过 | One vs Rest |
| 6 | One vs One | `ui.R:671` | 通过 | One vs One |
| 7 | Cell Type Annotation | `ui.R:521` | 通过 | Cell Type Annotation |
| 8 | Genomic Region Visualization | `ui.R:754` | 通过 | Genomic Region Visualization |
| 9 | GO Enrichment Analysis | `ui.R:1006` | 通过 | GO Enrichment Analysis |
| 10 | Motif Enrichment (One vs Rest) | `ui.R:813` | 通过 | Motif Enrichment (One vs Rest) |
| 11 | Motif Analysis (One vs One) | `ui.R:911` | 通过 | Motif Analysis (One vs One) |
| 12 | Transcription Factor Footprinting | `ui.R:1110` | 通过 | Transcription Factor Footprinting |

## 逐页最终英文

### 第 1 页最终英文

> SignacShiny is an interactive R Shiny application for downstream analysis of processed scATAC-seq data. Built on Signac and Seurat, it provides quality control, cell filtering, dimensionality reduction, clustering, differential accessibility and gene activity analysis, cell annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting in a graphical workflow. Users can adjust parameters and inspect results without writing R code. Alignment and initial peak calling are completed before import.


### 第 2 页最终英文

> After processed data are imported, the Quality Control module calculates fragment counts per cell, transcription start site (TSS) enrichment, nucleosome signal, fraction of reads in peaks, and blacklist region ratio. It summarizes data quality using a density scatter plot, a TSS enrichment profile, and a nucleosome banding plot. These views allow users to inspect the calculated metrics before setting cell-filtering thresholds in the next module.


### 第 3 页最终英文

> The Cell Filtering module displays the calculated quality-control metrics as interactive violin plots. Users can set thresholds for fragment counts, TSS enrichment, nucleosome signal, blacklist region ratio, and fraction of reads in peaks. Before applying the filters, they can inspect the resulting cell-retention statistics. Cells that meet the selected criteria are retained for dimensionality reduction and subsequent analyses.


### 第 4 页最终英文

> SignacShiny applies term frequency-inverse document frequency (TF-IDF) normalization followed by singular value decomposition (SVD) to obtain latent semantic indexing (LSI) components. A depth-correlation plot helps users select dimensions for downstream analysis. Selected components are used for UMAP or t-SNE visualization and graph-based clustering. Users can adjust the dimensions and clustering resolution through the interface. The module also calculates a gene activity matrix from accessibility signals associated with gene bodies and promoters for annotation and gene-level analyses.


### 第 5 页最终英文

> The One vs Rest module compares a selected cluster with all remaining cells to identify differentially accessible peaks or differences in gene activity scores. Users can select a supported statistical test and set a minimum detection frequency and fold-change threshold. The results table reports effect sizes, adjusted P-values, and detection fractions. Selected features can be examined in feature-level plots.


### 第 6 页最终英文

> The One vs One module compares two user-selected clusters for differential accessibility or differences in gene activity scores. Users can choose a supported statistical test and specify minimum detection frequency and fold-change thresholds. The results table presents effect sizes, adjusted P-values, and detection fractions. Selected peaks or gene activity features can then be inspected in violin or feature plots, depending on the assay used.


### 第 7 页最终英文

> SignacShiny uses SingleR to compare scATAC-seq-derived gene activity profiles with a selected transcriptomic reference. The module provides human and mouse reference datasets and returns predicted cell identities with annotation scores. Users can inspect these scores in a table and display predicted labels on a UMAP or t-SNE embedding. The labels provide a preliminary annotation that can be evaluated alongside cluster markers and the chosen reference.


### 第 8 页最终英文

> The Genomic Region Visualization module uses Signac CoveragePlot() to display chromatin accessibility across selected genes, peaks, or genomic coordinates. Accessibility signals from cells in the same cluster or annotated cell type are aggregated into pseudo-bulk tracks for comparison of locus-specific patterns. Gene annotations are overlaid on the tracks, and gene activity distributions can be shown alongside the regional accessibility profiles. Initial peak calling is completed upstream and is not performed in this module.


### 第 9 页最终英文

> The GO Analysis module uses clusterProfiler to assess Gene Ontology enrichment for genes associated with differentially accessible regions or differential gene activity. Users can select one-versus-rest or pairwise results and set significance thresholds. Enriched GO terms are summarized in a table and graphical outputs, including a bar plot. These results support functional interpretation of the selected gene set.


### 第 10 页最终英文

> This module uses JASPAR motif annotations to assess transcription factor motif enrichment among differentially accessible peaks from a one-versus-rest comparison. Candidate motifs are presented in a results table, and a sequence logo for a selected motif shows its nucleotide preferences. Motif enrichment supports exploratory interpretation of regulatory factors but does not establish transcription factor binding at an individual site.


### 第 11 页最终英文

> This module examines JASPAR transcription factor motifs in differentially accessible peaks identified between two selected clusters. It presents candidate motifs and allows users to inspect a sequence logo for a selected motif. The motif results are intended to support exploratory regulatory interpretation of the pairwise differential accessibility analysis; enrichment statistics and individual motif matches should be distinguished in the displayed table.


### 第 12 页最终英文

> The Transcription Factor Footprinting module examines putative transcription factor occupancy patterns using aggregated Tn5 insertion profiles around selected motif instances. Users can select motifs and cell populations of interest and compare normalized footprint profiles across groups. The plots provide evidence complementary to motif enrichment for interpreting candidate regulatory factors. A footprint is an accessibility-based pattern and does not directly measure transcription factor binding.

## 跨页核对

- 通过：首页与 README 同用 `www/workflow.svg`
- 通过：Genomic Region Visualization 取代可见 Calling Peak
- 通过：One vs Rest 与 One vs One 说明各自独立
- 通过：Help 与 About 页面存在
- 通过：旧仓库链接从可见 UI 消失
- 通过：旧品牌名从可见 UI 消失

## 仍需验证

- 服务器独立运行时逐页浏览器渲染，尤其检查首页 SVG 的完整显示和窄窗口布局。
- Gene Activity Matrix 创建后 RNA assay 的差异分析、图表和下载结果。
- 运行依赖及数据对象可用性；Git LFS 远端对象缺失是 Release 阻断项。
