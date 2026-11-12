# Personal server stage browser test — 2026-11-12

Test target: the owner's forwarded personal Shiny instance at `http://127.0.0.1:3846/`, not the formal public website. The stage source is under `/users/xiaoxli/SignacShiny-stage/SignacShiny-chore-manuscript-ui-release`. Its source files and commit have not yet been matched byte-for-byte against this Git branch, so the following results apply to the **running stage**, not automatically to a future GitHub Release.

| Function | Result | Direct observation |
|---|---|---|
| All 12 page introductions, navigation, Help and About | PASS for visible text | Browser displayed the distinct formal introductions for Home, QC, Filtering, DR/Clustering, both differential modes, Annotation, Genomic Region Visualization, GO, both Motif modes, and Footprinting. Help and About linked the correct repository. |
| Figure 1 workflow | PASS for bytes and display | `GET /workflow.svg` returned 1,757,697 bytes; SHA-256 `cdecda452925cf460318bfe590bb4c6f427bc13ebadd3b03cfa46a1c75ee79d6`, matching the supplied original. Visible on Home. At a narrow browser viewport it requires horizontal scrolling; desktop layout remains to be inspected. |
| Example PBMC import | PASS | Clicked Start with Example Data; completion dialog displayed and count was 581 cells. |
| Quality Control | PASS for example | Clicked QC; density scatter, TSS and fragment plots rendered. The fragment plot download returned HTTP 200 and a 191,266-byte PNG with a valid PNG signature. |
| Cell Filtering | PASS for defaults | Clicked Filtering; 342 cells remained and a violin plot rendered. |
| TF-IDF, feature selection, SVD/DepthCor | PASS for defaults | Normalization completed; linear reduction produced a DepthCor plot. Exact selected-feature count was not recorded. |
| UMAP and clustering | PASS for defaults | Nonlinear reduction completed with plot; clustering enabled and completed with plot. t-SNE and alternate cluster parameters were not tested. |
| Gene Activity Matrix | PASS for completion | Clicked Create Gene Activity Matrix; completion dialog displayed and RNA assay appeared in both differential modules. The assay matrix itself has not been exported for independent inspection. |
| One vs One RNA differential analysis | PASS for execution and download | Selected RNA assay, default LR test, cluster 0 versus 1. Table showed 883 entries; CSV download returned HTTP 200, 52,252 bytes, 884 lines including header. No significance claim is made. |
| One vs Rest RNA differential analysis | PASS for execution and download | Selected RNA assay and default LR test. Filtered table showed 723 entries. Full CSV download returned HTTP 200, 246,077 bytes, 3,059 lines including header; table and full export have different filtering scopes. |
| SingleR annotation | PASS for default reference | Ran annotation; table showed 5 rows, embedding plot rendered, CSV download returned HTTP 200 and 6 lines including header. |
| Genomic Region Visualization | PASS for default plot | Ran the page's default peak/region selection; a plot rendered. Plot download was not tested. |
| GO enrichment | NO ENRICHMENT RESULT | Ran with the auto-populated real marker list. The UI reported “GO enrichment analysis returned no results.” This confirms the no-result warning, not successful enrichment. |
| Motif enrichment (One vs Rest) and plot | PASS for execution and display on port 3848 | Ran with default cluster 0 and two auto-populated real peaks. Completion dialog appeared; table displayed 633 records with columns including `pvalue` and `p.adjust`. The first visible adjusted p-value was 0.0609, so 633 is a record count, not a significant-hit count. Selecting the first row rendered a sequence logo. Motif CSV and plot download were not tested. |
| Footprinting | PASS for default ALX3 computation and PNG download on port 3848 | Clicked the analysis button, saw completion, then a nonempty multi-group curve plot labeled MA0634.1. PNG download was 11,912,708 bytes with a valid PNG signature and SHA-256 `652a97076b7d99d4e316e44c4bd6f5e54697d0a3175a56cfd92d7c67de536c4d`. This validates one motif on the personal stage, not all motifs. |
| Motif One vs One, Custom Data upload, all other downloads | NOT TESTED | Four-file upload, t-SNE, Motif One vs One, other motif outputs and remaining plot formats need independent tests. |

The running page still had a few visible label typos in progress cards and plot titles. The local Git branch corrects `Greate/Creat Gene Activity Matrix`, `Dim Reduction &Clustering`, `Foot Printing`, and `GenomicReginsPlot` without changing IDs, algorithms or parameters. These local fixes have **not** been deployed to the tested stage.

No formal server directory was changed. The result files downloaded for verification are outside the Git repository and are not publication assets.
