# FEV-PROTOCOL — Formulate / Execute / Verify & Escalation Protocol

| Field | Value |
| :---- | :---- |
| Product | FEV & Escalation Protocol v1 |
| Parent product | Recursive Product Framework v1 |
| Produced by | ATOM-002 (executor role: Framework Architect) |
| Maturity | `reviewed` (target) |
| Date | 2026-07-05 |

This document turns the FEV interface fixed in ATOM-SPEC (L5–L6, L10, E1–E7, §5.8) into an executable protocol. It binds every participant: formulating agents, executors, Verify atoms, and the human. After this document, no participant improvises the mechanics of checking, returning, escalating, or recording decisions.

ATOM-SPEC remains the contract. Per R0.3 this protocol tightens ATOM-SPEC obligations and never relaxes them. If any statement here appears to relax an ATOM-SPEC obligation, the statement is defective: ATOM-SPEC prevails, and the conflict MUST be reported — as a finding if discovered at verification, as trigger E7 if discovered at execution.

---

## 0. How to Read This Document

- P0.1 — Rule language (MUST / MUST NOT / SHOULD / MAY) carries the meanings of ATOM-SPEC R0.1. Numbered rules and tables are normative; passages marked *(informative)* bind nobody.
- P0.2 — Rule prefixes in this document: **FP** (Formulate protocol), **VP** (Verify protocol), **EP** (Escalation protocol), **DR** (Decision recording), **TP** (Templates), **P0** (this section). None collide with ATOM-SPEC prefixes; rules of both documents are citable side by side in findings and run logs.
- P0.3 — **Self-waiver prohibition, generalized.** O6.2 prohibits self-waiving the budget envelope. The same prohibition applies to every control in this protocol: no participant may relax a control assigned to its own work — verification mode (A8), the blind package (VP2), the return limit (VP15), gate placement (F4), re-verify scope (VP16), or the recording duties of §4. Only the human may relax a control, and only as a recorded risk acceptance (DR2, kind `risk-acceptance`).

*(informative)* Precedent ATOM-000: the executor overran its budget 2× and waived its own envelope. That waiver path is closed by O6.2, and P0.3 closes every analogous path. The canonical positive precedent is the ATOM-001 verification run, reproduced step by step in §2.7.

---

## 1. Formulate Protocol

Performed by the formulating agent as part of its §2.0 obligations (F1–F6). This section fixes the mechanics F1–F6 leave open: how DoD criteria are authored, how verification depth is assigned in practice, and how gates are placed.

### 1.1 DoD authoring

- FP1 — DoD criteria MUST be numbered: hard criteria `H1..Hn`, soft criteria `S1..Sn`. Numbering is stable for the life of the atom: findings, verdicts, and decision records cite criteria by these numbers.
- FP2 — Every hard criterion MUST state, within the criterion itself, the check that decides it — a command, count, measurement, or named test — precisely enough that two independent runs of the check reach the same verdict (A7 made operational).
- FP3 — Every soft criterion MUST name its judge inline: "— judge: Verify agent" or "— judge: human" (A7). A criterion with no named judge MUST be rewritten or removed before the atom is instantiated.
- FP4 — A criterion that mixes machine-checkable and judgment content MUST be split into one hard and one soft criterion.
- FP5 — Every criterion MUST be evaluable from the blind package alone (VP2). A criterion that can only be judged with access to executor reasoning or parent history is unverifiable and MUST be rewritten at Formulate time.
- FP6 — The DoD MUST state the maturity target and close with the gold-plating boundary (M2): the executor spends nothing pushing the product past the target.
- FP7 — Aspirational language is prohibited in criteria. Each soft criterion SHOULD be phrased as a question its judge can answer with findings or a justified "no findings" (VP10) — not as a wish ("high quality", "reads well") with no decidable content.

### 1.2 Verification-depth assignment

- FP8 — The formulating agent MUST assign the verification mode by evaluating the F3 risk mapping in this order, stopping at the first match, and recording the outcome in the atom's `INPUT.md`:
  1. Crosses the perimeter, irreversible, high criticality, or regulatory relevance → `independent + human`.
  2. Medium criticality, OR feeds ≥ 2 downstream atoms, OR maturity target ≥ `reviewed` → `independent`.
  3. Otherwise → `self`.
- FP9 — Overrides of the F3 row are asymmetric: an **upward** override (more verification than the row requires) needs only the logged justification of F3/M1. A **downward** override (less verification than the row requires) is a relaxation and, per P0.3, MUST be approved by the human as a recorded risk acceptance before instantiation. A downward override below the maturity minimum of M1 is prohibited outright.
- FP10 — The assigned mode binds the executor (A8) and the Verify atom alike; neither may substitute a weaker check.

