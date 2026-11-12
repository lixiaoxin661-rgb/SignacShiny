# Runtime data

The source release contains no processed PBMC example, cached QC objects, or SingleR reference objects. Obtain these files from the maintainer for authorized use before running the corresponding features. Expected paths and SHA-256 hashes are recorded in [DATA_SHA256SUMS.txt](../DATA_SHA256SUMS.txt).

## Example data

The built-in Example Data workflow reads:

- `data/pbmc.RDS`
- `data/qcDensityScatterPlot.rds`
- `data/qcTSSPlot.rds`
- `data/qcFragmentHistogram.rds`

These must be real R objects, not Git LFS pointer files. Keep any fragment files referenced by the example object accessible to the application. Redistribution of the processed example and QC objects has not been established; they must not be uploaded without authorization.

## Cell annotation references

SingleR annotation reads the reference chosen in the interface:

- `data/DatabaseImmuneCell.se.Rdata`
- `data/BlueprintEncode.Rdata`
- `data/HumanPrimaryCellAtlas.Rdata`
- `data/MonacoImmune.Rdata`
- `data/NovershternHematopoietic.Rdata`
- `data/ImmGen.Rdata`
- `data/MouseRNAseq.Rdata`

Only the selected reference is needed for that annotation run. The [reference preparation script](../scripts/prepare_celldex_references.R) provides a celldex-based preparation route, but regenerated objects have not been validated as replacements for the server's serialized reference files. Do not assume they have the same hashes or annotation behavior.

## Custom inputs

Choose **Custom Data** and supply a peak matrix, fragments file, matching `.tbi` index, and cell metadata using the interface. Use a consistent species and genome assembly. The Home page links to the original 10x Genomics PBMC 500 Next GEM input files as an example. Public raw inputs do not replace the serialized PBMC/QC objects used by **Example Data**.

## Verification

On Linux, run `sha256sum -c DATA_SHA256SUMS.txt` from the project root after obtaining the corresponding files. On Windows, compare hashes using `Get-FileHash -Algorithm SHA256`. The manifest includes additional inputs; distinguish unused or optional files from missing files required by the workflow you intend to run.

The private server smoke test used the 11 example/QC/reference paths listed above. `pbmcs_with_motifs_homo.rds` and `pbmcs.RData` are not fixed-path reads in the four core application files. Passing a private server data check does not establish public data availability.
