---
id: GATE-001
date: 2026-07-05
kind: gate
status: answered
atom: framework-v1 (root product, pre-ATOM-001)
trigger: backfill
answered_by: Ghenadie (human risk-taker)
recorded_by: ATOM-002 (backfill per DR8)
---

# GATE-001 — Standalone harness, vendored conventions

## Question / Brief
Context: before formulating ATOM-001, reconnaissance of the leading method-as-files framework was performed to decide RPF's foundation. Trigger: F4 gate point (a) — after idea elaboration, before decomposition of Framework v1. Blocked: the entire Framework v1 decomposition (ATOM-001..006) — its INPUTs depend on the packaging and enforcement model. Options considered: (1) build RPF inside/on top of the existing framework — fastest start, but enforcement hooks run in the producer's own session, so blind verification and budget stops cannot be enforced; (2) standalone harness that vendors the proven conventions without depending on them — more build cost, enforcement becomes possible, conventions stay portable; (3) fully from scratch — maximal control, re-invents solved problems. Recommendation: option 2.

## Answer (verbatim)
Go — standalone harness; adopt the proven conventions (SKILL-style role packaging with minimal name+description frontmatter; append-only atomically-written run log per atom workspace; workspace-per-run folders; shared status-machine file for multi-atom products) — vendored, not depended upon; third-party frameworks are not named in normative text. Enforcement — blind verification, budget stops — cannot be built inside frameworks whose hooks run in the producer's own session; the harness is the moat.

*Reconstruction (DR5): sourced from `products/framework-v1/001-atom-spec/INPUT.md` §3.10 ("GATE-001 decision: standalone harness, vendored skeleton"), which records the acceptance by the human on 2026-07-05.*

## Consequences
Unblocked ATOM-001 (INPUT rewritten as v2, post-GATE-001) and the whole Framework v1 decomposition. Set the packaging conventions later fixed normatively in ATOM-SPEC (§6.3 ROLE template, O3.1 run log, O10.1 workspace hygiene, O10.2 status machine) and the platform-name ban that became DoD criterion H4 of ATOM-001 and ATOM-002.

## Fed back to
ATOM-001 `INPUT.md` §3.10 (v2 rewrite); ATOM-SPEC normative conventions (O3.1, O10.1, O10.2, §6.3); H4-style grep criteria in framework-product DoDs.
