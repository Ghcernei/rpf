# SYNTHESIS-PROTOCOL — Synthesis & Perspective Protocol

| Field | Value |
| :---- | :---- |
| Product | Synthesis & Perspective Protocol v1 |
| Parent product | Recursive Product Framework v1 |
| Produced by | ATOM-016 (executor role: Framework Architect) |
| Maturity | `validated` — first real fan consumed end-to-end by ATOM-007 (M3; GATE-021, 2026-07-07) |
| Date | 2026-07-06 |
| Amended | ATOM-018, 2026-07-07 — first constitutional touch (queue T1–T10) |

This document closes the framework's horizontal axis. The four earlier documents decompose work by product size only (A4, K4) and bind exactly one role per atom (ATOM-SPEC §1.1); nothing obliges anyone to examine one question through several role-lenses; FEV-PROTOCOL judges the correctness of one product but no protocol reconciles divergent views into one; and fold-back lifts only accounting — status (SS3), cost (O4.2), maturity (M3) — never meaning. After this document, a formulating agent MUST derive a perspective map at Formulate time, MUST open per-lens sibling atoms on the same question where the fan triggers, a synthesis act names and resolves the contradictions between lenses, and the parent of every decomposition — perspective fan and ordinary mono-role decomposition alike — integrates its children's products into its own view.

---

## 0. How to Read This Document

- SP1 — Rule language (MUST / MUST NOT / SHOULD / MAY) carries the meanings of ATOM-SPEC R0.1. Numbered rules and tables are normative; passages marked *(informative)* bind nobody (R0.2).
- SP2 — Rule prefixes in this document: **SP** (this section), **PM** (perspective map), **LF** (lens fan), **SY** (synthesis act), **FB** (fold-back). None collides with the prefixes of the four earlier documents: R, A, F, C, U, RS, CL, K, V, M, L, E, O, T (ATOM-SPEC); P0, FP, VP, EP, DR, TP (FEV-PROTOCOL); LA, NC, KL, HP, RB, SM, BC (REPO-STRUCTURE); OD, MT, EC, GB, LP, SS, RC (ORCHESTRATION). Rules of all five documents are citable side by side.
- SP3 — **Id-space disambiguation** (the §0 discipline of ORCHESTRATION). Where letters could be confused, the space MUST be named:
  1. SP and SY share their first letter with soft criteria `S1..Sn` (FP1). A bare "S1" always names a criterion; SP and SY rules are always cited with the full prefix ("SP1", "SY1").
  2. FB shares its first letter with ATOM-SPEC's Formulate rules (F1–F6), FEV-PROTOCOL's FP rules, and finding ids `F1..Fn` (VP11). A bare "F1" never denotes an FB rule; FB rules are always cited with the full prefix.
  3. Contradiction ids `X1..Xn` (SY5) use a letter no document claims; they need no disambiguation but MUST be cited with their synthesis act where context allows doubt: "X1 of `<parent-atom-id>`-SYNTH".
- SP4 — Precedence: per R0.3 and P0.3, this document **tightens** the obligations of ATOM-SPEC, FEV-PROTOCOL, REPO-STRUCTURE, and ORCHESTRATION and **never relaxes** them. A statement here that appears to relax one is defective: the earlier document prevails, and the conflict MUST be reported — as a finding if discovered at verification, as trigger E7 if discovered at execution.
- SP5 — **New escalation trigger.** This document defines one new escalation trigger, **E8 — value conflict** (SY8). E8 continues ATOM-SPEC's E-numbering and joined its §5.7 trigger table per the migration discipline HP4/GB5 established (landed per ATOM-018). E8 is a trigger id in ATOM-SPEC's E-space, not a prefix of this document; its mechanics remain SY8's.
- SP6 — **Definitions.** A **lens** is a role (F2) applied to a stated question about a product: the same question, examined through different professional optics. A **perspective fan** is a set of sibling atoms, one per lens, each examining the same question over the same input products. A **synthesis act** is the atom that integrates the lens products of one fan into a single view. All three are ordinary framework objects: a lens atom and a synthesis act are atoms (A1) with every §1.3 mandatory field.

*(informative)* Prior art. The mechanics of §3 are extracted from an established human deliberation practice: each role states its position separately (what it sees, what worries it, what it proposes); conflicts between roles are shown whole, with the root of the disagreement named, never smoothed; options carry trade-offs and the condition on which each breaks; no fabricated consensus is ever presented; and one chair — the party who owns the outcome — makes the recorded decision. This document formalizes those mechanics; per RC3 the practice's tooling and names stay outside `framework/`.

