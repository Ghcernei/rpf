# LAUNCH — ATOM-111 (telegram-router-v1: one bot, many projects)

> Runtime instruction. QUEUED: starts on CEO «го» (G1). Formulated per
> INFO-034 («формулируй», model endorsed). Execute per the five framework
> documents and `runtime/claude/README.md`.
> Step 0 — materialize per LP3 into `products/telegram-head-v1/111-project-router/`
> (INPUT verbatim, STATUS `formulated`, status.yaml row, NARRATIVE.md of the
> atom opened with clickable path handed to the human — INFO-015/016).
> Rowan (INFO-012/013) + spawn proportionality (INFO-018) on every spawn.
> Spawn justification (formulator, O5.1): v1 head serves exactly one
> workspace — the second project on a machine has no phone channel and a
> second head collides on launchd labels; mission_value: «единая точка» is
> the CEO's own framing of the phone channel and the prototype of multi-user
> support routing (INFO-030 п.5); why_not_lower: registry + multiplexed
> events + merged digest + migration of a LIVE install is a build with hard
> compatibility criteria, not a lens or an inline edit.
> Budget (INFO-019 flagged practice per GATE-022): subtree ~450k — executor
> ~250k (M, pilot-toolsmith warm: owns both the head and the kit; precedent
> ATOM-110 executor ~197k full chain), blind verify ~150k (L, delta over a
> reviewed base), parent ≤5%, ~50k fixed per subagent. E4 only on breach.
> G-gates: G1 (CEO «го» on this plan — explicitly covers the machine-level
> registry file `~/.qroky/registry`, an I3-class exception, one file);
> G2 (live: two workspaces on one machine, a gate from EACH answered from
> the phone, ONE merged morning digest).

---
---
atom: ATOM-111
product: Telegram project router v1 — one bot per owner, project-labeled events, merged digest, cross-project /status, project re-ask for free input
parent: telegram-head-v1 lineage (extends reviewed ATOM-110; INFO-034 mandate)
role: pilot-toolsmith (warm; built the head and the kit integration)
formulated_by: session from INFO-034 (CEO «формулируй»), 2026-07-10
verification: independent blind (L) — code + harness; migration scenario mandatory
maturity_target: reviewed; validated after G2 (two live projects, phone answers, merged digest)
model_tier: M (executor), L (verify)
budget: ~450k subtree (see header)
recursion_allowance: 1
---

# ATOM-111 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `runtime/claude/telegram/` extension: machine registry, project-labeled routing, merged digest, cross-project status, project re-ask; kit hooks in `distribution/install.sh` (register at install) |
| Atom ID | ATOM-111 (child: 111-verify) |
| Input product(s) | reviewed head (ATOM-110, r3); kit v0.2 (ATOM-104); INFO-033 two-contour model (unchanged); INFO-034 (mandate + model verbatim) |
| Consumer(s) | The owner's ONE Telegram chat serving ALL his workspaces; the live neighbor-Mac install (migration case №1) |
| Gates | G1 = «го» on this plan (incl. registry file exception); G2 = two-project live test from the phone |
| Verification mode | independent blind (L); migration + collision scenarios exercised, not code-read |
| Budget envelope | ~450k subtree |
| Recursion-depth allowance | 1 |

## 2. Job To Be Done

The owner has several projects on one machine and ONE bot. Every event
arrives labeled with its project; a button press lands in THAT project's
decisions/; the morning digest is one message with a section per project;
«что в работе» answers across all of them; a free-text thought that names
no project gets exactly one clarifying re-ask (buttons — this is not a
risk item). The phone stays the channel of the HUMAN; projects stay the
unit of work. Nothing about INFO-033's contours changes.

## 3. Mandate (closed decisions — INFO-034 model verbatim; do not reopen)

1. **One listener per machine** (launchd pair unchanged) iterating a
   machine-level registry: `~/.qroky/registry` — plain text, one workspace
   path per line, comments allowed. I3-class exception: EXACTLY this one
   file in `~/.qroky/`; covered by G1 of this atom (named in the header).
2. **Registration:** kit install adds its workspace to the registry
   (idempotent); a manual `register.sh <path>` / `unregister.sh <path>`
   pair ships with the head for non-kit workspaces. No skill changes in
   this tree (a one-line skill candidate may be QUEUED, not applied).
