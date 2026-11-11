# Data availability audit

The expected SHA-256 values come from the server supplied manifest in [DATA_SHA256SUMS.txt](DATA_SHA256SUMS.txt). The owner subsequently ran a read-only `stat` and `sha256sum` loop in `/srv/shiny-server/Signacshiny/`; its 12 actual sizes and hashes are recorded in [SERVER_DATA_INVENTORY.tsv](SERVER_DATA_INVENTORY.tsv). All 12 match the earlier server manifest. Seven reference files match their LFS pointer OIDs **and** advertised sizes; the five processed PBMC/QC files differ in both hash and size. The size column below is the pointer-advertised size, not the server actual size. Full values and comparisons are in [DATA_LFS_AUDIT.csv](DATA_LFS_AUDIT.csv).

Both unauthenticated and authenticated GitHub LFS batch download metadata checks returned **404 for all 12 tracked objects**. The authenticated check used the existing Git Credential Manager login and did not print credentials. A fresh clone independently failed to fetch `BlueprintEncode.Rdata` with the same 404. The remote is `https://github.com/lixiaoxin661-rgb/SignacShiny.git`; a Git push to this remote succeeded, so ordinary Git authentication works. No real payload exists in the local repository's `.git/lfs/objects` cache. The 12 committed pointer files have no matching `filter=lfs` rule in `.gitattributes`; adding that rule alone cannot restore their missing payloads. The 404 responses prove the objects are inaccessible now; repository LFS quota or account settings have not yet been ruled out as the cause.

| Server path | GitHub pointer OID prefix | Advertised size | Matches server SHA-256 | Remote object | Runtime use |
|---|---|---:|---|---|---|
| `data/BlueprintEncode.Rdata` | `250b6f3086` | 14,934,446 | Yes | 404 | SingleR reference |
| `data/DatabaseImmuneCell.se.Rdata` | `ce99697a40` | 305,850,473 | Yes | 404 | SingleR reference |
| `data/HumanPrimaryCellAtlas.Rdata` | `f5ac7b2418` | 44,047,960 | Yes | 404 | SingleR reference |
| `data/ImmGen.Rdata` | `9ad5e71c17` | 58,868,651 | Yes | 404 | SingleR reference |
| `data/MonacoImmune.Rdata` | `383b61d916` | 24,747,149 | Yes | 404 | SingleR reference |
| `data/MouseRNAseq.Rdata` | `6b968663be` | 16,948,446 | Yes | 404 | SingleR reference |
| `data/NovershternHematopoietic.Rdata` | `f2d55e7232` | 8,995,616 | Yes | 404 | SingleR reference |
| `data/pbmc.RDS` | `67ab642529` | 48,968,466 | No | 404 | PBMC example |
| `data/pbmcs_with_motifs_homo.rds` | `1d2156a00` | 111,781,377 | No | 404 | No fixed source reference found |
| `data/qcDensityScatterPlot.rds` | `e9ace51973` | 49,270,923 | No | 404 | Example QC cache |
| `data/qcFragmentHistogram.rds` | `265cc856a7` | 49,809,283 | No | 404 | Example QC cache |
| `data/qcTSSPlot.rds` | `4aca9e7cac` | 54,732,799 | No | 404 | Example QC cache |
| `data/pbmcs.RData` | Missing | Unknown | — | No pointer | No fixed source reference found |
| `data/zc/1/atac_pbmc_500_nextgem_filtered_peak_bc_matrix.h5` | Missing | Unknown | — | No pointer | Optional input example |
| `data/zc/1/atac_pbmc_500_nextgem_fragments.tsv.gz` | Missing | Unknown | — | No pointer | Optional input example |
| `data/zc/1/atac_pbmc_500_nextgem_fragments.tsv.gz.tbi` | Missing | Unknown | — | No pointer | Optional input example |
| `data/zc/1/atac_pbmc_500_nextgem_singlecell.csv` | Missing | Unknown | — | No pointer | Optional input example |

The server snapshot contains a root level `.tbi` matching the expected hash for the optional `data/zc/1/` index, but its path differs. The server code directly reads `pbmc.RDS`, three QC caches and seven SingleR reference objects. The remaining entries have no fixed path reference in the four main R files.

## Treatment of the 12 tracked data files

| File | Status | Verified acquisition route or remaining work |
|---|---|---|
| `BlueprintEncode.Rdata` | Public source available; exact file unverified | Bioconductor `celldex::BlueprintEncodeData()` provides a reference dataset; verify object format, labels, server SHA-256 and compatibility before treating it as a replacement. |
| `DatabaseImmuneCell.se.Rdata` | Public source available; exact file unverified | `celldex::DatabaseImmuneCellExpressionData()`; same checks required. |
| `HumanPrimaryCellAtlas.Rdata` | Public source available; exact file unverified | `celldex::HumanPrimaryCellAtlasData()`; same checks required. |
| `ImmGen.Rdata` | Public source available; exact file unverified | `celldex::ImmGenData()`; same checks required. |
| `MonacoImmune.Rdata` | Public source available; exact file unverified | `celldex::MonacoImmuneData()`; same checks required. |
| `MouseRNAseq.Rdata` | Public source available; exact file unverified | `celldex::MouseRNAseqData()`; same checks required. |
| `NovershternHematopoietic.Rdata` | Public source available; exact file unverified | `celldex::NovershternHematopoieticData()`; same checks required. |
| `pbmc.RDS` | Needs provenance/authorization | Processed PBMC object used by the built-in example. The official 10x PBMC 500 input dataset is public, but no validated conversion to this exact RDS is available. Pointer SHA differs from server SHA. |
| `pbmcs_with_motifs_homo.rds` | Needs provenance/authorization | No direct fixed-path call found; pointer SHA differs from server SHA. Determine origin and whether this file is needed for distribution. |
| `qcDensityScatterPlot.rds` | Needs provenance/authorization | Built-in example cache; pointer SHA differs from server SHA. Determine if safely regenerable from authorized PBMC input. |
| `qcFragmentHistogram.rds` | Needs provenance/authorization | Built-in example cache; pointer SHA differs from server SHA. Determine if safely regenerable from authorized PBMC input. |
| `qcTSSPlot.rds` | Needs provenance/authorization | Built-in example cache; pointer SHA differs from server SHA. Determine if safely regenerable from authorized PBMC input. |

Bioconductor documents these seven getters in the [celldex reference manual](https://bioconductor.org/packages/release/data/experiment/manuals/celldex/man/celldex.pdf); its [package page](https://bioconductor.org/packages/release/data/experiment/html/celldex.html) gives installation and package licensing. A guarded [reference preparation script](scripts/prepare_celldex_references.R) now maps those getters to the filenames and object names expected by `server.R`; its syntax and help path passed locally, but actual downloads and SingleR analysis remain untested. The [official 10x PBMC 500 dataset](https://www.10xgenomics.com/datasets/500-peripheral-blood-mononuclear-cells-pbm-cs-from-a-healthy-donor-next-gem-v-1-1-1-1-standard-1-1-0) describes the input dataset and its CC BY 4.0 license. These upstream sources do **not** prove that the server's serialized R objects have identical bytes, structure, or redistribution rights. No payloads were uploaded. To restore a cleared object, first verify its actual server SHA-256 and provenance, then configure Git LFS, upload the authorized payload, and prove retrieval and SHA-256 from a fresh clone. Until then, this is a Release blocker.