### 1.3 Gate placement

- FP11 — The formulating agent MUST scan the product plan for the three F4 gate points — after idea elaboration, before expensive execution, before anything leaves the perimeter — and place a named gate at each point that exists for the product. Placed gates are listed in `INPUT.md` §7; absence is recorded as "none — trigger gates only".
- FP12 — Trigger gates (E4 budget breach; the E5 path after exhausted returns) exist implicitly on every atom (F4) and are never listed.
- FP13 — When a placed gate is reached (E3), the formulating agent — never the executor whose work is gated (O8.2) — authors the gate brief per the `GATE-BRIEF.md` template (§5.3) and routes it per EP4. The human's answer is recorded as a `gate` decision record (§4).

---

## 2. Verify Protocol

The operating manual for Verify atoms, and for the parents who formulate them. A Verify atom is itself an atom (L10): it has an `INPUT.md`, its own `STATUS.md`, its own run log and `RESULT.md`, and its product is a verdict.

### 2.1 Formulating the Verify atom

- VP1 — At lifecycle step L5, the formulating agent of the verified atom MUST formulate the Verify atom. The executor MUST NOT formulate, instantiate, brief, or otherwise influence the Verify atom that checks its own product (A9).
- VP2 — **The blind package.** The Verify atom's `INPUT.md` contains exactly:
  1. The target atom's DoD, verbatim (its `INPUT.md` §5).
  2. Paths to every deliverable file the DoD names — including `RESULT.md` and `STATUS.md` when criteria reference them.
  3. Paths to the reference standards the DoD criteria cite (this protocol, ATOM-SPEC, named schemas) — required to run the checks.
  4. The verification round number and returns used so far (VP15).
  Nothing else. The executor's run log, workspace, parent history, and executor reasoning in any form MUST NOT enter the package (L5, L10).
- VP3 — When `RESULT.md` enters the package, the executor's self-check claims are claims, not evidence. Verify MUST re-run every hard criterion itself and form its own judgment on every soft criterion it judges. Copying a self-check result into a verdict is rubber-stamping and voids the verification.
- VP4 — Instantiation: fresh isolated context (the `session` semantics of L2), regardless of how the verified atom was instantiated. A verification whose context was shared with the executor or the parent is void — it counts as not performed and MUST be redone; it does not consume a return.
- VP5 — **Capability and economics.** Verify runs at high capability — not below the capability class of the executor that produced the product. Verify cost is allocated by the formulating agent from its own envelope (O6.1) and reported as a separate line in its cost aggregation (schema per O4.2). Verification cost is a governance cost of the parent, never deducted from the executor's envelope.
- VP6 — Identity and location: the Verify atom's id is `<target-atom-id>-VERIFY`; its product folder is a sibling of the target atom's folder, suffixed `-verify`. Its product, `VERDICT.md`, lives at that folder's root.

### 2.2 Execution steps

- VP7 — The Verify atom MUST execute, in order:

| Step | Action | Output |
| :- | :---- | :---- |
| 1 | Read the DoD; restate every criterion in own run log (U2 applies — a Verify atom runs the full cycle) | run-log entry |
| 2 | **Hard pass**: run every hard criterion by its stated check (FP2); capture command and raw output | evidence rows |
| 3 | **Soft pass**: judge every soft criterion assigned to the Verify agent; mark human-judged criteria deferred (VP9) | findings or per-criterion justifications |
| 4 | Compose findings (VP11); decide verdict (VP12) | findings list |
| 5 | Write `VERDICT.md` per the §5.1 template, including the return instruction when returning (VP14) | the product |
| 6 | Maintain own `STATUS.md`, run log, and `RESULT.md` per ATOM-SPEC obligations | atom metadata |

- VP8 — A failed hard criterion is automatically a `blocking` finding. No judgment is involved; the evidence is the check output.
- VP9 — Criteria whose named judge is the human MUST NOT be judged by the Verify atom. They are marked "deferred to human judge" in the verdict and resolved at the human step (VP18). A deferral is not a finding.
- VP10 — **Anti-rubber-stamp.** For every soft criterion the Verify agent judges, the verdict MUST contain either at least one finding citing that criterion, or an explicit justification of "no findings" specific to that criterion. A generic clearance ("all soft criteria look fine") is prohibited. A verdict lacking this per-criterion coverage is defective, and the verification MUST be redone (without consuming a return).

### 2.3 Findings and verdict

