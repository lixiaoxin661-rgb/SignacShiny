# SignacShiny v1.0.0 release audit (in progress)

This record separates verified source checks from server runtime claims. It is not a release approval.

## Source candidate

- Local branch: `chore/manuscript-ui-release`; local base commit before this audit: `211dfcd52e686effdbf7592ece0b4e0713d04ba9`.
- `app.R`, `global.R`, `ui.R`, and `server.R` parsed with local R 4.6.1 on 2026-11-12. Parsing does not test package loading or Shiny behavior.
- `git diff --check` passed. The local `www/workflow.svg` SHA-256 is `cdecda452925cf460318bfe590bb4c6f427bc13ebadd3b03cfa46a1c75ee79d6`, matching the previously supplied original SVG. README and home reference that path.
- The previously completed page-by-page wording check is recorded in `release_ui_audit.md`. The current personal server stage has not yet been compared byte-for-byte with this local branch.
- The local code retains the server analysis functions and `run_step()` timing/optional `lobstr` memory reporting. `Cell Filtering` calls `run_step()`. This audit has not rerun end-to-end analysis or downloads.
- On 2026-11-12, the branch was pushed to GitHub at `22dcde2df367d08e54fd1520ca22fc9cbe21ccd4`, then independently cloned into a new directory. In that clone all four core R files parsed, `renv.lock` parsed as JSON, five `www/` resources were present, README referenced `www/workflow.svg`, and that SVG matched the original SHA-256. `git lfs ls-files` returned no tracked objects and `data/` contained only its documentation and ignore file: the source clone remains without runtime example/reference data.

## Personal server stage: evidence still required

The owner supplied the personal stage path `/users/xiaoxli/SignacShiny-stage/SignacShiny-chore-manuscript-ui-release`, two personal R library directories, and `outputs/fullflow_test_20261112_034903/`. The reported 12/12 smoke result and 581-to-342-cell PBMC result require the underlying scripts, logs, inputs, and outputs before they can be accepted as release evidence. The local Git candidate may differ from the stage files; do not overwrite either copy blindly.

A separate browser session subsequently exercised the **running personal stage** with real PBMC data. Example import, QC plots and one PNG download, filtering, normalization, SVD/DepthCor, UMAP, clustering, Gene Activity Matrix, both RNA differential modes with CSV downloads, default SingleR annotation, and a genomic region plot produced outputs. GO ran but returned no enriched terms. The exact observations and remaining gaps are in `server_stage_browser_test_20261112.md`. These results do not establish that the local branch or future Release behaves identically until the stage source is reconciled with Git history.

A visible VS Code remote terminal contained an actual Motif traceback from the stage's `server.R`: `there is no package called 'TFBSTools'`. A later terminal showed `DirichletMultinomial` and `TFMPvalue` unavailable to an attempted `TFBSTools` build and `motifmatchr` consequently missing. Thus Motif enrichment and downstream footprinting are **FAIL / not validated**, regardless of the earlier 12/12 smoke summary. The underlying `DirichletMultinomial` build error has not been retrieved.

Four matching official source archives were downloaded and integrity checked outside the Git repository in `../signacshiny_official_r_packages/`: TFMPvalue 0.0.9 (CRAN archive), DirichletMultinomial 1.48.0, TFBSTools 1.44.0, and motifmatchr 1.28.0 (Bioconductor 3.20). They have not been installed or load-tested on the server. See the separate package manifest for hashes.

The inherited `server.R` initializes many analysis objects with `<<-` inside the Shiny server function. In R this can assign to a shared parent/global environment when no session-local binding exists, so concurrent sessions may interfere. This is a source-level risk, not a demonstrated failure in the single-session test. The repeated `reactiveValues()` initializers also obscure which slots are initialized; observed default workflows nevertheless ran. Correcting the shared-state design would touch many observers and requires a separate multi-session regression test against the actual stage source; it has not been silently refactored for v1.0.0. The existing `run_step()` measures elapsed time and before/after `lobstr::mem_used()` values when available; it does not measure peak process RSS. The reported ~2.23 GiB peak RSS from a separate smoke test must not be relabeled as a `run_step()` memory delta.

| Area | Status | Evidence needed |
|---|---|---|
| Example import, QC, filtering, DR and clustering | PASS IN STAGE BROWSER | Confirm stage source/parameters against a Git commit before transferring this result to the release candidate. |
| Gene activity and RNA differential analysis | PASS IN STAGE BROWSER | Assay creation, both comparison tables and CSV downloads observed; independent matrix export and exact commit still needed. |
| SingleR and regions | PASS IN STAGE BROWSER | Default reference table/plot and region plot observed; full parameter matrix and region download remain untested. |
| GO | NO ENRICHMENT RESULT | Calculation returned an explicit no-result warning for the real marker list; positive enrichment not demonstrated. |
| Motif enrichment | FAIL | Load `TFBSTools` and `motifmatchr` in the stage's exact R session, then run true enrichment and inspect nonempty output. |
| Footprinting | NOT TESTED | Valid motif, successful computation, plot and download. |
| All 12 pages and downloads | PARTIAL | All introduction text visible; selected downloads verified. Custom upload, alternate paths, Motif/footprinting and remaining formats need tests. |

## Data and release gate

The 12 real files on the formal server matched the owner's SHA-256 manifest. This establishes private server data integrity, not GitHub delivery. The 12 historical LFS objects returned 404; the invalid pointers were removed from the test branch. Seven reference datasets have public celldex getters, but the preparation script has not been shown to reproduce or functionally replace the server files. Redistribution rights for five processed PBMC/QC objects remain unconfirmed. A fresh source clone therefore does not yet provide a fully runnable example.

No v1.0.0 tag or Release has been created by this audit. Merge, public Release, and formal server deployment remain gated on an obtainable runtime-data route, working Motif dependencies, and verified full function tests. The formal `/srv/shiny-server/Signacshiny` directory was not changed.
