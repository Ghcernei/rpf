---
atom: ATOM-073
lens: founder-ux
role: founder-ux-reviewer
question: "Дают ли эти пререквизиты пилоту стартовать и быть измеренным безопасно?"
answer: yes-with-conditions
date: 2026-07-07
---

# LENS-VERDICT — founder-ux (ATOM-073)

## 1. Answer

**Yes, with conditions.** The shape is right — a founder reads a conversation,
not machinery, in the two artifacts that matter most for the first 15 minutes
(QUICKSTART, the bootstrap.sh runtime output, TIERS). But the signature
document (CONSENT) leaks the framework's own internal vocabulary straight
into the paragraph a founder must read to decide whether to sign, the very
first step of QUICKSTART assumes a file the founder was never told how to
obtain, and one dollar figure in TIERS is presented as measured fact while
its own spec-sibling says the exact same number's underlying rate is a
placeholder that "MUST be replaced ... before any real founder sees a cost
line derived from it." None of these are structural — they are all
patchable inside the current shape — but as shipped today I would not let a
founder sign CONSENT or run QUICKSTART step 1 as written.

## 2. Findings

### Blocking-for-pilot

**B1 — CONSENT body text is not run through the framework's own jargon filter.**
- Artifact: `072-telemetry-showcase/consent/CONSENT.ro.md` L17-19 and
  `CONSENT.ru.md` L17-19 (the sentence naming what telemetry collects).
- What: the sentence reads (RO) "fișierele STATUS ale atomilor, blocurile de
  cost din fișierele RESULT, jurnalele de rulare (run log), status.yaml și
  verdictele de verificare" — "atomilor" (of *atoms*), "fișierele RESULT",
  "status.yaml", "verdictele de verificare" are raw internal filenames/terms,
  none translated. This is the exact same information `showcase/team-summary-spec.md`
  (written by the *same atom*, same day) insists must be substituted before
  reaching a founder: its own glossary maps `atom`→task, `STATUS.md`→progress
  log, `RESULT.md`→report, `VERDICT.md`→check result. CONSENT was never run
  through that glossary. "Atom" in particular is never introduced to the
  founder anywhere upstream (QUICKSTART deliberately avoids it) — it lands
  here, undefined, in the one document a founder signs (the S5 gate).
- Severity: blocking-for-pilot — this is the literal DoD S1 failure mode
  ("machinery fully hidden"), in the highest-stakes artifact of the set.
- What I would change: rewrite the sentence using the same plain-language
  substitutes team-summary-spec.md already defines — e.g. "your task
  progress logs, the cost summary of each report, step logs, the overall
  status board, and independent-check results." If exact filenames matter
  for legal/audit precision, add them as a separate, clearly labelled
  footnote ("exact technical list, for reference") — not inline in the
  paragraph a founder reads to decide.

**B2 — QUICKSTART never explains how the founder gets `bootstrap.sh` onto their machine.**
- Artifact: `071-setup-kit/setup/QUICKSTART.ro.md` / `.ru.md`, step 1-2
  (both language versions, same structure).
- What: step 1 says "open a terminal in the folder where you want to work,"
  step 2 says "run: `bash bootstrap.sh`." Nothing between them tells the
  founder where `bootstrap.sh` comes from — no download link, no "you
  received this as an attachment," no "clone this repo first." A founder
  following the guide literally cannot execute step 2; the file does not
  exist in their folder yet. Every other unknown (missing `git`, missing
  `claude`) is explicitly handled by the script itself — this one precedes
  the script and is the one gap nothing catches.
- Severity: blocking-for-pilot — breaks the very first action of the ≤15-minute
  promise this document exists to prove.
- What I would change: add one numbered line before current step 1: "You
  received a folder or a link containing this kit from [whoever invited you]
  — open that folder" (or, if the intended distribution is a `git clone` of a
  small kit repo, say that explicitly with the one command). Whichever is
  true operationally, name it — do not leave it implicit.

**B3 — TIERS dollar figures are presented as measured fact while their own source spec calls the same rate an unreplaced placeholder.**
- Artifact: `071-setup-kit/setup/TIERS.ro.md` / `.ru.md`, final section
  ("De ce contează asta pentru tine" / "Почему это важно для вас"): "Cifrele
  de mai sus sunt măsurate direct din construcția acestui cadru, nu sunt
  cifre de marketing" ("measured directly ... not marketing figures"). Cross-
  reference: `072-telemetry-showcase/showcase/cost-line-spec.md` §"Honest-
  rounding rule" point 4: the `$/token` rate feeding every dollar figure in
  this framework is "a placeholder blended rate — $8.00 per million tokens,
  assumption dated 2026-07-07 ... This placeholder MUST be replaced with the
  actual contracted rate at ATOM-007 setup, before any real founder sees a
  cost line derived from it."