- VP11 — Findings are numbered `F1..Fn`. Each finding MUST carry all three fields; a finding missing any field is invalid and MUST NOT enter a fix list:
  1. **Severity** — per the table below.
  2. **Citation** — the DoD criterion (Hn/Sn) or the rule id (ATOM-SPEC or this protocol) it violates.
  3. **Evidence** — a quote, count, command output, or file-and-line reference.

| Severity | Meaning | Effect on verdict |
| :---- | :---- | :---- |
| `blocking` | A hard criterion failed, or the product defeats its JTBD | `return` mandatory (or E5 if returns exhausted) |
| `substantive` | Defect that would propagate to consumers or misdirect downstream atoms | `return` mandatory |
| `minor` | Local defect; no propagation risk | Does not alone force a return |

- VP12 — The verdict is exactly `accept` or `return` (L5). Any open `blocking` or `substantive` finding forces `return`. With only `minor` findings open, the Verify atom MAY issue `accept` — the minor findings remain in the verdict and transfer to the parent's run log at closure (L7). When the verdict is `return`, ALL open findings, including minors, enter the fix list.
- VP13 — The verdict section references findings by number. No fix-list entry may exist without a corresponding finding.

### 2.4 Return instruction

- VP14 — On `return`, the Verify atom MUST write into `VERDICT.md` a **minimal, closed fix list**: one entry per finding, each stating the smallest change that clears the finding, terminated by the sentence: *"Apply minimally and redeliver; do not change anything else."* The executor MUST apply exactly the fix list. Rework outside the fix list is itself a finding on re-verify (severity per VP11, judged by Verify). If the executor believes a fix-list entry is factually wrong or unimplementable, it MUST NOT skip or reinterpret it — it raises one consolidated question set to the formulating agent (EP2 routing as for E7) before reworking.
- VP15 — **Return accounting.** A verification allows a maximum of 2 returns (L6). The count belongs to the verification of the target atom, not to any Verify-atom instance, and MUST be stated in every verdict's frontmatter (`round`, `returns_used`). A third failed verification is E5: the Verify atom writes the round-3 verdict as `return`, and the formulating agent routes the product plus all verdicts to the human (EP4).

### 2.5 Re-verify

- VP16 — Scope of a re-verify (round ≥ 2), in order:
  1. Full hard-criteria re-run — cheap by FP2 construction.
  2. Delta inspection: each fix checked against the finding it answers.
  3. No-drift spot-check: confirm nothing outside the fix list moved (compare against the returned version).
  4. Full soft re-read ONLY if a fix touches meaning broadly; the yes/no and its reason are recorded in the verdict.
- VP17 — Each round produces a fresh verdict. The current verdict is always `VERDICT.md`; when superseded, the prior round's file is renamed `VERDICT-round-<k>.md` and kept unmodified. Verdicts are never edited — only superseded whole.

### 2.6 After the verdict

- VP18 — On `accept`: the parent records acceptance in its run log and closes per L7; the accepted product's maturity is conferred per M3. For mode `independent + human`, the parent then presents to the human: the product, all verdict rounds, and the criteria deferred per VP9. The human's acceptance is recorded as a `gate` decision record (go = accept); for maturity target `production`, it is recorded as a `risk-acceptance` instead (§5.8 of ATOM-SPEC, maturity table).
- VP19 — If the human declines after Verify accepted, that is a gate `no-go` or `pivot`: the parent reformulates or abandons the atom. A human decline is not a Verify return and does not touch the VP15 counter.

### 2.7 Canonical run *(informative)*

The ATOM-001 verification, mapped to this protocol — the run this protocol must reproduce without improvisation:
blind package = DoD + `framework/ATOM-SPEC.md` (VP2) → hard pass by script (VP7 step 2) → soft pass yields two findings: F1 `substantive`, a template defect that would propagate to every future atom; F2 `minor`, a wording contradiction (VP11) → verdict `return`, fix list of two entries, closed (VP12, VP14) → executor applies exactly the fixes and redelivers → re-verify: hard re-run, delta inspection of both fixes, no-drift spot-check, no soft re-read needed (VP16) → verdict `accept` (VP17) → human sign-off recorded (VP18; record GATE-002).

---

## 3. Escalation Protocol

- EP1 — An escalation is a product (A2): a consolidated question set (O7.1) written to the file bus, plus a `STATUS.md` transition to `blocked` (L8) with the decision-record id in the note. Escalating through any other channel is not an escalation (O1.1).
- EP2 — **Question-set format** (CL2 made operational). One consolidated set per stop (O7.1), containing:
  1. Context — which atom, what it produces, where it stopped.
  2. Trigger id (E1–E7).
  3. What exactly is blocked — the DoD criterion, step, or decision affected.
  4. Options considered — 2 or 3, each with a one-line trade-off.
  5. Recommendation — exactly one.
  6. Resumption — what resumes, and where, once answered.
  A second question set from the same stop is prohibited unless the first answer itself creates a new blocker.
