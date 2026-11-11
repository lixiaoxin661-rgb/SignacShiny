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
| Service-user check | `sudo -n -u shiny` returned `sudo: a password is required`; no service-user R command ran. The owner may enter their own sudo password interactively or ask an administrator to perform this read-only check. No password should be shared. |

Next validation: run a read-only package check as the authorized `shiny` service user, then launch an independent staging copy with the same R and library paths. Do not modify the formal project or the shared cache. Until the service-user check and stage run succeed, dependency availability and functional readiness are unverified.
