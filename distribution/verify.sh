#!/usr/bin/env bash
# verify.sh — freeze check seed (ATOM-130; grows into the full release
# verify of INFO-043 block 3).
#
# THE ONE RULE IT ENFORCES TODAY: a distribution tree contains ONLY the
# paths whitelisted in dist-manifest. Anything else in the tree — one
# stray products/ file, one TASKS.md, one launch file — and this script
# fails loudly, listing every offender. «Универсально целиком или не едет».
#
# USAGE:
#   bash verify.sh <tree-dir> [manifest-file]
#     tree-dir       the distribution tree to check (a vendored framework/
#                    copy, a release checkout, a packed kit)
#     manifest-file  defaults to <tree-dir>/distribution/dist-manifest
#
# EXIT: 0 = frozen clean; 1 = non-manifest content found (listed);
#       2 = usage / manifest missing.
#
# Deliberately ignored: .git plumbing (not part of the tree's content) and
# PROVENANCE.md at the tree root (the installer's own untracked receipt,
# written at vendor time — see install.sh).

set -euo pipefail

TREE="${1:-}"
[[ -n "$TREE" && -d "$TREE" ]] || { echo "usage: verify.sh <tree-dir> [manifest-file]" >&2; exit 2; }
TREE="$(cd "$TREE" && pwd)"
MANIFEST="${2:-$TREE/distribution/dist-manifest}"
[[ -f "$MANIFEST" ]] || { echo "FREEZE-CHECK: manifest not found: $MANIFEST" >&2; exit 2; }

# manifest entries, comments/blanks stripped
ENTRIES=()
while IFS= read -r line; do
  line="${line%%#*}"
  line="$(printf '%s' "$line" | tr -d '[:space:]')"
  [[ -n "$line" ]] && ENTRIES+=("$line")
done < "$MANIFEST"
[[ ${#ENTRIES[@]} -gt 0 ]] || { echo "FREEZE-CHECK: manifest is empty: $MANIFEST" >&2; exit 2; }

offenders=0
while IFS= read -r f; do
  rel="${f#"$TREE"/}"
  # not the tree's content: git plumbing + the installer's own receipt
  [[ "$rel" == .git || "$rel" == .git/* ]] && continue
  [[ "$rel" == PROVENANCE.md ]] && continue
  ok=0
  for e in "${ENTRIES[@]}"; do
    if [[ "$e" == */ ]]; then
      [[ "$rel" == "$e"* ]] && { ok=1; break; }
    else
      [[ "$rel" == "$e" ]] && { ok=1; break; }
    fi
  done
  if [[ $ok -eq 0 ]]; then
    (( offenders == 0 )) && echo "FREEZE-CHECK FAILED — non-manifest content in $TREE:" >&2
    echo "  NOT IN MANIFEST: $rel" >&2
    offenders=$((offenders + 1))
  fi
done < <(find "$TREE" -type f)

if (( offenders > 0 )); then
  echo "FREEZE-CHECK: $offenders offending file(s). The distribution ships manifest paths ONLY." >&2
  exit 1
fi
echo "FREEZE-CHECK OK: $TREE contains manifest paths only (${#ENTRIES[@]} manifest entries)."
exit 0