- What: TIERS.md IS a cost line derived from that rate, shown to a real
  founder, with zero assumption/date disclosure, while asserting the numbers
  are not the kind of figure that needs that disclosure ("not marketing
  figures"). This is false certainty (role Escalation E3): a resource claim
  presented as sourced fact when its own sibling document flags it as a
  dated assumption pending replacement.
- Severity: blocking-for-pilot — a founder who later learns the $1-3 /
  $1-2.5 numbers rested on a placeholder rate not yet contracted will read
  the earlier "not marketing figures" line as a broken promise.
- What I would change: either replace the placeholder rate with the real
  contracted one before TIERS ships to a founder, or add TIERS' own version
  of cost-line-spec.md's disclosure ("figures use a placeholder rate, dated
  2026-07-07, pending the final contract — will be corrected, never
  silently, before pilot start").

### Significant

**S1 — the cost-line "audit comment block" is jargon-dense and the spec explicitly invites a founder to read it.**
- Artifact: `072-telemetry-showcase/showcase/example-cost-line.txt` L3-16
  (everything below the actual cost line) and `cost-line-spec.md`
  "Governance overhead stays visible" (point 2): "so a founder — or Startup
  Moldova — can see how much of $X is 'thinking' versus governance
  overhead."
- What: that comment block names `atom`, `RESULT.md`, `VERDICT.md`,
  `status.yaml`, `total_descendants`, `PM4`, "pre-fan" — none plain-language.
  Nothing in either the spec or `render.sh` states which layer actually
  reaches a founder's chat (just line 1, one hopes) versus which stays as an
  internal audit file a founder is never pointed at. As written, the spec
  text itself claims founder visibility into this block.
- Fix: state explicitly, in cost-line-spec.md, that only the single cost
  line (⚙ ...) is pasted into any founder-facing reply; the comment block is
  an internal audit trail, never surfaced without translation.

**S2 — the TEAM summary leaks a raw rule-id despite its own no-jargon rule.**
- Artifact: `072-telemetry-showcase/showcase/example-team-summary.md` L16
  ("Fan decision: opt-out per PM4.") — produced by `render.sh`'s
  `fan_decision_line` extraction (L163), which greps INPUT.md's `**Fan
  decision:**` line verbatim.
- What: `team-summary-spec.md` rule 3 says a raw closure note must never be
  echoed verbatim; the same principle plainly applies here, and it is
  violated — "PM4" is a method-rule id with no founder meaning, sitting in a
  document whose whole purpose (INFO-007) is to be plain-language.
- Fix: add a substitution/strip pass for the fan-decision line, same
  treatment as the human-decision cell already gets (distill to one plain
  sentence, discard the rule-id).

**S3 — QUICKSTART's "proof" pointer sends a reassurance-seeking founder into jargon.**
- Artifact: `071-setup-kit/setup/QUICKSTART.ro.md` / `.ru.md`, final line:
  "Dovada: `dry-run-transcript.txt`, în acest același folder." Target file:
  `071-setup-kit/setup/dry-run-transcript.txt` (e.g. "H2 requirement,"
  "idiom," raw `grep` output, "WARNING" blocks).
- What: a founder who wants to double-check the 15-minute claim is invited,
  by name, into a file written for an internal Verify check, two lines after
  the document's own tone has been carefully plain. This is the DoD's own
  "founder never meets the machinery" principle undone by its own evidence
  pointer.
- Fix: either drop the pointer from the founder-facing file (keep the
  transcript as pure Verify evidence, cited from RESULT.md instead), or
  replace it with one plain sentence ("this was tested on a clean machine
  and finished in under a minute of computer time") and move the raw
  transcript reference to a place only Verify/lens atoms read.

**S4 — CONSENT never states the consequence of declining.**
- Artifact: `072-telemetry-showcase/consent/CONSENT.ro.md` /
  `CONSENT.ru.md` in full.
- What: consent is correctly framed as "explicit, opțional (opt-in) și
  revocabil" — but nowhere does the document say what happens if a founder
  declines or later revokes: does the pilot continue without telemetry? Does
  the Flow Support SLA ("reaction within one business day," itself tied to
  "daily review of your flows" in the same paragraph) still apply? A founder
  cannot make an informed opt-in/opt-out decision without knowing the real
  alternative (role Escalation E4: one branch of the choice set is
  materially hidden).
- Fix: one sentence stating plainly whether declining/revoking telemetry
  changes pilot participation or SLA terms, either way.

**S5 — the ≤15-minute promise is proven against a fully stubbed dry run; the real network-bound leg is unmeasured.**
- Artifact: `071-setup-kit/setup/dry-run.sh` (stub 1: fake `claude` binary;
  stub 2: local offline git repo standing in for
  `https://github.com/qroky/framework.git`) and its own honest header
  comment naming both stubs.
- What: the transcript's "Run 1 elapsed: 0s" and "PASS — within 900s budget"
  are true for the scripted mechanics but say nothing about a real internet
  clone of the actual framework repository, which QUICKSTART's own text
  concedes varies "in funcție de viteza internetului" (2-5 min estimate,
  itself unverified against a real clone). The transcript is honest about
  what it stubs (no hidden claim) — but the founder-facing "sub un minut
  pentru partea tehnică ... cu mult sub bugetul de 15 minute" reads more
  confident than the evidence supports for the one leg that actually varies.
- Fix: either run one real (network-attached) timed clone of the actual
  framework repo and fold that number in, or soften QUICKSTART's closing
  claim to name the untested leg explicitly ("the scripted steps take under
  a minute; add the time your connection needs to download the framework
  once, typically a few minutes").

### Minor

**M1 — bootstrap.sh exposes an unexplained internal filename.**
- Artifact: `071-setup-kit/setup/bootstrap.sh` L158 ("connected — CLAUDE.md
  written at the top of the workspace").
- Fix: "one small settings file was written so the assistant knows how to
  work here" — drop or de-emphasize the literal filename; a founder has no
  use for knowing it's called `CLAUDE.md`.

**M2 — CONSENT's HTML comment header names an atom id.**
- Artifact: `CONSENT.ro.md` / `CONSENT.ru.md` L5 ("Randat: 2026-07-07, atom
  ATOM-072." / "Рендер выполнен: 2026-07-07, атом ATOM-072."). Invisible in
  a rendered viewer, visible if a founder opens the raw file in a plain text
  editor.
- Fix: harmless as-is (comments are the right place for this), but if this
  file is ever handed to a founder as a raw `.md` rather than rendered,
  scrub it — low cost, zero benefit to leaving it.

**M3 — tonal mismatch between the cost line and the TEAM summary (flag upward, not this atom's to fix).**
- The cost line's symbolic register ("⚙ 0 агентов · 1 роль · глубина 0 ·
  возвратов verify 0 · $1.43") reads like an audit-log readout next to the
  TEAM summary's warm narrative ("Reviewed the finished work and said go —
  approved it."). The format is locked by INFO-006 P3 verbatim, so ATOM-072
  correctly did not redraft it — noting only that the two showcase artifacts
  will land in front of the same founder feeling noticeably different in
  register, worth a look at the next constitutional touch.

## 3. Named contradiction (SY9)

**My lens requires hiding all internal vocabulary from every founder-facing
surface, including CONSENT — even though the security/telemetry lens's whole
trust argument is built on maximal, filename-level transparency.**

`push.sh`'s own header and the CONSENT text both lean on "the script is
open — you can read every line" as the credibility mechanism, and the
whitelist that makes the deny-by-default promise auditable is, correctly,
five *exact* filenames: `STATUS.md`, `RESULT.md` (cost block only),
`run.log`, `status.yaml`, `VERDICT.md`. A security reviewer wants those
exact names in the consent text, verbatim, so a technically-inclined founder
(or their lawyer) can grep `push.sh` and confirm the promise word-for-word.
That is a legitimate, load-bearing transparency argument — and it is
*exactly* what produced finding B1.

I am not backing off B1. My lens still requires the paragraph a founder
reads to decide whether to sign to be in plain language — even if this
makes the whitelist marginally less directly greppable-by-a-founder against
the consent prose, which is friction the security lens would not choose on
its own. My proposed resolution (plain-language body + a separately labelled
"exact technical list" footnote) is a compromise, not a concession: it keeps
the security lens's exact-filename precision available to anyone who wants
it, while refusing to let it be the *only* text a signing founder reads. If
the security lens's verdict disagrees and wants the filenames inline as the
primary text, that is the real X-contradiction for synthesis to rule on —
I would not smooth it into "both are basically fine."

## 4. Cost of this look

Token estimate: reads (role file ~350 words; 7 setup-kit files ~2,200 words;
10 telemetry-showcase files ~3,900 words; PLAN.md + INPUT.md §1-§7 ~2,600
words; one grep pass) plus reasoning and this verdict's own prose (~2,600
words) — roughly **38k-45k tokens** all-in for this atom's execution,
comfortably inside the ~90k budget envelope (INPUT frontmatter) and the 30k
plan-line allocation was tight but the actual read set stayed close to the
PLAN's ~12k lens-read estimate; the rest went to cross-referencing findings
against `cost-line-spec.md` / `team-summary-spec.md` and writing this file.
