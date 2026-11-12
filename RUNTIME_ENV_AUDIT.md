# Server R environment check (pre-release)

The owner ran read-only commands in `/srv/shiny-server/Signacshiny/` on 2026-11-11. These results describe the interactive account and the project library; they do not yet prove the environment used by the live Shiny process or that all modules work.

| Observation | Result |
|---|---|
| Interactive shell `Rscript` | `/users/xiaoxli/miniconda3/bin/Rscript`, R 4.5.1 |
| System `Rscript` | `/usr/bin/Rscript`, R 4.4.2 |
| Snapshot `renv.lock` | R 4.4.2, Bioconductor 3.20; package versions require live verification |
| Project library | `renv/library/linux-ubuntu-jammy/R-4.4/x86_64-pc-linux-gnu/` |
| `Signac` and `SingleR` | Symlinks to `/home/shiny/.cache/R/renv/cache/...`; package load from `xiaoxli` returned `MISSING` because `/home/shiny/.cache` is mode `700` and inaccessible to that user |
| `Seurat`, `shiny`, `JASPAR2020` | Visible to the `xiaoxli` test using system R: 5.5.1, 1.14.0, 0.99.10 respectively; these are not necessarily the versions resolved by the live service |
| `celldex` | Not found in the tested library paths; the reference preparation script has not run |
| Service-user check | `sudo -n -u shiny` returned `sudo: a password is required`; no service-user R command ran. The ordinary user must not use `sudo` or access the service user's private cache. |

## Personal stage update, 2026-11-12

The owner prepared personal libraries at `/users/xiaoxli/Rlibs/signacshiny-r44`, `/users/xiaoxli/Rlibs/signacshiny-ggplot4-test`, and `/users/xiaoxli/Rlibs/signacshiny-motif-test`. With `/usr/bin/Rscript --vanilla`, those paths in `R_LIBS_USER`, and the personal Miniconda library in `LD_LIBRARY_PATH`, a read-only namespace check reported R 4.4.2, shiny 1.10.0, Signac 1.17.1, Seurat 5.2.1, SingleR 2.8.0, ggplot2 4.0.3, scales 1.4.0, patchwork 1.3.2, TFBSTools 1.44.0, motifmatchr 1.28.0, DirichletMultinomial 1.48.0, JASPAR2020 0.99.10, ggseqlogo 0.2.2, clusterProfiler 4.14.6, and EnsDb.Hsapiens.v75/v86 plus EnsDb.Mmusculus.v79 at 2.99.0. This differs from the historical lockfile's shiny 1.11.1. The exact launcher content and full live `sessionInfo()` output still need capture. A personal Shiny instance on forwarded port 3846 ran the PBMC example and several real analyses, as documented in `server_stage_browser_test_20261112.md`. This demonstrates usable dependencies for those tested paths in the personal stage, not the service-user environment or a fresh install.

The initial personal-library check returned `MISSING` for `TFMPvalue`, `DirichletMultinomial`, `TFBSTools`, and `motifmatchr`. GSL 2.7 was discoverable through `pkg-config`. The later namespace check above confirms the listed Motif packages can now load from the personal test environment. In a browser session on personal port 3848, actual Motif analysis and Footprinting both completed and rendered plots; see `server_stage_browser_test_20261112.md`. Exact loaded package paths, full `sessionInfo()`, archive-to-install provenance, and service-user availability remain unverified.

The owner provided the four R source files from the running personal stage. `app.R` and `global.R` are content-equivalent to the branch; the stage's verified DepthCor and Motif changes have been merged into `server.R`, and its layout plus two `intro_emphasis` assets into `ui.R`/`www/`. The fixed source archive for commit `e037c4a` was unpacked in a separate personal directory, all 11 needed data links passed SHA-256 checks, and the app started on localhost port 3850 with the personal R 4.4.2 libraries. The browser exercised multiple real analyses, listed in `server_stage_browser_test_20261112.md`. The precise environment for the formal service user remains unverified; this requires an authorized administrator or nonprivileged service documentation, without accessing another account's private cache or changing the formal project.
