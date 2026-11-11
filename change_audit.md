# SignacShiny 修改审计

来源：参考 PPT 右侧文字及 `Codex_完整修改任务.md`。旧行号基于 `HEAD:ui.R`，新行号基于当前工作分支。以下原文是源码字符串片段，保留原始拼接形式。

## PPT 01 Home

- 原位置：`ui.R:203-211`；新位置：`ui.R:202`。
- 原内容：

```r
                div(class="my-custom-div",
                    strong("Signac.UIO"),
                    ", an interactive R Shiny application for the",
                    code("comprehensive analysis and visualization of single-cell chromatin accessibility data"),
                    "Leveraging the power of Signac, which integrates seamlessly with the Seurat package for single-cell RNA-seq analysis, Signac.UIO offers",
                    code("a user-friendly platform for conducting end-to-end scATAC-seq data analysis"),
                    ". The application supports",
                    code("quality control, cell filtering, dimensionality reduction, clustering, DNA motif analysis, transcription factor footprinting, and interactive data visualization"),
                    "."
```

- 新内容："SignacShiny is an interactive R Shiny application for downstream analysis of processed scATAC-seq data. Built on Signac and Seurat, it provides quality control, cell filtering, dimensionality reduction, clustering, differential accessibility and gene activity analysis, cell annotation, genomic region visualization, GO enrichment, motif analysis, and transcription factor footprinting in a graphical workflow. Users can adjust parameters and inspect results without writing R code. Alignment and initial peak calling are completed before import."

## PPT 02 Quality Control

- 原位置：`ui.R:269-279`；新位置：`ui.R:260`。
- 原内容：

```r
              "The",
              strong("Quality Control Module"),
              "is designed to provide a ",
              code("comprehensive overview of data quality and facilitate the identification of high-quality cells for downstream analysis"),
              ". Once the required input files are successfully uploaded, users can click the “Quality Control” button, Signac.UIO automatically calculates a series of key quality control metrics and generate corresponding visualizations, including a ",
              code("density scatter plot"),
              "of fragment counts versus TSS enrichment, a",
              code("TSS enrichment curve"),
              ", and a",
              code("nucleosome signal plot"),
              "."
```

- 新内容："After processed data are imported, the Quality Control module calculates fragment counts per cell, transcription start site (TSS) enrichment, nucleosome signal, fraction of reads in peaks, and blacklist region ratio. It summarizes data quality using a density scatter plot, a TSS enrichment profile, and a nucleosome banding plot. These views allow users to inspect the calculated metrics before setting cell-filtering thresholds in the next module."

## PPT 03 Cell Filtering

- 原位置：`ui.R:352-358`；新位置：`ui.R:333`。
- 原内容：

```r
                           "The",
                           strong("Cell Filtration Module"),
                           "is designed to allow users to",
                           code("filter out low-quality cells based on key quality control metrics, ensuring that only high-confidence single cells are included in downstream analyses."),
                           "Signac.UIO supports adjusting various filtering thresholds, including",
                           code("the minimum and maximum number of fragments per cell, TSS enrichment score, nucleosome signal, maximum blacklist ratio, and minimum percentage of reads in peaks"),
                           ". After selecting the appropriate thresholds, users clicking the “Cell Filtering” button, they can visualize the distribution of these metrics through interactive plots, enabling them to make data-driven decisions about the optimal filtering parameters."
```

- 新内容："The Cell Filtering module displays the calculated quality-control metrics as interactive violin plots. Users can set thresholds for fragment counts, TSS enrichment, nucleosome signal, blacklist region ratio, and fraction of reads in peaks. Before applying the filters, they can inspect the resulting cell-retention statistics. Cells that meet the selected criteria are retained for dimensionality reduction and subsequent analyses."

## PPT 04 Dimensionality Reduction and Clustering

- 原位置：`ui.R:432-436`；新位置：`ui.R:407`。
- 原内容：

