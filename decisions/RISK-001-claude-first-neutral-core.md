---
id: RISK-001
date: 2026-07-05
kind: risk-acceptance
status: answered
atom: framework-v1 (root product, pre-ATOM-001)
trigger: backfill
answered_by: Ghenadie (human risk-taker)
recorded_by: ATOM-002 (backfill per DR8)
---

# RISK-001 — Claude-first execution on a platform-neutral core

## Question / Brief
Context: RPF atoms need a concrete runtime to execute on today. Trigger: E2-class decision — committing execution to a single vendor's agent runtime concentrates operational and commercial dependency, and the consequences of baking that dependency into the framework's normative core would be effectively irreversible. Blocked: instantiation strategy for all Framework v1 atoms. Options considered: (1) write the framework against the chosen runtime directly — cheapest now, lock-in forever; (2) platform-neutral, embodiment-agnostic normative core with runtime-specific bindings isolated under `/runtime/<platform>/`, executing Claude-first today — small ongoing discipline cost (neutrality tests in every DoD), preserves exit; (3) multi-runtime from day one — highest cost, premature. Recommendation: option 2.

## Answer (verbatim)
Claude-first execution, platform-neutral and embodiment-agnostic core: the spec must contain zero platform-specific instructions AND zero hidden assumptions that the executor is a chat LLM. An executor may be a language model, a script, a human, or a robotic system whose DoD is checked by sensors. Test: a competent human could execute an atom by reading the docs alone. Runtime-specific bindings live separately under `/runtime/<platform>/`.

*Reconstruction (DR5): sourced from `products/framework-v1/001-atom-spec/INPUT.md` §3.11 ("Platform & embodiment stance"), an accepted decision of the human formulator dated 2026-07-05. The named risk — single-runtime operational dependency — is accepted for the execution layer only; the core carries none of it.*

## Consequences
Unblocks execution of all Framework v1 atoms on the current runtime without waiting for multi-runtime support. Obligates every framework product to pass platform-neutrality checks (the H4 grep criteria of ATOM-001/ATOM-002) and executor-neutral phrasing (ATOM-SPEC R0.4). Future runtime bindings are additive (`/runtime/<platform>/`), never core changes.

## Fed back to
ATOM-SPEC R0.4 (executor neutrality) and Appendix A (runtime bindings isolated); DoD criterion H4 of ATOM-001 and ATOM-002; FEV-PROTOCOL contains no platform names in normative text.