---

## 1. Perspective Map — Formulate Duties

The map is the Formulate-side instrument of the horizontal axis: before any work runs, the formulating agent derives which lenses must examine the product.

- PM1 — **Duty.** Every Formulate act MUST produce a perspective map for the product being formulated, per the §6.1 template, before the atom (or the first atom of a plan) is instantiated. This tightens F1 and OD2 (per R0.3) for every atom formulated after this document's acceptance; earlier atoms are historical record, not amended (the MT1 discipline).
- PM2 — **Location.** No new file. When a decomposition plan exists (OD1), the map is a section of that plan; for a single-atom product, the map is a section added to the atom's `INPUT.md` (T1 permits extension). The map section joined the OD2 plan contents (item 7) and the ORCHESTRATION §8.2 template, per the HP4/GB5 migration discipline (landed per ATOM-018).
- PM3 — **Derivation.** Lenses are derived at Formulate time from the whole of the product — its JTBD, consumers, DoD, risks, and perimeter exposure — not taken from any fixed or templated lens list. The map states the one question the lenses would examine and, per lens, why the whole demands that optic. A lens without a stated derivation is not on the map.
- PM4 — **Opt-out.** The map MAY be reduced to the single recorded line `single lens — narrow question`, with a one-line justification. The opt-out is a logged deviation in the F3 discipline — justified in the map itself, never silent. An opt-out with no justification line is a Formulate defect.
- PM5 — **Weights and floors.** When the map names ≥ 2 lenses, it assigns budget weights — default equal — and no per-lens envelope may fall below that lens's EC1 floor (2× its read estimate). A fan whose lenses cannot each receive the floor within the parent's envelope (O6.1, OD4) is a Formulate defect and MUST be resolved before instantiation — by narrowing the question, merging lenses with a logged justification, or escalating for a larger envelope (the EP4 E4 row). It MUST NOT be resolved by starving a lens.
- PM6 — **Fan decision.** The map MUST record the evaluation of the three fan triggers:
  1. a decomposition plan exists for the product (OD1);
  2. maturity target ≥ `reviewed`;
  3. the product crosses the perimeter.
  When any trigger holds **and** the map names ≥ 2 lenses, the fan MUST be opened (§2). When no trigger holds, the formulating agent MAY open the fan; if it does not, the map is carried in the atom's `INPUT.md` and the executor's self-check (V1) SHOULD state how each mapped lens was considered in the product.
- PM7 — **Bounded artifact.** The map is authored inline at Formulate, from what the formulating agent already holds. Producing the map MUST NOT spawn sub-atoms; if identifying the lenses itself requires research, that research is ordinary decomposition under A4, not part of the map. *(informative)* This keeps the map's cost negligible against the fan it may trigger: it is one template-sized table, at the tier Formulate work already runs at (MT3).

---

## 2. Lens Fan

- LF1 — **Nature.** A lens atom is an ordinary atom: formulated by the same formulating agent with every §1.3 mandatory field plus MT1, its own folder per NC2 (slug naming the lens), own `INPUT.md`, `STATUS.md`, `RESULT.md`, and run log. Its `INPUT.md` MUST name the lens it carries and the shared question, and its executor role is the lens's role (F2 — created first if missing).
- LF2 — **Same question.** A fan exists only where the lens atoms examine the **same question** over the same input products; the siblings differ in role and DoD emphasis, not in subject. Sibling atoms producing different parts of a product are not a fan — they are ordinary A4 decomposition and fold back per §4.
- LF3 — **Budget.** Lens atoms are siblings inside the parent's envelope (O6.1), with per-lens envelopes per the map's weights and floors (PM5). The synthesis act's envelope is allocated in the same arithmetic and MUST appear in the plan's OD4 budget lines.
- LF4 — **Tiers.** Lens atoms MAY run at tier S or M where MT2 sufficiency holds (economy is taken on Execute — the MT3 principle; MT6 asymmetry stands). The synthesis act MUST run at tier L: this extends MT3 — quality is bought at Formulate, Verify, and Synthesis.
- LF5 — **Lens depth.** A lens MAY open sub-lenses on its own question. Every sub-lens level is charged against `recursion_allowance` in the same depth currency as any decomposition level (F6, default total depth 3; beyond allowance is E6). The default fan is flat: opening lens depth requires a logged justification (the O5.1 discipline).
- LF6 — **Synthesis is not verification.** Each lens atom's verification mode is assigned per FP8 and runs per FEV-PROTOCOL, unchanged. The synthesis act neither verifies nor accepts lens products, and no lens atom's verification is weakened because a synthesis follows (the P0.3 discipline).
- LF7 — **Cost visibility.** The cost block (O4.1) of a fan parent's `RESULT.md` MUST extend its O4.2 aggregation with per-lens subtree lines: one line per lens — the lens name and the aggregate cost of that lens's subtree (the lens atom plus its sub-lenses), in the parent's cost unit — plus one line for the synthesis act. Aligned to the transitive scheme (landed per ATOM-018): O4.2 was extended transitively by ATOM-SPEC O4.3, so a fan parent also carries the O4.3 fields — `total_descendants`, `max_depth_reached`, `subtree_cost` with the execute/verify/role_creation/synthesis breakdown — and each per-lens line reports that lens's subtree in the same transitive sense; the synthesis act's cost enters the breakdown under `synthesis`.

