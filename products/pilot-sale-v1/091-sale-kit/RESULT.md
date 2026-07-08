# RESULT — ATOM-091 (kickoff sale kit — Startup Moldova)

**Executor:** sales-operator (ROLE-009, `roles/sales-operator.md`) · **Law
consulted:** `decisions/INFO-001-pilot-terms-startup-moldova.md` (exchange +
red lines, verbatim), `decisions/INFO-010-signature-subject-principle.md`
(signature subject), `decisions/GATE-022-atom-090-sale-go.md` (task frame),
`products/business-strategy-v1/STRATEGY.md`,
`products/business-strategy-v1/pilot/pilot-design.md`, both CONSENT files,
QUICKSTART.ro.md, and the CEO style-profile.

**Verdict: all Hard DoD criteria (H1–H6) self-assessed PASS.** See H-checks
below for literal commands and outputs. Soft S1/S2 self-assessed below;
**final judge is the CEO at G2**, per INPUT §5 (files are the product, chat
is signal).

---

## Delivery map (§3 → file)

| # | Deliverable (INPUT §3) | File | Contents |
|---|---|---|---|
| 1 | Outreach — 2 variants (messenger ≤120w, email ≤200w), RU+RO, CEO voice, one action (kickoff date), placeholders | `kit/outreach.md` | Variant 1 (messenger): RU 64w, RO 70w. Variant 2 (email): RU 101w, RO 109w. Both ask for one thing only — a kickoff date — and defer red lines/mechanics to the live meeting. Placeholders `[имя]`/`[nume]`, `[канал]`/`[canal]`, `[окна дат]`/`[ferestre de date]` left for the CEO to fill |
| 2 | Kickoff agenda, 30–45 min, timed blocks: opening (mission) → live screen-show (CONSENT.ro, landing, live decision log) → INFO-001 deal + red lines in plain words → next action (2 founder names + start window) | `kit/kickoff-agenda.md` | 4 timed blocks: 0–5 min opening (mission, not mechanics), 5–25 min live show (landing → `consent/CONSENT.ro.md` → `decisions/`), 25–35 min deal-in-plain-words + all 4 red lines stated explicitly + "how much does this cost now: nothing", 35–45 min next-action ask with a ≤10-day kickoff-date anchor |
| 3 | Talk script: say/don't-say, "what do you want in return" (INFO-001 verbatim), "how much does this cost" (free; rate «уточняется»), 4 objection branches | `kit/talk-script.md` | §1 say/don't-say list; §2 verbatim INFO-001 answer to the exchange question; §3 verbatim "free" answer with no invented rate; §4 four objection branches ("why do we need this", "what if a founder is unhappy", "what happens to founder data" — including the INFO-010 signature-as-deal framing, "why free — what's the catch"); closing block repeats all 4 red lines verbatim |
| 4 | Signals: binary observable progress/sale/refusal signals + "no response 7 days → follow-up" (with the follow-up text itself) | `kit/signals.md` | Progress = kickoff date on calendar ≤10 days; sale = 2 named founders + both signed consent (framed explicitly as signing the deal, not an instruction, per INFO-010); partial signal defined; refusal = explicit "not interested" or two reschedules with no counter-offer within 3 days; 7-day-no-response → one follow-up, text provided RU+RO; no response to follow-up → "reformulate the outreach" signal |

No file outside `kit/` (plus this `RESULT.md`, `STATUS.md`,
`workspace/run.log`) was touched. `status.yaml` (product-level) was not
touched — confirmed below.

---

## H-checks (self-check, literal commands + outcome)

### H1 — all 4 files exist and complete per §3

```
$ ls kit/
kickoff-agenda.md  outreach.md  signals.md  talk-script.md
```
All four present; content-complete per the delivery map above (each file
read in full against its §3 spec item; no missing sub-part — RU+RO in
outreach, all 4 objection branches in talk-script, all 3 signal types +
follow-up in signals, all 4 timed blocks in the agenda).