- EP3 — **Delivery.** The escalating party creates the decision record (§4) in `status: pending` with the question set filled in, and references the record id in its `STATUS.md` note and run log. The answer completes the same record. For E3 gates, the formulating agent creates the record and attaches the gate brief (FP13).
- EP4 — **Routing per trigger:**

| Trigger | Question set / brief authored by | Routed to | Record kind | Resumption |
| :- | :---- | :---- | :---- | :---- |
| E1 information gap | Executor | The party that owns the answer — the human only when only the human knows; else the formulating agent or the knowledge layer | `information` | Answer recorded → `running` (CL3) |
| E2 risk threshold | Executor (or formulating agent) | Human risk-taker | `risk-acceptance` | Acceptance recorded → `running`; declined → parent reformulates, atom → `failed` |
| E3 placed gate | Formulating agent — never the executor (O8.2) | Human | `gate` | go → `running`; pivot → reformulate; no-go → `failed` |
| E4 budget breach | Executor (after the O6.2 hard stop) | Formulating agent; human gate if the parent cannot cover it from its own envelope (O6.1) | `gate` when the human decides; otherwise parent decision logged in both run logs | New envelope allocated → `running` |
| E5 3rd verification failure | Verify atom (round-3 verdict); formulating agent assembles the package | Human | `gate`; if the human accepts the product as-is, additionally a `risk-acceptance` | Per the human's answer: accept / reformulate / abandon |
| E6 depth exceeded | Executor | Formulating agent | None by default (reformulation is a parent act); `gate` if depth beyond 3 is requested (F6) | Reformulated atom replaces this one |
| E7 input contradiction | Executor | Formulating agent; the human when the human formulated the input | `information` | `INPUT.md` amended by the formulator — never by the executor (U3) → `running` |

- EP5 — **Resumption rule.** An atom resumes `running` only after the answer is recorded in the decision record (`status: answered`) and referenced from the atom's run log (CL3). Answers delivered by any other channel are not authoritative until recorded.
- EP6 — **E4 mechanics.** Stop means stop: freeze work at the current file state — no "one more small step". Then: `STATUS.md` → `blocked` with projected total vs. envelope; question set per EP2 with options from {reallocate, descope, abandon}; wait. Finishing first and reporting afterwards is prohibited (O6.2). *(informative)* This rule exists because ATOM-000 did the opposite.
- EP7 — **Feedback duty** (O8.3 made operational). The party that receives a human answer MUST, before its atom closes, either update the feedback target — role spec, knowledge file, or a proposed rule change — and record where in the decision record's *Fed back to* section (DR6), or record there why no feedback target exists. The purpose test: the same question type asked twice with no feedback in between is a protocol defect.

---

## 4. Decision Recording

- DR1 — One file per decision under `/decisions/`. Filename: `<KIND>-<NNN>-<slug>.md` where KIND ∈ {`INFO`, `RISK`, `GATE`}, NNN is zero-padded and sequential per KIND, and the slug is kebab-case.
- DR2 — The three record kinds map to the three human products (O8.1):

| KIND | kind field | Human product | Produced at |
| :---- | :---- | :---- | :---- |
| `INFO` | `information` | Missing information | E1 answers; E7 input corrections |
| `RISK` | `risk-acceptance` | Recorded acceptance of a named risk | E2; `production` sign-off (VP18); E5 accept-as-is; every P0.3 / FP9 relaxation |
| `GATE` | `gate` | Intent confirmation: go / no-go / pivot | E3 placed gates; E4/E5 human decisions; human acceptance in `independent + human` mode (VP18) |

- DR3 — The record id is assigned when the record file is created, in creation order per KIND. Gates placed at Formulate time are named by position in `INPUT.md` §7 and receive their `GATE-NNN` id when the brief is delivered.
- DR4 — Mandatory frontmatter fields: `id`, `date`, `kind`, `status` (`pending` | `answered`), `atom` (the atom that raised or is gated), `trigger` (E1–E7 or `backfill`), `answered_by`, `recorded_by`. Mandatory sections: *Question / Brief*; *Answer (verbatim)*; *Consequences*; *Fed back to*.
- DR5 — The answer is recorded **verbatim** — the answering party's words, not a paraphrase. Backfilled or reconstructed answers MUST name their source document and be marked as reconstructions.
- DR6 — The *Fed back to* section records where the answer was propagated (EP7): the role spec, knowledge file, or rule updated — or "none: <reason>". It is the only section that may be updated after the record reaches `answered`.
- DR7 — Records are frozen once `answered`, except *Fed back to* (DR6). A wrong record is never edited: a superseding record is created and cross-referenced in both directions.
- DR8 — **Backfill.** Decisions that predate this protocol MAY be recorded retroactively by a framework atom: `trigger: backfill`, DR5 source-naming mandatory. The three founding records — `GATE-001` (standalone harness), `RISK-001` (execution-platform stance), `GATE-002` (ATOM-001 acceptance) — are the validation examples of the §5.2 template.

