---
atom: ATOM-007-SYNTH
product: SYNTHESIS.md — the synthesis act of the ATOM-007 fan (SYNTHESIS-PROTOCOL §3, SY1–SY12)
parent: Pilot Prerequisites v1 (ATOM-007)
formulated_by: formulating agent (launch session), 2026-07-07
verification: per SY (fact reconciliations logged; value conflicts → E8 human gate; the act itself is consumed by the parent and G2)
maturity_target: draft
instantiation: subagent
model_tier: L (LF4 — the synthesis act MUST run at tier L)
budget: ~110k tokens
recursion_allowance: 0
---

# ATOM-007-SYNTH — Input Specification (synthesis act)

You are the synthesis act of the framework's **first real lens fan**. Chair
role: venture-strategist (`roles/venture-strategist.md` — read it first).
Governing rules: `framework/SYNTHESIS-PROTOCOL.md` §3 (SY1–SY12) — read §3 and
§6.2 only.

## 1. Identity
| Field | Value |
| :---- | :---- |
| Atom ID | ATOM-007-SYNTH |
| Product | `products/pilot-prerequisites-v1/007-synth/SYNTHESIS.md` per SYNTHESIS-PROTOCOL §6.2 |
| Consumer(s) | ATOM-007 (parent closure, FB4 fold-back); ATOM-077 intake design; G2 brief; the human at the E8 gate if you raise one |
| Budget envelope | ~110k tokens |

## 2. The fan you synthesize
The shared question was: **«Дают ли эти пререквизиты пилоту стартовать и быть
измеренным безопасно?»** Four lens verdicts (read all four, in full):
1. `products/pilot-prerequisites-v1/073-lens-founder-ux/LENS-VERDICT.md` — yes-with-conditions; 3 blocking / 5 significant / 3 minor
2. `products/pilot-prerequisites-v1/074-lens-token-economics/LENS-VERDICT.md` — yes-with-conditions; 1 blocking / 3 significant / 1 minor
3. `products/pilot-prerequisites-v1/075-lens-security-telemetry/LENS-VERDICT.md` — yes-with-conditions; 3 blocking / 1 significant / 3 minor
4. `products/pilot-prerequisites-v1/076-lens-owner-capacity/LENS-VERDICT.md` — NO; 1 blocking / 1 significant / 4 minor

Context you may also read (nothing else):
- The perspective map: `products/pilot-prerequisites-v1/007-pilot-prerequisites/PLAN.md` (map section + product tree)
- The parent question set: `products/pilot-prerequisites-v1/007-pilot-prerequisites/INPUT.md` §2–§5
- Blind-verify minors on the same products (a separate scrutiny stream — weigh, do not re-verify): the Findings sections of `products/pilot-prerequisites-v1/071-setup-kit-verify/VERDICT.md` and `072-telemetry-showcase-verify/VERDICT.md`
You do NOT read the underlying artifacts themselves (the lenses did that);
where two lenses disagree about a checkable FACT of an artifact, you MAY open
exactly that file at exactly that location to adjudicate — log each such look.

## 3. Job (SY5–SY10)
1. **Classify every cross-lens tension as fact or value (SY6).** Fact conflicts
   (one lens is checkably wrong, or both partly right about different spots):
   reconcile yourself, with a log line each. Value conflicts (both lenses right
   within their optics; the trade-off is a preference): do NOT resolve — carry
   to §4's E8 block. Known candidates (verify them, do not assume):
   machinery-hiding vs consent transparency (073×075); content-blindness vs
   team-legibility — render.sh reading INPUT.md (075 internal, touches 072's
   design); SLA feasibility vs Flow Support design (076 vs the pilot-design
   SLA); cost-line rate honesty (074 vs 072's $8/M assumption).
2. **Per-lens coverage (SY9):** one paragraph per lens — what it uniquely saw
   that the others structurally could not; its named contradiction and where
   it landed (reconciled-as-fact / carried-as-value / dissolved-with-reason).
   No smoothing: if lenses genuinely disagree, the disagreement survives into
   the record.
3. **Consolidated answer** to the shared question: yes / yes-with-conditions /
   no — with the exact conditions, each traceable to a lens finding id.
4. **Fix-priority register:** every blocking and significant finding across
   all four verdicts + the 6 verify minors, deduplicated, each with: source
   (lens/verify id), artifact, one-line fix direction, and WHO decides
   (executor-fixable / needs-CEO-at-E8-or-G2). This register is what ATOM-077
   and the G2 brief will consume.
5. **E8 block (SY8):** the value conflicts, each stated as a clean human
   choice: «X или Y — обе стороны правы в своей оптике; выбор — ценностный»,
   with a one-line recommendation and its cost. If none survive as true value
   conflicts, state why explicitly.

## 4. Deliverable
`SYNTHESIS.md` per SYNTHESIS-PROTOCOL §6.2 (follow its template sections
exactly; where this INPUT's §3 asks for more than the template minimum, add
sections — never subtract). Plain language; the register in Russian (the CEO
reads it at E8/G2).

## 5. Obligations
Write `STATUS.md`, `RESULT.md`, `workspace/run.log` in
`products/pilot-prerequisites-v1/007-synth/`. Do NOT touch status.yaml. You do
not spawn sub-atoms. Your chat reply is a signal; the files are the product.
