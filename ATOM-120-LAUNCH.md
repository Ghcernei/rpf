# LAUNCH — ATOM-120 (launch-package-v1: soft launch through the network)

> AMENDED 2026-07-10 per INFO-031 (CEO decision: soft launch via warm network
> instead of a public launch). Landing EXCLUDED from the tree (qroky.com =
> DNS redirect to GitHub, HUMAN-TASK CEO); HN/Reddit drafts and the LinkedIn
> post FROZEN with trigger «после 2–3 волн тёплой раздачи». Focus: README as
> the only storefront + messenger handoff message (EN/RU/RO) + feedback
> channel (GitHub issues + support instance drafts under CEO E2). Budget
> recalculated ~750k → ~550k.

> Runtime instruction. QUEUED: execute only after the distribution-kit tree
> (ATOM-100) closes, and only after a fresh CEO «го» on this plan (G1 gate at
> start — mandatory per the order). Execute per the five framework documents and
> `runtime/claude/README.md`.
> Step 0 — materialize per LP3 into `products/launch-package-v1/120-launch-package/`
> (INPUT.md verbatim, STATUS.md `formulated`, status.yaml per SM3, NARRATIVE.md
> opened with its clickable path handed to the human immediately — INFO-015/016).
> Rowan (INFO-012/013) and spawn proportionality (INFO-018: `mission_value` +
> `why_not_lower` on every O5.1) apply to every spawn.
> Spawn justification (formulator, O5.1): the product opens publicly with the
> distribution kit, but no artifact today survives a stranger's 30-second
> «clone or leave» decision; mission_value: activation (clone → first closed atom)
> is metric №1 (INFO-021 §1.1); why_not_lower: public-face texts are a
> perimeter-crossing product with a CEO gate — not an inline edit, not one E1.
> Budget (proportionality + precedents, INFO-019 flagged practice per GATE-022;
> recalculated per INFO-031): subtree ~550k — README+FAQ+UPDATES+CHANGELOG
> executor ~230k (M), handoff-message+checklist executor ~100k (M), blind
> verify ~140k (L, ×3.5+40k over the text package), parent orchestration +
> narrative ≤5%, ~50k fixed per subagent. E4 only on breach.
> G-gates: G1 (CEO go on this plan at start); G2 (CEO reads ALL outward texts —
> perimeter; the handoff message in all three languages goes to CEO for edit).

---
---
atom: ATOM-120
product: Soft Launch Package v1 (README rewrite as the only storefront, messenger handoff message EN/RU/RO, wave-distribution launch checklist)
parent: — (top-level business atom; order INFO-021; starts after ATOM-100 closes)
role: orchestrator (launch session); executor roles: reuse sales-operator (voice/outreach) + pilot-toolsmith (artifact renders); a dedicated storyteller role only if proportionality justifies it at execution (O5.1)
formulated_by: launch session from CEO order INFO-021 (verbatim file + English-only amendment), 2026-07-09
verification: independent blind (L) + CEO gate on every outward text (perimeter)
maturity_target: reviewed (validated — after ≥1 stranger completes clone→install from these texts)
budget: ~550k subtree (see header; INFO-019 flagged practice, referenced explicitly; ~750k → ~550k per INFO-031 — landing and posts left the tree)
recursion_allowance: 2
---

# ATOM-120 — Input Specification