3. **Events carry the project label** («[name] …», name = workspace
   basename or a `PROJECT_NAME` override in the workspace profile);
   decision records land in the ORIGIN project's decisions/ (parity rules
   unchanged, channel field only). pending-gates registry entries carry the
   workspace path so a button press routes home without ambiguity.
4. **Digest: ONE message** at profile time — a section per project
   («сделано / в работе / ждёт тебя / расход»), empty projects one line,
   already-signaled events as status lines (no duplicate alarms — rule
   unchanged). Cost section may sum across projects with a total line.
5. **«что в работе»** → all projects; «что в работе <имя>» → that one.
6. **Free input routing:** project named → routed; not named → ONE re-ask
   with project buttons (plus «общий» if a default project is configured in
   the human-level profile). Risk-word rule untouched (no buttons for risk
   confirmations — that rule is about CONFIRMATIONS, not project choice).
7. **Human-level vs project-level settings:** chat_id binding, token,
   quiet hours, digest time, detail level = HUMAN level (one place,
   `~/.qroky/` next to the registry or the primary workspace profile —
   executor picks ONE home and documents it; migration must not re-ask
   anything). Per-project: name override only.
8. **Migration (hard):** the live neighbor-Mac v1 install upgrades
   seamlessly — its workspace becomes registry entry №1, no re-bind, no
   second hello, launchd jobs replaced in place, zero questions. The
   upgrade rides the self-update channel (release tag) + `--apply-update`;
   fold the recorded upgrade-path defect if cheap: «токен есть, головы
   нет» after apply-update should auto-complete without --enable-telegram
   (it is THIS tree's natural ground — declare if deferred).
9. **NOT in v1 (не золотить):** multi-USER routing (support instance is a
   different tree), per-project bots/tokens, Telegram topics/threads,
   project priorities/weights, cross-machine registry.

## 4. Definition of Done

**Hard (harness-proven, stubbed Bot API):**
- H1. Two fake workspaces in registry: a gate born in each → both arrive
  labeled; press on each → decision record in the CORRECT project's
  decisions/ (cross-routing attempted and failed = the assert).
- H2. Merged digest: one sendMessage, both sections, empty third project
  = one line; already-signaled event renders as status line.
- H3. /status across projects; «что в работе <имя>» filters.
- H4. Free input w/o project → exactly one re-ask with buttons → routed
  task-proposal in the chosen project's inbox.
- H5. Migration: a v1-shaped state (single-workspace, bound chat_id,
  stored offset) upgraded → registry seeded, NO re-bind, NO hello, no
  double-processing of old offsets; listener healthy first pass.
- H6. Registry hygiene: dead path in registry → flagged in log + digest
  status line, listener does NOT crash (poison-pill lesson of R2-1);
  unregister removes cleanly.
- H7. Human-level settings live in ONE documented home; project profile
  carries name override only; secrets rules unchanged (token file path
  only, negative greps over all new logs/transcripts).
- H8. Existing 15-scenario head harness still green (extended feeds OK);
  kit harness still green if kit hooks touched.
- H9. Blind verify: accept. Records per LP (run.log breath lines, budget
  checkpoints, harness-checklist answers, RESULT with TEAM summary,
  NARRATIVE beats level 2–3).

**Soft (judge — CEO at G2):**
- S1. Two real projects, a gate from each answered from the phone, one
  merged morning digest — and it reads like ONE assistant, not two bots
  glued together.
- S2. Labels read human («[rpf]», not paths).

## 5. Method Hints (non-binding)

- Reuse the pending-gates registry shape for routing (add workspace path
  field) — parity by construction stays in record-decision.sh.
- Registry iteration = outer loop in listener.sh/digest.sh over registry
  lines; per-workspace state stays IN the workspace (offsets are global
  per bot — keep the single offset at human level, route by callback
  payload / chat context, NOT by per-workspace polling).
- The neighbor Mac is migration case №1 and G2 ground — coordinate the
  live upgrade with the orchestrator (SSH access may exist by then).

## 6. Escalation

E1–E8 per constitution; Rowan on every E1; §3 closed list — friction = E7
against INFO-034. NOT-DOING proposals = defect. Envelope breach → honest
E4. Gates: G1 «го» (registry exception named), G2 two-project live test.

---
*End of launch file. Formulated 2026-07-10 from INFO-034 («формулируй»);
execution starts on CEO «го».*
