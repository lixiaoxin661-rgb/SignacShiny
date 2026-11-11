#!/usr/bin/env Rscript
# Fetch public SingleR references into an empty staging data directory.
# This does not reproduce the server's serialized RData bytes by itself.
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1L || length(args) > 2L || args[[1L]] %in% c("-h", "--help")) {
  cat("Usage: Rscript --vanilla scripts/prepare_celldex_references.R /path/to/stage/data [reference-name]\n")
  quit(status = if (length(args) == 1L) 0L else 2L)
}
if (!requireNamespace("celldex", quietly = TRUE)) {
  stop("celldex is not installed in this R library; install it in the isolated test environment first.")
}
if (!requireNamespace("digest", quietly = TRUE)) {
  stop("digest is required to report output SHA-256 values.")
}
out_dir <- normalizePath(args[[1L]], mustWork = TRUE)
if (!dir.exists(out_dir)) stop("Output directory does not exist: ", out_dir)

references <- c(
  BlueprintEncode = "BlueprintEncodeData",
  DatabaseImmuneCell.se = "DatabaseImmuneCellExpressionData",
  HumanPrimaryCellAtlas = "HumanPrimaryCellAtlasData",
  ImmGen = "ImmGenData",
  MonacoImmune = "MonacoImmuneData",
  MouseRNAseq = "MouseRNAseqData",
  NovershternHematopoietic = "NovershternHematopoieticData"
)
if (length(args) == 2L) {
  if (!args[[2L]] %in% names(references)) {
    stop("Unknown reference name: ", args[[2L]])
  }
  references <- references[args[[2L]]]
}
destinations <- file.path(out_dir, paste0(names(references), ".Rdata"))
if (any(file.exists(destinations))) {
  stop("Refusing to overwrite existing references: ",
       paste(basename(destinations[file.exists(destinations)]), collapse = ", "))
}
cat("R=", as.character(getRversion()), " celldex=",
    as.character(packageVersion("celldex")), "\n", sep = "")
for (i in seq_along(references)) {
  object_name <- names(references)[[i]]
  getter_name <- references[[i]]
  getter <- getExportedValue("celldex", getter_name)
  reference <- getter()
  labels <- reference$label.fine
  if (is.null(labels) || length(labels) != ncol(reference) || anyNA(labels)) {
    stop(getter_name, " did not return a reference with complete label.fine labels")
  }
  staged <- tempfile(pattern = paste0(object_name, "-"), tmpdir = out_dir)
  environment <- new.env(parent = emptyenv())
  assign(object_name, reference, envir = environment)
  save(list = object_name, file = staged, envir = environment, version = 3)
  check <- new.env(parent = emptyenv())
  loaded <- load(staged, envir = check)
  if (!identical(loaded, object_name) || ncol(check[[object_name]]) != length(labels)) {
    unlink(staged)
    stop("Serialized reference failed a read-back check: ", object_name)
  }
  if (!file.rename(staged, destinations[[i]])) {
    unlink(staged)
    stop("Unable to place prepared reference: ", destinations[[i]])
  }
  cat(basename(destinations[[i]]), "\t", file.info(destinations[[i]])$size,
      "\t", digest::digest(destinations[[i]], algo = "sha256", file = TRUE), "\n", sep = "")
  rm(reference, environment, check, labels)
  gc(verbose = FALSE)
}