```r
                                  "The",
                                  strong("Dim Reduction and Clustering Module"),
                                  "provides a comprehensive suite of tools for",
                                  code("reducing the dimensionality of single-cell chromatin accessibility data and identifying distinct cell populations"),
                                  ". Users clicking the “Normalization” button, Signac.UIO first performs TF-IDF to transform the high-dimensional peak-by-cell matrix into a lower-dimensional feature space. The number of significant dimensions can be determined by inspecting the DepthCorplot. After adjusting relevant parameters and clicking the “Linear Dimensional Reduction” button, Signac.UIO can perform feature selection and linear dimensionality reduction. After selecting the appropriate number of dimensions, Signac.UIO further applies nonlinear dimensionality reduction methods(UMAP/t-SNE) for data visualization. Once dimensionality reduction is complete, the platform supports multiple clustering algorithms(SLM Algorithm/Original Louvain/Louvain Algorithm with Multilevel Refinement). Users can adjust key clustering parameters (e.g., resolution) and then click the “Clustering” button to perform the clustering analysis and generate DimPlot. Additionally, the module includes a Create Gene Activity Matrix function, leveraging the gene activity scoring approach provided by the Signac package."
```

- 新内容："SignacShiny applies term frequency-inverse document frequency (TF-IDF) normalization followed by singular value decomposition (SVD) to obtain latent semantic indexing (LSI) components. A depth-correlation plot helps users select dimensions for downstream analysis. Selected components are used for UMAP or t-SNE visualization and graph-based clustering. Users can adjust the dimensions and clustering resolution through the interface. The module also calculates a gene activity matrix from accessibility signals associated with gene bodies and promoters for annotation and gene-level analyses."

## PPT 05 One vs Rest

- 原位置：`ui.R:610-618`；新位置：`ui.R:577`。
- 原内容：

```r
                                                      "The",
                                                      strong("One vs Rest sub-module"),
                                                      "is designed to ",
                                                      code("identify marker peaks or genes uniquely enriched in a specific cluster compared to all other clusters"),
                                                      ". Users can select statistical methods",
                                                      strong("(Wilcox/LR/bimod/ROC/MAST)"),
                                                      "and set key parameters like",
                                                      strong("minimum detection rate and fold change threshold"),
                                                      ". After setting the parameters and clicking the button, the platform automatically performs differential analysis and presents the results in an interactive table, including key statistics such as fold change, adjusted p-value, and the proportion of cells in each cluster. Additionally, the module can generate feature plots."
```

- 新内容："The One vs Rest module compares a selected cluster with all remaining cells to identify differentially accessible peaks or differences in gene activity scores. Users can select a supported statistical test and set a minimum detection frequency and fold-change threshold. The results table reports effect sizes, adjusted P-values, and detection fractions. Selected features can be examined in feature-level plots."

## PPT 06 One vs One

- 原位置：`ui.R:712-720`；新位置：`ui.R:671`。
- 原内容：

```r
                                                    "The",
                                                    strong("One vs One sub-module"),
                                                    "is designed to ",
                                                    code("identify differentially accessible peaks or differentially active genes between two selected clusters"),
                                                    ". Users can select statistical method",
                                                    strong("(Wilcox/LR/bimod/ROC/MAST)"),
                                                    "and set key arguments like",
                                                    strong("minimum detection rate and fold change threshold"),
                                                    ". After setting the parameters and clicking the button, the platform automatically performs differential analysis and presents the results in an interactive table, including key statistics such as fold change, adjusted p-value, and the proportion of cells in each cluster.Users can also select specific peaks from the table, with the panel simultaneously displaying violin plots and feature plots of gene expression or chromatin accessibility related to the selected peak."
```

- 新内容："The One vs One module compares two user-selected clusters for differential accessibility or differences in gene activity scores. Users can choose a supported statistical test and specify minimum detection frequency and fold-change thresholds. The results table presents effect sizes, adjusted P-values, and detection fractions. Selected peaks or gene activity features can then be inspected in violin or feature plots, depending on the assay used."

## PPT 07 Cell Type Annotation

- 原位置：`ui.R:550-554`；新位置：`ui.R:521`。
- 原内容：

```r
                                  "The",
                                  strong("Cell Annotation Module"),
                                  "assigns",
                                  code("biological identities to the identified cell clusters"),
                                  ". Signac.UIO includes built-in human and mouse reference datasets from the SingleR package. After selecting the appropriate dataset, users click the “Cell Annotation” button, and the platform automatically calculates cell type probabilities for each cluster based on the gene activity matrix. Results are displayed as annotation tables and labeled clustering plots, providing a clear overview of cell type distributions."
```