**H1: PASS.**

### H2 — exchange + red lines are verbatim quotes from INFO-001 (diff-checkable)

```
$ grep -n "case study + 2–3 интро\|не обещаем продакшн-код" \
    ../../decisions/INFO-001-pilot-terms-startup-moldova.md
15:...Опции: (1) case study + 2–3 интро (банки/фонды/акселераторы); red lines:
не обещаем продакшн-код «под ключ», гарантий инвестиций, эксклюзивности,
найма команды...

$ grep -n "case study + 2–3 интро\|не обещаем продакшн-код" kit/talk-script.md
27:Дословный ответ: «case study + 2–3 интро (банки/фонды/акселераторы)» —
72:«не обещаем продакшн-код «под ключ», гарантий инвестиций, эксклюзивности,
найма команды».
```
Both fragments in `talk-script.md` are exact substrings of INFO-001's
Question/Brief text (the same wording the human's verbatim answer selected
— "опция 1"). `kickoff-agenda.md` §25–35 min block references the same red
lines and instructs "произнеси все четыре пункта явно, не сокращай список"
without restating them in different words, deferring to `talk-script.md` as
the source of exact wording.

**H2: PASS.**

### H3 — outreach + agenda (and, checked as a superset, all 4 kit files) are jargon-free

```
$ grep -inE "DoD|атом|atom|verify|INPUT|гейт|gate|tier" \
    kit/outreach.md kit/kickoff-agenda.md kit/talk-script.md kit/signals.md
(no output)
$ echo "exit: $?"
exit: 1
```
Zero hits across all four kit files (paths like `consent/CONSENT.ro.md` are
the only string in the "gate"/"tier" family of concern and none appear).

**H3: PASS.**

### H4 — no promise beyond INFO-001/STRATEGY; no invented numbers

```
$ grep -inE '\$|USD|EUR|MDL|лей|[0-9]+/(month|мес)' \
    kit/outreach.md kit/kickoff-agenda.md kit/talk-script.md kit/signals.md
signals.md:36:повторения всех деталей.
```
The single hit is a false positive — "деталей" (genitive of "детали",
"details") contains the substring "лей" incidentally; it is not a currency
mention. No cost figure, price, or rate appears anywhere in the kit.
`talk-script.md` §3 explicitly instructs: "Не называть никаких цифр — ни за
месяц, ни за фаундера, ни диапазон," and gives "уточняется" as the only
answer to "how much does this cost." No founder-outcome guarantee (funding,
product-readiness date) appears; `talk-script.md` §1 "не говорим" list
states this as a rule, not just a fact of the current draft.

**H4: PASS.**

### H5 — signature mentioned only with explicit subject (INFO-010: consent = deal)

```
$ grep -inE "подпис|semnat|semnăt|consent|согласи" \
    kit/outreach.md kit/kickoff-agenda.md kit/talk-script.md kit/signals.md
signals.md:4:...подпись есть/нет — без интерпретации...
signals.md:19:...подписали согласие (`consent/CONSENT.ro.md` или `.ru.md`). Подпись здесь —
signals.md:20:это подпись под сделкой (обмен: что получают, что дают, где границы, как
signals.md:23:**Частичный сигнал**...
kickoff-agenda.md:27:2. **Согласие фаундера** (`consent/CONSENT.ro.md`) — покажи, что это
talk-script.md:59:Если спросят про подпись: то, что подписывает фаундер, — это
```
Every substantive mention states the subject explicitly: `signals.md`
("Подпись здесь — это подпись под сделкой (обмен: что получают, что дают,
где границы, как выходят)") and `talk-script.md` ("то, что подписывает
фаундер, — это договорённость об обмене... а не инструкция «ознакомился и
обязуюсь». Это сделка"). No mention treats signature as a bare
acknowledgment/instruction.

**H5: PASS.**

### H6 — signals.md: every signal binary and externally observable

