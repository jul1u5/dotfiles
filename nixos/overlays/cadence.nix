final: prev:
{
  cadence = prev.cadence.overrideAttrs (old: {
    patches = old.patches ++ [
      (final.fetchpatch {
        url = assert old.version == "0.9.1"; "https://github.com/falkTX/Cadence/commit/bf0869c111fd72e3a1caf804a7665dce9698632f.patch";
        sha256 = "NQHEBM/URr2eVX2Q+n3kF/H/MT3j590wO5d89eTN/ps=";
      })
    ];
  });
}