- 新内容："SignacShiny uses SingleR to compare scATAC-seq-derived gene activity profiles with a selected transcriptomic reference. The module provides human and mouse reference datasets and returns predicted cell identities with annotation scores. Users can inspect these scores in a table and display predicted labels on a UMAP or t-SNE embedding. The labels provide a preliminary annotation that can be evaluated alongside cluster markers and the chosen reference."

## PPT 08 Genomic Region Visualization

- 原位置：`ui.R:803-809`；新位置：`ui.R:754`。
- 原内容：

```r
                           "The",
                           strong("Peaks Visualization Module"),
                           "enables users to",
                           code("visualize chromatin accessibility tracks for specific genomic regions, providing insights into the regulatory landscape of single-cell ATAC-seq data"),
                           ". Users can customize the genomic regions that they wish to visualize by specifying their regions of interest as individual peaks or genes and adjusting the display range accordingly.When users click the “Genomic Regions plot” button, Signac.UIO generates ",
                           strong("the pseudo-bulk accessibility tracks"),
                           "along with violin plots showing the expression levels of genes present within the selected genomic region."
```

- 新内容："The Genomic Region Visualization module uses Signac CoveragePlot() to display chromatin accessibility across selected genes, peaks, or genomic coordinates. Accessibility signals from cells in the same cluster or annotated cell type are aggregated into pseudo-bulk tracks for comparison of locus-specific patterns. Gene annotations are overlaid on the tracks, and gene activity distributions can be shown alongside the regional accessibility profiles. Initial peak calling is completed upstream and is not performed in this module."

## PPT 09 GO Enrichment Analysis

- 原位置：`ui.R:1068-1076`；新位置：`ui.R:1006`。
- 原内容：

```r
                         "The",
                         strong("Pathway Enrichment Module"),
                         " enables users to ",
                         code("perform Gene Ontology (GO) enrichment analysis based on the results of differential accessibility peaks or differentially active genes, with the goal of identifying biological pathways enriched in specific cell types"),
                         ". Users can adjust relevant thresholds (such as p-value and q-value) and then click the “GO analysis” button. The platform will execute the GO enrichment analysis, with results presented as a ",
                         strong("GO enrichment table and GO bar plot"),
                         ".To accommodate different experimental designs, ",
                         strong("the module supports both “One vs Rest” and “One vs One” comparison modes"),
                         ", corresponding to the settings used in the Differential Peaks/Genes Module."
```

- 新内容："The GO Analysis module uses clusterProfiler to assess Gene Ontology enrichment for genes associated with differentially accessible regions or differential gene activity. Users can select one-versus-rest or pairwise results and set significance thresholds. Enriched GO terms are summarized in a table and graphical outputs, including a bar plot. These results support functional interpretation of the selected gene set."

## PPT 10 Motif Enrichment (One vs Rest)

- 原位置：`ui.R:868-871`；新位置：`ui.R:813`。
- 原内容：

```r
                           strong("The Motif All Table sub-module"),
                           "enables users to ",
                           code("identify transcription factor (TF) binding motifs that are specifically enriched in differentially accessible regions across cell clusters, providing insights into the upstream regulatory mechanisms that drive chromatin accessibility differences"),
                           ", which corresponds to the “One vs Rest Cluster” analysis. By clicking on “Motif Aalysis” button, users can view the location and binding score information of each enriched TFBS of this DNA region from the Motif Scanning Table. Once users select one TFBS of this table, the corresponding sequence logo will appear in the Sequence-logo Plot panel."
```

- 新内容："This module uses JASPAR motif annotations to assess transcription factor motif enrichment among differentially accessible peaks from a one-versus-rest comparison. Candidate motifs are presented in a results table, and a sequence logo for a selected motif shows its nucleotide preferences. Motif enrichment supports exploratory interpretation of regulatory factors but does not establish transcription factor binding at an individual site."

## PPT 11 Motif Analysis (One vs One)

- 原位置：`ui.R:969-973`；新位置：`ui.R:911`。
- 原内容：