## 1. Product Identity
| Field | Value |
| :---- | :---- |
| Product | `README.md` (rewritten, EN-only, the ONLY storefront) + `docs/REPO-GUIDE.md` (current navigator preserved) + `marketing/handoff/` (messenger handoff message EN/RU/RO) + launch checklist (wave distribution) |
| Atom ID | ATOM-120 (children per plan: 121 README+FAQ; 122 handoff+checklist; 121/122-verify) |
| Parent product | Qroky public opening (INFO-017 self-service; INFO-021 order) |
| Executor role(s) | sales-operator + pilot-toolsmith (reuse — F2); new role only via O5.1 proportionality case |
| Input product(s) | `decisions/INFO-021` (order + amendment, verbatim — the mandate); `decisions/INFO-017`, `INFO-020` (positioning: autonomy hero, governance = seat belt, second paragraph); `products/landing-v0/` (drafts to move & rewrite); current `README.md`; real proof artifacts ONLY: garden test records, ATOM-007 RESULT/TEAM debrief (21 agents / 7 roles), `knowledge/precedent/verify-envelope-calibration.md` (curve), `decisions/` journal, cost blocks (real monthly numbers); `distribution/` (install commands must match the REAL kit — dependency on ATOM-100 output) |
| Consumer(s) | Warm-network recipients of the handoff message (and the third parties they forward it to); a reader landing on the repo via qroky.com redirect deciding «clone or leave» in 30 seconds; CEO (sends every message by hand) |
| Maturity target | reviewed (validated after first stranger install) |
| Gates | G1 = CEO go on this plan at start (mandatory); G2 = CEO on ALL outward texts (perimeter); DNS/publication = HUMAN-TASK CEO |
| Instantiation | subagents (executors), session (blind verify) |
| Verification mode | independent blind (public face, perimeter-crossing) + CEO judgment criteria (§4 soft) |
| Budget envelope | ~550k subtree (INFO-031) |
| Recursion-depth allowance | 2 |

## 2. Job To Be Done

Soft launch (INFO-031): the CEO forwards a 2–3 paragraph message to 2–3 warm
contacts per wave; the message leads to the repo; the README does ALL the
selling in 30 seconds — hero line, «how it works» on REAL artifacts, three-line
install (`git clone && bash install.sh`), what they do vs what the system does,
skeptic FAQ — and the reader clones. Feedback flows back through GitHub issues
(support instance drafts replies, CEO sends). The package sells nothing; it
leads to `git clone`. Activation (clone → first closed atom) is metric №1.

## 3. Mandate (closed decisions — formalize, do not reopen; full text INFO-021)

1. Self-service, thousands of instances; monetization framing: consulting /
   enterprise orchestration, NOT Flow Support (divergence with STRATEGY.md is
   flagged in INFO-021 §3.4 — do not resolve here).
2. Positioning: hero = autonomy («поставил задачу — получил результат, пока
   занимался своим»); governance = seat belt, SECOND paragraph, never hero.
   Founder = first vertical, not the product's definition.
