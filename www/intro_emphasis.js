
(function () {
  const terms = [
  "downstream analysis of processed scATAC-seq data",
  "calculated quality-control metrics as interactive violin plots",
  "quantification of gene activity based on chromatin accessibility",
  "estimating gene activity from chromatin accessibility data",
  "predicted cell labels and annotation scores",
  "human and mouse reference datasets",
  "dimensionality reduction and clustering",
  "differential accessibility and gene activity analysis",
  "transcription factor footprinting",
  "genomic region visualization",
  "reference-based cell annotation",
  "fraction of reads in peaks",
  "transcription start site (TSS) enrichment",
  "nucleosome signal",
  "blacklist region ratio",
  "gene activity matrix",
  "graph-based clustering",
  "differentially accessible peaks",
  "motif enrichment analysis",
  "GO enrichment analysis",
  "cell-type-specific regulatory landscapes",
  "quality-control metrics",
  "density scatter plot",
  "TSS enrichment profile",
  "nucleosome banding plot",
  "chromatin accessibility",
  "cell filtering",
  "quality control",
  "dimensionality reduction",
  "SingleR",
  "SignacShiny"
].sort((a, b) => b.length - a.length);

  const escapeRegex = s =>
    s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

  const pattern = new RegExp(
    terms.map(escapeRegex).join("|"), "gi"
  );

  function emphasize(container) {
    if (container.dataset.introStyled === "yes") return;

    const walker = document.createTreeWalker(
      container,
      NodeFilter.SHOW_TEXT
    );

    const nodes = [];
    while (walker.nextNode()) {
      const n = walker.currentNode;
      if (!n.nodeValue.trim()) continue;
      if (n.parentElement &&
          n.parentElement.closest(
            "a, strong, code, script, style, button"
          )) continue;
      nodes.push(n);
    }

    let count = 0;

    nodes.forEach(node => {
      if (count >= 14) return;

      const value = node.nodeValue;
      pattern.lastIndex = 0;

      let match, last = 0;
      const fragment = document.createDocumentFragment();
      let changed = false;

      while ((match = pattern.exec(value)) && count < 14) {
        fragment.appendChild(
          document.createTextNode(
            value.slice(last, match.index)
          )
        );

        const span = document.createElement("span");
        span.className =
          match[0].toLowerCase() === "signacshiny"
          ? "signac-intro-brand"
          : "signac-intro-focus";

        span.textContent = match[0];
        fragment.appendChild(span);

        last = match.index + match[0].length;
        changed = true;
        count++;
      }

      if (changed) {
        fragment.appendChild(
          document.createTextNode(value.slice(last))
        );
        node.parentNode.replaceChild(fragment, node);
      }
    });

    container.dataset.introStyled = "yes";
  }

  function applyStyle() {
    document.querySelectorAll(".my-custom-div")
      .forEach(emphasize);
  }

  if (document.readyState === "loading") {
    document.addEventListener(
      "DOMContentLoaded", applyStyle
    );
  } else {
    applyStyle();
  }
})();
