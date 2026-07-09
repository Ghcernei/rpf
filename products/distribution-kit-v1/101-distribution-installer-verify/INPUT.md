---
atom: ATOM-101-VERIFY
product: verdict (accept | return with findings) on ATOM-101 — distribution installer kit
parent: ATOM-100
role: blind verifier (fresh context — you have seen nothing of this work before)
formulated_by: ATOM-100 orchestrator, 2026-07-10
model_tier: L (MT3 — verification never below L)
budget: ~170k tokens (package ~37k × 3.5 + 40k per knowledge/precedent/verify-envelope-calibration.md)
verification_mode: blind independent (VP4/SS6); executor will not see you, you judge products only
---

# ATOM-101-VERIFY — blind package (closed reading list)

Read ONLY these (VP20 slim package):

1. `products/distribution-kit-v1/100-distribution-kit/INPUT.md` — the DoD: H1–H11 hard, S1–S3 soft (S3 is the CEO's, do not judge it).
2. `products/distribution-kit-v1/101-distribution-installer/INPUT.md` — the executor's binding spec.
3. `distribution/` — everything: install.sh, dry-run.sh, lang/{en,ro,ru}.sh, README.{en,ro,ru}.md.
4. `products/distribution-kit-v1/101-distribution-installer/RESULT.md` — the self-check to be challenged.
5. `products/distribution-kit-v1/101-distribution-installer/workspace/` — scenario transcripts + SUMMARY.txt (harness evidence) + run.log (ONLY for checking that the 9 harness-checklist answers per `knowledge/reference/harness-checklist.md` are recorded — judge the products first, the log second).
6. `knowledge/reference/harness-checklist.md` — the 9-point discipline the builder claims to have walked.

## Your job

Adversarial, evidence-first:

1. **Re-run, don't trust:** execute `bash distribution/dry-run.sh` yourself in a sandbox and compare with the committed transcripts. A scenario that fails on your run refutes the self-check regardless of what RESULT.md says.
2. **Check every H against the artifact, not the claim:** e.g. H2 — count the interview questions in the code path (must be exactly 7, closed); H3 — trace resume logic over install-state.json; H4 — run the negative grep for the token across state/log/telemetry/git yourself; H9 — find the 2-attempt limit in code, try to construct a path where a third auto-retry happens; H10 — verify the disabled branch truly leaves no running agent; H11 — verify fetch touches release tags only (never main) and apply is gated on explicit «да» with reconciliation shown.
3. **Language layer:** spot-check en/ro/ru strings for substance-identity and method jargon (atom/verify/FEV/gate must not appear in user-facing lines); judge S1 (non-technical founder bar) and S2 (BotFather walkthrough truly hand-holding) as the Verify-side judge.
4. **Deviations:** RESULT documents «telemetry step records consent only» — judge whether that satisfies H2's telemetry point (show-what-leaves before asking) or defeats it.
5. **Harness discipline:** confirm the 9 checklist answers exist in run.log; a skipped point without logged justification is a finding.

## Verdict format (write to `products/distribution-kit-v1/101-distribution-installer-verify/VERDICT.md`)

- First line: `ACCEPT` or `RETURN`.
- Findings numbered F1..Fn, each: severity (blocking | minor), the H/S criterion it hits, the exact file:line or transcript evidence, and what would make it pass.
- Minors do not force RETURN if the H-criteria all hold; blocking findings always do.
- End with your real token cost estimate and a one-line justification of the verdict.

Rules: no edits to any file outside your own atom folder; no git; no contact with anyone — your VERDICT.md and final message are the whole product.