---

## 3. Synthesis Act

The operating manual for synthesis atoms — the twin of FEV-PROTOCOL §2 for reconciling perspectives instead of judging correctness.

### 3.1 Identity and formulation

- SY1 — **Identity.** A synthesis act is an atom (A1). Its id is `<parent-atom-id>-SYNTH` (a second and later fan of the same parent: `-SYNTH-2`, `-SYNTH-3`, …); its product folder is a sibling of the lens atom folders, the parent's folder slug suffixed `-synth`; its product, `SYNTHESIS.md`, lives at that folder's root (the VP6 pattern). The `-SYNTH` identifier joined the NC1 table and `SYNTHESIS.md` joined the NC7 reserved filenames of REPO-STRUCTURE, per the HP4/GB5 migration discipline (landed per ATOM-018).
- SY2 — **Formulation and sequencing.** The formulating agent of the fan formulates the synthesis act as part of the fan's plan. It MUST NOT be instantiated before every lens atom of the fan is delivered and has completed its assigned verification (OD5; M4 applies to the lens products it consumes).
- SY3 — **Executor.** The synthesis act's executor role is, by default, the role of the fan parent — the role that must own the integrated view (the chaired-decision mechanic: lenses advise, the chair integrates). A different role MAY be named in the plan with a logged justification (O5.1 discipline). Tier per LF4: always L.
- SY4 — **Input package.** The synthesis act's `INPUT.md` names exactly: the perspective map, the shared question, and the path of every lens deliverable. Lens run logs, workspaces, and executor reasoning in any form MUST NOT enter the package (the VP2 discipline): positions are judged as delivered products, not as deliberations.

### 3.2 Execution steps

- SY5 — The synthesis act MUST execute, in order:

| Step | Action | Output |
| :- | :---- | :---- |
| 1 | Read the map and every lens product; restate the shared question and each lens's position in own run log (U2 applies — a synthesis act runs the full cycle) | run-log entry |
| 2 | **Position pass**: extract each lens's position on the question — claim, evidence, recommendation | position table |
| 3 | **Contradiction pass**: name every contradiction between positions as `X1..Xn`, each with the lenses involved, each position with its evidence, and a classification per SY6 | contradiction list |
| 4 | **Reconciliation pass**: resolve each `fact` contradiction (SY7); route each `value` contradiction to the human (SY8) | reconciliations + gates |
| 5 | Write `SYNTHESIS.md` per the §6.2 template — the integrated view, with every contradiction and its resolution visible | the product |
| 6 | Maintain own `STATUS.md`, run log, and `RESULT.md` per ATOM-SPEC obligations | atom metadata |

### 3.3 Contradiction classification

- SY6 — Every contradiction is classified by its **nature**, never its magnitude:

| Class | Nature of the disagreement | Decided by |
| :---- | :---- | :---- |
| `fact` | About what is, was, will be, or costs. It would dissolve if all lenses held the same information, and an observation, measurement, or authoritative source that would settle it **can be named** | The synthesis act (SY7) |
| `value` | Survives shared information. About what should be preferred: priorities, risk appetite, trade-off weighting, time horizon, acceptability of consequences | The human, always (SY8) |

  The classification test is normative: *name the evidence that would settle this contradiction, such that every lens would accept it as settling.* A named, obtainable answer → `fact`. No such answer → `value`. A contradiction mixing both MUST be split into one `fact` and one `value` contradiction (the FP4 discipline). When classification remains in doubt after the test, classify `value` — doubt resolves toward the human (the MT6 asymmetry).