```r
                           "The",
                           strong("Motif Idents Table sub-module"),
                           "enables users to ",
                           code("identify transcription factor (TF) binding motifs that are specifically enriched in differentially accessible regions between two selected cell clusters, providing insights into the upstream regulatory mechanisms that drive chromatin accessibility differences"),
                           ", which corresponds to the “One vs One Cluster” analysis. By clicking on “Motif Idents Analysis” button, users can view the location and binding score information of each enriched TFBS of this DNA region from the Motif Scanning Table. Once users select one TFBS of this table, the corresponding sequence logo will appear in the Sequence-logo Plot panel."
```

- 新内容："This module examines JASPAR transcription factor motifs in differentially accessible peaks identified between two selected clusters. It presents candidate motifs and allows users to inspect a sequence logo for a selected motif. The motif results are intended to support exploratory regulatory interpretation of the pairwise differential accessibility analysis; enrichment statistics and individual motif matches should be distinguished in the displayed table."

## PPT 12 Transcription Factor Footprinting

- 原位置：`ui.R:1180-1184`；新位置：`ui.R:1110`。
- 原内容：

```r
                           "The",
                           strong("TF Footprinting Module"),
                           "builds",
                           code("upon motif enrichment results to further assess transcription factor (TF) binding activity across different cell populations"),
                           ". Users can select motifs of interest, and then click the “FootPringting analysis” button. The platform will compute and visualize Tn5 insertion patterns around specific motif regions and compare footprint profiles across clusters or cell types. By integrating sequence-level motif information with chromatin accessibility signals, this module offers a fine-grained view of transcriptional regulation within single-cell ATAC-seq data."
```

- 新内容："The Transcription Factor Footprinting module examines putative transcription factor occupancy patterns using aggregated Tn5 insertion profiles around selected motif instances. Users can select motifs and cell populations of interest and compare normalized footprint profiles across groups. The plots provide evidence complementary to motif enrichment for interpreting candidate regulatory factors. A footprint is an accessibility-based pattern and does not directly measure transcription factor binding."

## 其他修改与验证

- 首页工作图：`ui.R` 引用 `www/workflow.svg`；附件 SVG 原样复制，增加响应式显示及点击打开原图。
- 导航菜单、状态卡片、品牌标题、About 仓库链接与 README 术语同步。内部 tabName、inputId、outputId 和计算逻辑未改。
- `git diff --check`：通过。
- R 语法：使用 `D:\R-4.6.1\bin\Rscript.exe` 对 `app.R`、`ui.R`、`server.R`、`global.R` 逐一执行 `parse(file=...)`，四项均通过。R 启动出现区域设置警告，解析退出码为 0。
- Shiny 功能：本机缺少 `shinydashboard`、`Signac`、`Seurat`、`SingleR` 等运行依赖，未能启动应用；页面、图表与下载功能未验证。正式发布门槛未满足。
- 差异分析界面初始仅显示 `peaks`。运行 Gene Activity Matrix 后，`server.R:879-918` 创建并标准化 `RNA` assay，并更新两个 assay 控件；One vs Rest 的 `server.R:1006-1009` 与 One vs One 的 `server.R:1221-1224` 均有 RNA 分支。静态代码路径成立，实际运行尚未验证。

## 发布前未解决事项

- 已定位并运行本机 `Rscript`，四个源文件语法通过。运行依赖不足，Shiny 功能测试尚未执行；不得据此合并 main 或创建正式 Release。
- 两个差异分析 assay 控件初始仅提供 `peaks`；生成 gene activity matrix 后会动态加入 `RNA`。该路径是否能成功运行和正确展示，仍需在目标 R 环境中验证。
- `server.R` 两种 motif 模式均调用 Signac `FindMotifs()`，不是仅做 motif matching；实际表格列及统计解释仍需运行后核对。
- 旧 PNG 品牌图仍留在 `www/` 供历史追溯，但 `ui.R` 的可见页眉、页脚均已改为 SignacShiny 文字，不再引用这些旧图。
- SVG 附件与仓库替换件 SHA-256 完全一致：`CDECDA452925CF460318BFE590BB4C6F427BC13EBADD3B03CFA46A1C75EE79D6`；viewBox 为 `0 0 1000 1352.941176`。
