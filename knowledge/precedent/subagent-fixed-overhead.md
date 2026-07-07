# Precedent — Fixed subagent overhead dominates small atoms

**Source:** ATOM-007 Wave 0 (2026-07-07), five S-tier role atoms (ROLE-004..008).

**Measurement:** planned envelopes 12k tokens each (naive: reads ~3k + writes
~3k, ×2 margin). Real harness counters: 51,225–57,068 each; **total 267,420 vs
60,000 planned (~4.5×)**. Work delivered was exactly as scoped (37–41-line role
files, all H-criteria pass) — the overrun is not scope creep.

**Mechanism:** every spawned subagent carries a fixed cumulative cost of
**~45–50k tokens** independent of task size: system prompt + tool definitions
+ per-tool-call context re-reads. A 10-tool-call session re-bills its context
~10 times. The EC2/EC7 «+40k» term is hereby validated as a **per-subagent
fixed cost** — and it applies to S-tier atoms exactly as to L-tier ones.

**Rule of thumb (until a constitutional touch codifies it):**

> envelope(subagent atom) ≈ reads × K + **50k fixed**, K ∈ [2.5, 3.5]
> — the fixed term is charged per *spawn*, so batching tiny products into one
> subagent is ~n× cheaper than n subagents; the trade-off is lost isolation
> and lost role separation (F2, SY9 anti-smoothing) — never batch across
> lens boundaries or into a blind Verify.

**Consequences applied:** ATOM-007 tree re-projected ~1.3M realistic vs the
GATE-015 ~800k hard stop → E4 raised before Wave 1 (recorded in the atom's
run.log; gate record follows). Candidate for the next ORCHESTRATION touch:
add the fixed term to EC1's floor definition for subagent-instantiated atoms.

**Calibration series:** this is the 9th envelope measurement; see
`verify-envelope-calibration.md` for the verify-side series (×3.5+40k).