- SY7 — **Fact reconciliation.** The synthesis act resolves `fact` contradictions itself. Each reconciliation MUST state which position stands — or that neither stands, and what does — and the evidence that settles it, recorded in both the run log and `SYNTHESIS.md`. A reconciliation without named evidence is defective. If the settling evidence is neither in the package nor obtainable within the envelope, that is E1 (information gap) — not a judgment call.
- SY8 — **Value gate — trigger E8.** Every `value` contradiction escalates to the human. Mechanics:
  1. The synthesis act presents the contradiction in `SYNTHESIS.md` as a **named trade-off**: each position, what choosing it sacrifices, and exactly one recommendation (the EP2 discipline applied to a value choice).
  2. The formulating agent — never the synthesis executor (O8.2) — authors the gate brief per GB1–GB4, referencing the synthesis product's trade-off by path (GB3), and routes it to the human. The answer is recorded as a `gate` decision record (DR1, DR2 — a value choice is intent confirmation per O8.1).
  3. The synthesis act stands `blocked` (EP1, EP5) until every value gate of its fan is answered, then integrates the recorded choices and delivers.
  4. No participant may resolve a value contradiction in the human's place, at any threshold of size (the P0.3 discipline; classification is by nature, not magnitude).

| Trigger | Question set / brief authored by | Routed to | Record kind | Resumption |
| :- | :---- | :---- | :---- | :---- |
| E8 value conflict | Formulating agent, from the synthesis product's named trade-off (O8.2, GB3) | Human | `gate` | Choice recorded → synthesis resumes `running`, integrates the choice, delivers |

### 3.4 Anti-smoothing

- SY9 — For every lens in the map, `SYNTHESIS.md` MUST contain either at least one contradiction naming that lens, or an explicit justification of concurrence specific to that lens's position (the VP10 discipline). A generic clearance ("the lenses agree") is prohibited.
- SY10 — **No fabricated consensus.** The synthesis MUST NOT average positions, drop a dissent, weight positions by how many lenses hold them, or present a majority as unanimity. Every named contradiction remains visible in the product together with its resolution path. A synthesis that violates SY9–SY10 is defective and voids the act: it is redone, and the defect is a finding at its verification.
- SY11 — The synthesis act's own verification mode is assigned per FP8 like any atom's; its Verify checks SY9 coverage per criterion the way VP10 coverage is checked.

---

## 4. Semantic Fold-Back — Both Axes

- FB1 — **Duty.** The parent of **any** decomposition — a perspective fan (§2) or ordinary mono-role product decomposition (A4, K4) — MUST integrate its children's products into its own product before closing: an integration act in which the parent states what each child contributed to the parent's view and names the contradictions between children. Collection, concatenation, or aggregation without a stated integrated view is not integration. This tightens L7 (per R0.3): closure of a decomposition requires the semantic fold-back, not only the accounting one.
- FB2 — **Accounting unchanged.** Status (SS3), cost (O4.2, LF7), and maturity (M3) fold-back remain exactly as defined. FB adds the semantic layer; it replaces nothing.
- FB3 — **Cross-child contradictions.** Contradictions between children of an ordinary decomposition follow the same discipline as fan contradictions: numbered `X1..Xn`, classified per SY6; `fact` — the parent reconciles and logs per SY7; `value` — E8 to the human per SY8. The horizontal axis's conflict rules bind the vertical axis's fold-back.
- FB4 — **Evidence.** Integration is evidenced, per axis:
  1. **Fan:** the delivered synthesis product, folded into the parent's own product, and referenced in the parent's run-log acceptance entry at closure (L7 step 1).
  2. **Ordinary decomposition:** one integration entry in the parent's run log per child — contribution named, plus contradictions found or an explicit "concurs — no contradiction with siblings" — and a parent product that reflects the integrated view.
  A closure whose acceptance entry lacks this evidence is incomplete (the RB6 discipline applied to L7 step 1).

*(informative)* FB1 closes the audit's vertical finding: before this document, a parent could close by lifting status, cost, and maturity while its own product never absorbed what the children found — and no rule noticed.

---

## 5. Decision Coverage

Mapping of the accepted decisions D1–D7 (INFO-004, restated in ATOM-016 INPUT §3) to the rules implementing them (the RC4 discipline):

