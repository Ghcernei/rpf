# Changelog

One entry per release tag, written in user-benefit language (what gets
better for you). Rendered from the release's verified records — nothing here
is composed from memory. Rule (INFO-024): a release without a changelog
entry is not published.

## v0.1.2 — 2026-07-10

- «qroky start» now works out of the box: the starting gesture ships inside
  the kit and the installer wires it into your working folder automatically
  (this closes the first field-test finding — the finish screen used to
  promise a phrase your machine had never been taught).
- The default working folder moved to `~/qroky-work` — outside the
  downloaded kit, so kit updates never sit next to your own work.
- The finish screen and the guides now include a line for VS Code users
  (File → Open Folder → your working folder) and say honestly that the
  starting phrase lives in that folder.

*Earlier kit versions (v0.1.0 installer, v0.1.1 backup + disclaimer) predate
tagging and shipped by commit; their records live in
`products/distribution-kit-v1/`.*