3. **English-only public face (amendment, supersedes the order's item 3):**
   README, landing, posts, the whole rule system — one canonical language, no
   RO/RU versions of public artifacts. Readers translate with LLMs; ES/FR —
   future releases by traffic data. Pilot materials (QUICKSTART.ro, CONSENT.ro,
   intake) are OUTSIDE this tree and stay RO (legally addressed). The HP runtime
   rule is unchanged: the system speaks the human's profile language on top of
   the EN canon. FAQ MUST include verbatim: «Docs are English-only; the system
   itself speaks your language — set it in your profile».
4. Proofs — real only: garden before/after + a NARRATIVE excerpt, ATOM-007
   debrief (21 agents in 7 roles, where they argued), calibration curve,
   decisions journal. NO invented quotes/logos/market figures. Reserve marked
   placeholders for: second-Mac test, books, first external user — added when
   they happen.
5. **Soft launch (INFO-031, supersedes the order's public-launch shape):**
   landing is OUT of the tree (qroky.com = DNS redirect to the GitHub repo,
   HUMAN-TASK CEO; `products/landing-v0/` stays versioned, marked frozen);
   HN/Reddit drafts and the LinkedIn post are FROZEN with the verbatim
   trigger «после 2–3 волн тёплой раздачи» — a tree-level NOT-DOING, not a
   rejection. Distribution is by waves: 2–3 people per wave, days between
   waves so the feedback loop closes before the next one. The handoff
   message is a personal-channel artifact — EN/RU/RO versions are legitimate
   (the EN-only rule of §3.3 covers the public face; boundary recorded in
   INFO-031 п.4).

## 4. Definition of Done

**Hard (machine-checkable):**
- H1. (Amended INFO-043.) `README.md` rewritten EN-only. Hero carries the
  positioning formula VERBATIM: «Qroky turns agent work into governed,
  verified, auditable product work» — governed work system, NOT a coding
  harness; the «accountability contour» (who formulated / who executed /
  who blind-verified / where the human risk acceptance / what was spent /
  what was delivered) is THE canonical value description. First screen =
  the Codex five points in order: (1) what you get in 15 minutes, (2) how
  to install, (3) what appears after «qroky start», (4) what stays local /
  what never leaves the machine, (5) only then «how it works».
  NOT-DOING (INFO-043): «framework for everyone» positioning — rejected;
  focus founders/regulated for year one. Within that: autonomy hero line →
  60-second «how it works» on live artifacts → three-line install
  (`git clone && bash install.sh`) matching the REAL kit → «what you do / what the system does» (the three human
  products as honesty) → skeptic FAQ (whose keys and data; what leaves the
  machine — nothing without opt-in; real monthly cost from cost blocks; vs bare
  Claude; known v1 limits) including the verbatim language line of §3.3. The
  features list carries ONE self-update line, verbatim (INFO-024): «checks for
  releases, asks before applying — you're in control» — no self-update section
  in README (depth lives in docs/UPDATES.md, H8). FAQ additionally carries
  (INFO-030): the disclaimer line («the system produces drafts and analysis;
  legal/financial/medical decisions and signatures are always the human's;
  not professional advice»); «what if the project/author disappears» —
  everything is local, open source, works without us, forkable; and the
  backup line «backups go to YOUR OWN private GitHub account». README also
  carries (INFO-031) an «early access» block: built in the open, issues
  welcome — with a direct link to GitHub issues as THE feedback channel.
- H2. Old navigator preserved at `docs/REPO-GUIDE.md` (content-identical move).
- H3. Hero contains none of: audit / journal / verify (grep) — they live in the
  second echelon.
- H4. Every factual claim traces to a repo artifact (link or path next to the
  claim; verify checks each).
- H5. (Replaced per INFO-031.) Messenger handoff message at
  `marketing/handoff/` in THREE languages (EN/RU/RO), 2–3 paragraphs each,
  natively written (not machine-glued): what this is, why the recipient's
  opinion matters, the repo link, the line «15 минут; сломается — пиши мне»
  (localized), and it must read well when FORWARDED to a third party the CEO
  doesn't know. `products/landing-v0/` untouched, marked frozen with the
  trigger; no `marketing/` landing move.
- H6. Launch checklist exists: soft-launch order (README merge → qroky.com
  DNS redirect [HUMAN-TASK CEO] → wave 1 of 2–3 warm contacts → feedback
  loop closes via issues → waves 2–3, days apart), a wave counter, the
  unfreeze trigger line for HN/Reddit/LinkedIn (verbatim: «после 2–3 волн
  тёплой раздачи»), readiness criterion (release kit closed + ≥1 external
  user completed install), AND the hard rule (INFO-024, verbatim): «релиз
  без changelog не публикуется».
- H7. Blind verify: accept. Publication itself — HUMAN-TASK CEO (DNS, merges,
  posting): nothing goes outward by agent hands (S4/S5 perimeter).
- H8. `docs/UPDATES.md` — the user's page on updates (INFO-024): the mechanics
  (heartbeat → fetch → release tags only → explicit «да» → mini-atom recorded in
  the user's decisions); the fate of local edits (reconciliation, conflicts are
  SHOWN); manual update without heartbeat (exact commands); rollback to any tag
  (command); fully disabling the check (command). The right «не трогайте мой
  инстанс» is stated EXPLICITLY, not implied. Commands must match the real kit
  (dependency on ATOM-100's delivered mechanics, H11 there). Plus the identity
  guarantee (INFO-028 п.4, user-facing): the instance's core (vendored
  framework) is never silently modified by local changes, every state is
  recoverable via git history, and the user's own decisions/ is the journal of
  every change their instance made to itself.
- H9. `CHANGELOG.md` — one entry per release tag, written in user-benefit
  language («что улучшится у тебя»), rendered at tier S from the release's
  freeze summary of changes (the INFO-016 anti-rationalization discipline:
  render the recorded, don't compose). This file is also the source of the
  heartbeat digest's 3-line changelog (INFO-023).
- H10. `CONTRIBUTING.md` + forking policy (INFO-030 п.2): BDFL decision model
  (the CEO decides what enters the core); how to propose changes — issues/PR
  land as candidates in the touch queue (the external door into the SAME
  constitutional cycle, never around it); the right to fork is explicitly
  WELCOMED; trademark line: the code is Apache-free, the name Qroky is
  protected — forks rename. Multi-platform ports go through forks/bindings
  per `runtime/INTERFACE.md`, not through core edits.
- H11. (INFO-036 block 2 — Codex user-path microscopy; a QUALITY CHECKLIST
  for README/kit texts, not new rules.) Verify checks each: (a) README order
  is «what I get in 15 minutes» FIRST, philosophy after; (b) distribution
  README carries no internals before the install command; (c) every
  install.sh output line the user sees reads as action / status / exact fix
  (audit of existing strings — kit CODE changes are out of this tree's
  scope: any install.sh edit resets the INFO-035 clean-run and belongs to
  block-3/4 atoms); (d) the installer's final screen is EXACTLY 2–3
  commands, no scatter; (e) «qroky start» works precisely where the
  installer's texts promise it. Plus (INFO-039 candidate 26): README/pitch
  vocabulary line «agent harness / harness engineering» + one line naming
  the OpenAI-convergence validation.

**Soft (judge — CEO at G2):**
- S1. 30-second stranger test on README: hero + first screen answer «what is it
  and why do I care» without scrolling.
- S2. The handoff message sounds like the CEO writing to a friend, not like
  marketing copy (all three languages delivered for his edit; his voice is
  the hard bar). LinkedIn draft: FROZEN per INFO-031 — not built in this
  tree; unfreezes with the wave trigger.
- S3. Forwardability: the handoff message still works when the recipient
  forwards it to someone the CEO doesn't know — no context assumed beyond
  the message itself.

**Maturity target:** reviewed. Do not gold-plate; placeholders stay placeholders.

## 5. Method Hints (non-binding)

- Hero candidates draw on INFO-020 wording; governance/seat-belt is paragraph 2.
- Real numbers: cost blocks of ATOM-007 (2.76M subtree, $-figure), ATOM-090/091;
  the calibration curve from knowledge/precedent.
- `products/landing-v0/` stays where it is — add ONE freeze note to its
  README (trigger verbatim), nothing else touched.
- Layout: `marketing/handoff/` at root per order logic; if LA2 resists — E7
  with INFO-021/031 as the recorded human decisions.
- Voice source for the handoff message: CEO's style profile (machine-local);
  all three language versions are raw material for HIS edit, not finished
  messages. He sends every one by hand (S4/S5 perimeter).

## 6. Escalation

E1–E8 per constitution; Rowan discipline on every E1; the closed-decision list
(§3) may not be reopened — a contradiction found in it is E7 against INFO-021,
not a judgment call. Gates: G1 at start (CEO go), G2 on all outward texts,
publication HUMAN-TASK. Monetization divergence: flagged, not resolvable here.

---
*End of launch file. Formulated 2026-07-09 from INFO-021 (order file verbatim +
English-only amendment); amended 2026-07-10 per INFO-030 (H1 FAQ lines, H10
CONTRIBUTING/forking) and INFO-031 (soft launch: landing out, posts frozen,
handoff message in, wave distribution). Queued behind ATOM-100 (distribution
kit): install commands in H1 depend on the real kit.*