---

## 5. Templates

- TP1 — Copy the template verbatim and replace every `<angle-bracket>` placeholder (T1 applies). Sections may be extended; mandatory fields and sections MUST NOT be removed.
- TP2 — These are the only three fenced blocks in this protocol (the discipline of T2).

### 5.1 `VERDICT.md` — findings + verdict (the Verify atom's product)

```markdown
---
verify_atom: <TARGET-ATOM-ID>-VERIFY
target_atom: <TARGET-ATOM-ID>
product: <path(s) verified>
round: <1 | 2 | 3>
returns_used: <0 | 1 | 2>
verdict: <accept | return>
executor: <model id | person | system id>
date: <YYYY-MM-DD>
---

# VERDICT — <TARGET-ATOM-ID>, round <n>: <accept | return>

## Blind package received
<the files listed in the Verify INPUT — DoD source, product paths, cited standards. Nothing else was read.>

## Hard criteria — re-run
| Criterion | Check run | Output | Result |
| :---- | :---- | :---- | :---- |
| H1 | <command / measurement> | <raw output> | pass / fail |

## Soft criteria — judged
| Criterion | Judge | Outcome |
| :---- | :---- | :---- |
| S1 | Verify | finding F<n> / "no findings" — justification: <specific to this criterion> |
| S<n> | human | deferred to human sign-off (VP9) |

## Findings
### F1 — <blocking | substantive | minor> — <title>
- Cites: <DoD criterion or rule id>
- Evidence: <quote / count / command output / file:line>

## Verdict
<accept | return>, per findings <F-numbers, or "none — justifications above">.

## Return instruction (only when verdict = return)
Fix list (closed):
1. F1 — <the smallest change that clears the finding>
Apply minimally and redeliver; do not change anything else.

## Re-verify notes (rounds ≥ 2 only)
<delta inspection per fix; no-drift spot-check result; soft re-read: yes/no + reason (VP16)>
```

### 5.2 Decision record

```markdown
---
id: <INFO | RISK | GATE>-<NNN>
date: <YYYY-MM-DD>
kind: <information | risk-acceptance | gate>
status: <pending | answered>
atom: <atom id that raised the escalation or is gated>
trigger: <E1..E7 | backfill>
answered_by: <human name | role>
recorded_by: <atom id or role that wrote this record>
---

# <ID> — <title>

## Question / Brief
<the EP2 question set: context; trigger; what is blocked; options (2–3, one-line
trade-offs); recommendation; resumption. For gates: the gate brief or its path.>

## Answer (verbatim)
<the answering party's words, unparaphrased. Backfilled records: name the source
document and mark the answer as a reconstruction (DR5).>

## Consequences
<what this unblocks or changes; which atoms may now proceed.>

## Fed back to
<role spec / knowledge file / rule updated per O8.3 and EP7 — or "none: <reason>".
The only section that may be updated after status: answered (DR6).>
```

### 5.3 `GATE-BRIEF.md`

```markdown
---
gate: <GATE-NNN, or the formulate-time gate name if the id is not yet assigned>
atom: <gated atom id>
author: <formulating agent id — never the gated executor (O8.2)>
date: <YYYY-MM-DD>
budget_spent: <amount + unit>
budget_ahead: <estimate + unit>
---

# GATE BRIEF — <gate name>

## Current status
<where the product stands; STATUS state; what already exists on the file bus.>

## Economics
Spent so far: <amount + unit>. Cost ahead (estimate): <amount + unit>.

## Options
| # | Option | Trade-offs |
| :- | :---- | :---- |
| 1 | <option> | <one line> |
| 2 | <option> | <one line> |

## Recommendation
<exactly one of the options, with a one-line rationale.>

## Decision requested
go / no-go / pivot — the answer will be recorded as a GATE decision record (DR1, EP3).
```

---

*End of FEV-PROTOCOL v1. A Verify atom holding this document, a DoD, and a product needs nothing else to run an acceptance; an escalating atom needs nothing else to stop correctly.*
