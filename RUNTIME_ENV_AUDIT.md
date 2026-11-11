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

The owner prepared personal libraries at `/users/xiaoxli/Rlibs/signacshiny-r44` and `/users/xiaoxli/Rlibs/signacshiny-ggplot4-test`, with a launcher named `run_signacshiny_verified.sh`. The stated graphics combination is R 4.4.2, ggplot2 4.0.3, scales 1.4.0, and patchwork 1.3.2; the exact launcher content and live `sessionInfo()` output still need capture. A personal Shiny instance on forwarded port 3846 ran the PBMC example and several real analyses, as documented in `server_stage_browser_test_20261112.md`. This demonstrates usable dependencies for those tested paths in the personal stage, not the service-user environment or a fresh install.

The personal-library check returned `MISSING` for `TFMPvalue`, `DirichletMultinomial`, `TFBSTools`, and `motifmatchr`. The stage's Motif analysis had already failed with a `TFBSTools` namespace error. GSL 2.7 is discoverable through `pkg-config`. Matching official source archives were downloaded to a separate local folder and uploaded to the owner's personal staging directory; server-side SHA-256 verification, installation, package loading, and a true Motif calculation remain pending. Do not mark Motif or Footprinting as functional based on the other module tests.

Next validation: verify the uploaded archives, install only into the personal R library if compilation succeeds, record package versions and startup paths, and rerun Motif and Footprinting in the personal stage. Do not alter the formal project or its shared package cache.
