# RESULT — ROLE-005

**Product:** `/Users/ghcernei/Work/rpf/roles/founder-ux-reviewer.md`

**Maturity:** draft

**Verdict:** ALL HARD CRITERIA PASS

## Definition of Done — Hard Criteria Check

| Criterion | Check | Result | Evidence |
| :---- | :---- | :---- | :---- |
| **H1** | File exists, 30–50 lines, follows venture-strategist section set; frontmatter states atoms needing this role | PASS | `/Users/ghcernei/Work/rpf/roles/founder-ux-reviewer.md` exists; `wc -l` = 39 lines; frontmatter: `description` states "ATOM-073 (pilot prerequisites intake review) and any atom whose artifact will be read aloud to a non-technical founder"; sections match template: frontmatter, Identity, Capabilities, Method Defaults, Escalation Posture, Provenance |
| **H2** | Capabilities are specific to §2 (≥5 bullets), no generic filler | PASS | 5 bullets present, all tied to §2 requirements: jargon-leak detection, step counting, cognitive load measurement, expectation-reality verification, decision atomicity tracing. No generic filler ("writes well", "is thorough"). Each bullet actionable and founder-optic-specific. |
| **H3** | Escalation Posture names triggers E1–E8 + what role decides alone | PASS | All 8 escalation triggers (E1–E8) defined with specific decision gates. Final paragraph names what role decides alone: "exact wording of defect labels, severity assignment (soft/hard), and concrete repair suggestions." |
| **H4** | Provenance table: Created / ROLE-005 / 2026-07-07 | PASS | Table present with row: Event=Created, Atom=ROLE-005, Date=2026-07-07 |
| **S1** (soft) | Stranger could role-play from file alone | PASS | Identity paragraph establishes the role's viewpoint. Capabilities are concrete and testable. Method Defaults explain how to apply capabilities. Escalation Posture is a decision tree. Provenance is clear. |

## Cost Block

**Token estimate (this execution):**
- Initial reads: INPUT.md + venture-strategist.md template (~8k context)
- File creation + bash verification (~1k)
- Metadata (STATUS, RESULT, workspace/run.log) (~2k)
- **Total consumed: ~4–5k tokens**

**Budget:** ~12k tokens (well within envelope)

## Notes

- Role is tightly scoped to non-technical founder UX review
- Capabilities directly map to INPUT §2 requirements (jargon leaks, step counting, cognitive load, expectation-reality, atomicity)
- Escalation posture uses founder-centric triggers (not executor-centric)
- File is ready for immediate use by ATOM-073 (pilot prerequisites intake) and any future artifact review requiring founder optic