| Decision | Implemented by |
| :---- | :---- |
| D1 — map mandatory broadly, logged opt-out; fan selective on three triggers | PM1, PM4, PM6 |
| D2 — facts reconciled by synthesis with log; values always gate to human; by nature, not magnitude | SY6, SY7, SY8, FB3 |
| D3 — lenses siblings in parent envelope; map-assigned weights, default equal, per-lens floor; lenses S/M, synthesis always L | PM5, LF3, LF4 |
| D4 — sub-lenses in the same depth currency; default flat; opening depth justified | LF5 |
| D5 — semantic fold-back on both axes; contradictions named, not mere collection | FB1, FB2, FB3, FB4 |
| D6 — prior-art mechanics extracted (clash without smoothing; chaired decision), no branding | SY3, SY5, SY9, SY10 |
| D7 — per-lens subtree lines in fan parents' cost blocks, extending O4.2 | LF7 |

---

## 6. Templates

- SY12 — Copy the template verbatim and replace every `<angle-bracket>` placeholder (T1). Sections may be extended; mandatory parts MUST NOT be removed. These are the only two fenced blocks in this document (the T2 discipline): the perspective map (§6.1) and the synthesis product (§6.2).

### 6.1 Perspective map (PM1–PM6)

Embedded as a section of the decomposition plan (OD3) or of a single-atom product's `INPUT.md` (PM2) — never a separate file.

```markdown
## Perspective map — <product / atom id>

**Question under examination:** <the one question the lenses examine>

**Fan triggers (PM6):** decomposition plan = <yes | no>; maturity ≥ reviewed = <yes | no>;
crosses perimeter = <yes | no>.
**Fan decision:** <opened — mandatory | opened — elective | not opened: lenses addressed
by the single executor, see V1 self-check | opt-out per PM4>

| Lens | Role (F2) | Why the whole demands this optic | Weight | Tier |
| :---- | :---- | :---- | :---- | :---- |
| <lens> | <role-slug — created first if missing> | <one line, derived per PM3> | <default: equal> | <S | M> |

Synthesis act (when the fan opens): `<parent-atom-id>-SYNTH`, tier L (LF4),
envelope <amount + unit> — in the OD4 arithmetic (LF3).
Per-lens floor check (PM5): no lens below its EC1 floor — <holds | resolved by: <action>>.

Opt-out (only when used): single lens — narrow question — <one-line justification (PM4)>.
```

### 6.2 `SYNTHESIS.md` — the synthesis act's product (SY5–SY10)

```markdown
---
synthesis_atom: <parent-atom-id>-SYNTH
parent: <parent-atom-id>
question: <the shared question>
lenses: [<lens>, <lens>]
value_gates: [<GATE-NNN>, ...]        # decision records of E8 gates; [] if none
executor: <model id | person | system id>
date: <YYYY-MM-DD>
---

# SYNTHESIS — <parent-atom-id>: <question, short form>

## Positions (SY5 step 2)
| Lens | Claim | Evidence | Recommends |
| :---- | :---- | :---- | :---- |
| <lens> | <position on the question> | <what it rests on> | <what it proposes> |

## Contradictions (SY5 step 3)
### X1 — <fact | value> — <title>
- Lenses: <lens A> vs <lens B>
- <lens A>: <position + evidence>
- <lens B>: <position + evidence>
- Classification test (SY6): <the named settling evidence — or why none can exist>
- Resolution: <fact: reconciliation + settling evidence (SY7) | value: GATE-NNN —
  the human's recorded choice (SY8)>

## Per-lens concurrence (SY9)
| Lens | Contradictions naming it | If none: justification of concurrence, specific to this lens |
| :---- | :---- | :---- |
| <lens> | <X-ids, or —> | <specific justification, or —> |

## Integrated view
<the one view answering the question. Every contradiction's resolution visible;
no averaged positions, no dropped dissent (SY10).>

## Residual
<value choices as recorded, and what a future revisit should reopen — or "none">

## Handoff
Fold-back per FB1: the parent integrates this product into its own product (FB4 item 1).
```

---

## Appendix A — What This Document Does Not Define *(informative)*

- **Lens-role content** — which professional optics exist. Roles are created on demand per F2 and hardened by use; the map derives them per product (PM3), never from a catalog.
- **Verification mechanics** — FEV-PROTOCOL's ground, unchanged. This document adds only the synthesis act's identity (SY1), tier (LF4), and the E8 trigger (SY8).
- **Cost metering** — counters and units remain BC4/EC5 runtime concerns; LF7 fixes only what the fan parent's cost block must show.

*End of SYNTHESIS-PROTOCOL v1. A formulating agent holding the five framework documents knows which lenses must examine a product and when the fan opens; a synthesis act holding a map and the lens products needs nothing else to integrate them; and no parent closes a decomposition without folding its children's meaning back into its own product.*