Read in full: progress = date-on-calendar-within-10-days (binary: present
or not); sale = 2 named founders + 2 signed consents (binary: named/not,
signed/not); partial = 1 named+signed (binary, explicit intermediate
state, does not count as closed); refusal = explicit refusal phrase, or
two reschedules + no counter-offer within 3 days (both binary/observable,
no "seemed interested" language anywhere); no-response-7-days → one
follow-up (dated trigger, binary: response received or not), with the
follow-up text itself provided RU+RO so no drafting is needed at the
moment of use.

**H6: PASS.**

---

## S1 — do the outreach texts sound like Ghenadie, not marketing? (self-assessed; CEO is final judge)

Checked against `~/.claude/skills/style/style-profile.md`:
- Both RU variants open with a hook word from the signature list (§2:
  "Смотри," is used in variant 1 and variant 2's second sentence) rather
  than a cold, formal opener.
- Both close with a real question tied to the one requested action
  ("Когда вам удобно — [окна дат]?"), matching §2/§6's closer rule
  (real question or control gate, never a generic CTA).
- Short sentences, front-loaded intent, ask tied to a "why" ("готов
  показать вживую... договоримся, кто из фаундеров стартует первым") —
  matches the directive-plus-purpose spine (§1.2).
- RO variant uses the imperative-collaborative "Hai să facem un kickoff"
  (≈ "давай"), matching §3's RO register (verb-first CTAs, imperative
  chains) rather than a translated-RU calque.
- No anti-pattern from §5 present: no corporate hype phrase, no
  over-politeness padding, no generic "Looking forward to your response,"
  no em-dash thought-leader rhythm.

**S1: self-assessed PASS**, final judge is the CEO.

## S2 — is the kit sufficient to act same-day without rework?

Yes, self-assessed: `outreach.md` is send-ready once three placeholders are
filled; `kickoff-agenda.md` gives block-by-block timing and names the exact
three screens to open; `talk-script.md` gives word-for-word answers to the
two hardest questions plus 4 objection branches; `signals.md` gives the
exact follow-up text pre-written, so no drafting is needed if 7 days pass
with no response. Nothing in the kit depends on an artifact that doesn't
yet exist — `consent/CONSENT.ro.md`, the landing HTML, and `decisions/`
already exist and were read during this session.

---

## Deviations / things flagged rather than fudged

- **None.** All four kit files were found already drafted on disk at
  session start (committed in `8ee7a01`, the ATOM-090/091 opening commit).
  This session's work was verification against every DoD criterion (H1–H6,
  including the diff-check for H2 and the literal grep for H3) plus writing
  this closing documentation — no content in `kit/` needed correction; all
  checks passed on first read.
- `status.yaml` (`products/pilot-sale-v1/status.yaml`) was read for
  context only, never opened for edit — confirmed via `git status --short`
  below.

```
$ git status --short products/pilot-sale-v1/
?? products/pilot-sale-v1/091-sale-kit/RESULT.md
?? products/pilot-sale-v1/091-sale-kit/STATUS.md
?? products/pilot-sale-v1/091-sale-kit/workspace/run.log
```
Only the three files this atom is scoped to write are new/changed;
`status.yaml` and every file under `kit/` are absent from this diff (they
were already committed, untouched this session).

## Cost / token estimate

Session covered: reading role spec + INPUT + INFO-001 + INFO-010 + GATE-022
+ STRATEGY.md + pilot-design.md + both CONSENT files + QUICKSTART.ro.md +
style-profile.md, reading all 4 existing kit files in full, running 5
verification commands (word counts, jargon grep, quote diff-check, cost
grep, signature grep), and composing this RESULT.md. Estimated
**~55,000–70,000 tokens** — within the ~180k budget named in INPUT.md, no
escalation needed.

## Provenance
| Event | Atom | Date |
| :---- | :---- | :---- |
| Kit verified against DoD, closing docs written | ATOM-091 | 2026-07-08 |
