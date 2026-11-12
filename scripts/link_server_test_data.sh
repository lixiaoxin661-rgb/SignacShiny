#!/usr/bin/env bash
# Use only from a private test clone on the authorized laboratory server.
# Creates links in this clone; never writes to the formal project or its data.
set -euo pipefail

stage=$(pwd -P)
formal=/srv/shiny-server/Signacshiny
if [[ $stage == "$formal" || $stage == "$formal/"* ]]; then
  echo 'Refusing to run inside the formal Shiny project.' >&2
  exit 1
fi
if [[ ! -f "$stage/app.R" || ! -f "$stage/DATA_SHA256SUMS.txt" || ! -d "$stage/data" ]]; then
  echo 'Run this script from the root of a SignacShiny test clone.' >&2
  exit 1
fi

files=(
  BlueprintEncode.Rdata
  DatabaseImmuneCell.se.Rdata
  HumanPrimaryCellAtlas.Rdata
  ImmGen.Rdata
  MonacoImmune.Rdata
  MouseRNAseq.Rdata
  NovershternHematopoietic.Rdata
  pbmc.RDS
  qcDensityScatterPlot.rds
  qcFragmentHistogram.rds
  qcTSSPlot.rds
)

# Verify every source and manifest entry before creating any link.
for name in "${files[@]}"; do
  source_file="$formal/data/$name"
  target="$stage/data/$name"
  if [[ ! -f $source_file || ! -r $source_file ]]; then
    echo "Missing/unreadable source: $name" >&2
    exit 1
  fi
  if [[ -L $target ]]; then
    if [[ $(readlink -- "$target") != "$source_file" ]]; then
      echo "Unexpected existing link: $name" >&2
      exit 1
    fi
  elif [[ -e $target ]]; then
    echo "Missing/unreadable source or occupied target: $name" >&2
    exit 1
  fi
  expected=$(awk -v path="data/$name" '{ sub(/\r$/, "", $2); if ($2 == path) print $1 }' "$stage/DATA_SHA256SUMS.txt")
  if [[ ! $expected =~ ^[0-9a-f]{64}$ ]]; then
    echo "Missing expected SHA-256 for $name" >&2
    exit 1
  fi
  actual=$(sha256sum -- "$source_file")
  actual=${actual%% *}
  if [[ $actual != "$expected" ]]; then
    echo "SHA-256 mismatch for $name" >&2
    exit 1
  fi
  echo "VERIFIED $name $actual"
done

for name in "${files[@]}"; do
  target="$stage/data/$name"
  if [[ ! -L $target ]]; then
    ln -s -- "$formal/data/$name" "$target"
  fi
  echo "LINKED $name"
done
echo 'Private stage data links and hashes verified; R dependencies and Shiny functions remain untested.'
