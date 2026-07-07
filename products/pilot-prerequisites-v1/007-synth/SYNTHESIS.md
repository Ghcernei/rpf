---
synthesis_atom: ATOM-007-SYNTH
parent: ATOM-007
question: "Дают ли эти пререквизиты пилоту стартовать и быть измеренным безопасно?"
lenses: [founder-ux, token-economics, security-telemetry, owner-capacity]
value_gates: [GATE-018]   # E8-1 + E8-2 answered 2026-07-07 (opt-in consent item; 2 founders + primary-duty + breach protocol) — decisions/GATE-018
executor: claude-fable-5 (chair role: venture-strategist)
date: 2026-07-07
---

# SYNTHESIS — ATOM-007: do these prerequisites let the pilot start and be measured safely?

## Positions (SY5 step 2)

| Lens | Claim | Evidence | Recommends |
| :---- | :---- | :---- | :---- |
| founder-ux (073) | **Yes-with-conditions.** The shape is right — a founder reads a conversation, not machinery — but the signature document leaks internal vocabulary, QUICKSTART's first step assumes a file the founder was never given, and TIERS presents placeholder-derived dollars as measured fact. | Line-cited reads of every founder-facing file (CONSENT L17-19, QUICKSTART steps 1-2, TIERS final section, cross-referenced against team-summary-spec's own glossary and cost-line-spec's own placeholder disclosure). | Three patches inside the current shape (B1–B3); plain-language pass on secondary surfaces (S1–S3); state the consequence of declining consent (S4); harden or soften the 15-min proof (S5). |
| token-economics (074) | **Yes-with-conditions.** The cost mechanism is honest but the rate feeding it is not: $8.00/M is ~3.2× a plausible blended real rate; tier-3 auto-escalation cost is hidden from founders; telemetry strips the work-unit context pricing re-anchor needs. | Rate arithmetic vs Anthropic SDK prices (blended ~$2.50/M for the PLAN's tier mix); OD4 budget audit (760k required vs 350k granted); push.sh whitelist lines 15-24. | No dollar line reaches a founder until the contracted rate is confirmed; disclose auto-escalation with a worked cumulative example; add a content-light `work_unit` field to the cost block. |
| security-telemetry (075) | **Yes-with-conditions.** The whitelist is real deny-by-default code and the OFF switch is tested — but the promise the founder signs does not hold once telemetry actually runs: nothing installs or schedules push.sh; deletion-on-revocation has zero enforcing code; 4 of 5 whitelisted files are copied whole-file, unfiltered; render.sh opens the exact file push.sh names as never-to-be-opened. | Line-cited code reads (push.sh L101-108/170, bootstrap.sh whole-file, render.sh L156-164); negative-test.sh scope analysis; run.log DECISION lines confirming which gaps are deliberate. | Close F1–F4 before a founder's signature on this consent text is honest; scope the whitelist by path, not basename (F5); document the actual revocation action (F6). |
| owner-capacity (076) | **NO — not safely at 2 concurrent founders without an explicit SLA trade-off.** Workload math: 50–77 min/day baseline for 2 founders; any concurrent owner duty >1–2 h/day, or 3 blockers in one day, breaks the one-business-day SLA; no escalation procedure exists for a missed SLA. | Workload arithmetic built from the prerequisites' own artifacts (telemetry monitoring, render spot-checks, intervention approval) against pilot-design criteria 3–4 (≤30 min/day/founder). | Declare the pilot the owner's primary daily duty, or relax the SLA to 2 business days, or run 1 founder; add an SLA-breach protocol; replace daily manual render audits with automated checks. |

The four verdicts stand as delivered: three yes-with-conditions, one no. The
no is not smoothed away below — it survives as condition 7 and gate E8-2.

## Contradictions (SY5 step 3)

### X1 — fact — Consent plain language vs filename-level transparency (dissolved)
- Lenses: founder-ux (073 B1 + its SY9) vs security-telemetry (075)
- founder-ux: the paragraph a founder reads to decide whether to sign must be plain language; internal filenames out of the body (evidence: CONSENT L17-19 vs the glossary its own sibling spec mandates). It projected that the security lens "wants those exact names in the consent text, verbatim" and named that as the real X-contradiction if so.
- security-telemetry: its trust argument rests on "the script is open — you can read every line" — but its **delivered verdict nowhere demands filenames inline in the consent body**. Its F3 explicitly offers "amend the consent text to disclose **plainly**" as an acceptable fix direction.
- Classification test (SY6): the settling evidence is checkable and in the package — the delivered 075 verdict text itself. Named, obtained → fact.
- Resolution (SY7): **dissolved — the anticipated opposing position does not exist in the delivered verdicts.** 073's proposed design stands: plain-language body per team-summary-spec's own glossary, plus a separately labelled "exact technical list, for reference" footnote carrying the five verbatim filenames. This satisfies 073 B1 (plain signing text) and preserves 075's greppability (the exact names remain in the document, labelled, verifiable against push.sh). Logged in run.log R1.

### X2a — fact — Does the showcase render break the telemetry perimeter promise today?
- Lenses: security-telemetry (075 F4) internal, touching 072's design; founder-ux (073 S1) adjacent.
- security-telemetry: render.sh opens INPUT.md and republishes RESULT's `## Summary` first sentence — INPUT.md is the file push.sh's own header names as the canonical never-to-be-opened example; run.log confirms this was deliberate.
- Checkable state: per 075 F5's own analysis, push.sh's whitelist matches five basenames only (`STATUS.md`, `RESULT.md`, `run.log`, `status.yaml`, `VERDICT.md`); the render outputs (`example-cost-line.txt`, `example-team-summary.md`) are not among them and are therefore not swept by any existing push path; `push_to_remote()` is a hard stub besides.
- Classification test (SY6): what the code does is observable → fact.
- Resolution (SY7): **reconciled — both partly right about different spots.** As shipped, no code path sends render output off the machine: there is no live leak today. But 075's finding stands as a specification gap: nothing marks the render outputs as local-only or perimeter-crossing, while the parent INPUT §3.3 declares the showcase a "selling artifact" Startup Moldova "must see from day one" — i.e. crossing is the *intent*. The fact half ends here; whether it *should* cross carries product substance is X2b. Settling evidence: push.sh whitelist mechanics as line-cited in 075 F3/F5. Logged R2.

### X2b — value — Team legibility vs content silence outside the perimeter → **E8-1**
- Lenses: security-telemetry (075 F4 + its SY9) vs the accepted INFO-007 design that founder-ux's optic defends (the TEAM summary exists so a founder and Startup Moldova see *what was built*, plainly).
- security-telemetry: the `## Summary` first sentence is structurally the most business-descriptive line in the whole record; the fan-decision line is pulled from the one forbidden file. If these fields ever cross the perimeter, "мы никогда не получаем содержание вашего продукта" is false. Strip both, or wall the showcase off — and it names the cost: the TEAM summary stops answering the lesson it was built to answer.
- Legibility position (INFO-007, parent INPUT §3.3): the invisible team blurs the value; the showcase is the pilot's selling artifact and must show contributions in plain language, to the founder and to Startup Moldova, from day one.
- Classification test (SY6): no observation settles this — both positions survive full shared information; it is a trade-off between disclosure value and content silence. → value. (Related: 074 F3 wants *more* work-unit context in telemetry for pricing re-anchor — the same boundary, pulled from a third direction; its resolution is downstream of this choice.)
- Resolution: **not resolved here — routed to the human as E8-1** (see the E8 block). One recommendation attached there per SY8.

### X3a — fact — Owner workload arithmetic vs the ≤30 min/day/founder criterion
- Lenses: owner-capacity (076 F2) vs the pilot-design SLA the other three lenses treated as given.
- owner-capacity: 50–77 min/day for 2 founders (= 25–38 min/founder), of which +4–6 min/day and +10 min/closure are *new* load introduced by these very prerequisites; 3 blockers in one day → 80–107 min; any concurrent duty breaks the SLA.
- No lens disputes the arithmetic; no verify contradicts it.
- Classification test (SY6): the load numbers are estimates but the structure is checkable against the artifacts (which reviews the prerequisites do add) → fact.
- Resolution (SY7): **reconciled — the prerequisites do not make the SLA infeasible; they make it conditional.** The ≤30 min/day/founder criterion holds at 2 founders only under best case (blockers <1/day, no manual render audits, no concurrent duties). The executor-fixable part is real: 076's Finding 1 proposal (automated honesty checks replace daily manual spot-checks; owner glances weekly) removes ~2 min/day + ~10 min/closure and is adopted into the register. What remains after that fix is not a fact question — it is X3b. Settling evidence: 076's summary table vs pilot-design criterion 3, uncontested. Logged R3.

### X3b — value — Run at 2 founders on an owner-commitment, or de-risk the SLA → **E8-2**
- Lenses: owner-capacity (NO) vs founder-ux + token-economics + security-telemetry (yes-with-conditions over the same artifacts).
- owner-capacity: the pilot is safe only if the owner has zero concurrent duties >1–2 h/day for 8 weeks — otherwise criteria 3–4 fail late, in week 4, when it is most expensive.
- The accepted pilot design: daily cadence is deliberate (accepted §3.4); the SLA is part of the offer's credibility; weakening it or halving the cohort has channel cost.
- Classification test (SY6): the owner's real availability and the acceptable failure mode are risk-appetite and personal-commitment questions; no measurement settles them → value.
- Resolution: **not resolved here — routed to the human as E8-2.** This is the contradiction that keeps 076's NO alive in the record.

### X4 — fact — "Measured, not marketing" vs the $8.00/M placeholder
- Lenses: founder-ux (073 B3) + token-economics (074 F1) + owner-capacity (076 F4) — three lenses, one convergent finding; the contradiction is *inside the product* (TIERS vs cost-line-spec), not between lenses.
- TIERS asserts its dollar figures are "measured directly ... not marketing figures"; cost-line-spec, same product family, same day, declares the underlying rate "a placeholder blended rate — $8.00 per million tokens, assumption dated 2026-07-07" that MUST be replaced before any real founder sees a derived cost line.
- Classification test (SY6): which rate is real is checkable against the contracted/SDK rate → fact.
- Resolution (SY7): **the placeholder position stands; TIERS's certainty claim is checkably false as shipped.** 074's arithmetic (blended ~$2.50/M for the PLAN's actual tier mix; $8/M ≈ 3.2× overstated) is the only economics analysis in the fan and no lens contests it. Consequences adopted into the register: no dollar figure reaches a founder until the rate is reconciled in writing; TIERS carries its own disclosure line meanwhile; render.sh gets 076's hard checkstop against the un-replaced placeholder. Settling evidence: cost-line-spec §Honest-rounding item 4 (quoted identically by three lenses) + 074's uncontested rate table. Logged R4.

### X5 — fact — Anticipated UX-vs-economics clash over visible cost mechanics (dissolved)
- Lenses: token-economics (074 SY9) vs founder-ux (073).
- token-economics expected the UX lens to push cost mechanics out of sight ("hiding cost complexity ... makes onboarding smoother").
- The delivered 073 verdict does the opposite: its B3 demands *more* cost honesty in front of the founder, and nothing in it opposes disclosing the tier-3 auto-escalation rule — its objection is to jargon, not to cost information.
- Classification test (SY6): what 073's verdict actually demands is in the package → fact.
- Resolution (SY7): **dissolved — no live conflict.** 074's own expected landing ("the cost rule stays visible, but the rendering gets gentler") is exactly what both verdicts jointly specify: disclose auto-escalation and cumulative cost (074 F2) in plain language (073's register). Settling evidence: 073 verdict text. Logged R5.

### X6 — fact — Anticipated security-vs-capacity clash over review cadence (dissolved)
- Lenses: owner-capacity (076 SY9) vs security-telemetry (075).
- owner-capacity projected a security preference for "owner reviews aggregated stats weekly, not daily artifacts."
- The delivered 075 verdict makes no such demand; and 076's own fix (automated checks, owner glances weekly) reduces both operator load and the owner's reading surface — the two optics point the same way.
- Classification test (SY6): 075's delivered position is in the package → fact.
- Resolution (SY7): **dissolved — the projected position does not exist; the adopted fix (register item 12) serves both lenses.** Settling evidence: 075 verdict text. Logged R6.

## Per-lens concurrence (SY9)

| Lens | Contradictions naming it | If none: justification of concurrence |
| :---- | :---- | :---- |
| founder-ux | X1, X4, X5 | — |
| token-economics | X4, X5 | — |
| security-telemetry | X1, X2a, X2b | — |
| owner-capacity | X3a, X3b, X6 | — |

### Per-lens coverage — what each lens uniquely saw (SY9, INPUT §3.2)

**founder-ux (073).** The only lens that read the artifacts from the signing
founder's chair rather than from the code or the spreadsheet. What the others
structurally could not see: that CONSENT — the highest-stakes page in the set —
was never run through the jargon glossary its own sibling spec mandates (B1);
that QUICKSTART's very first action is impossible as written because nothing
says where bootstrap.sh comes from (B2, independently confirmed by
071-verify M1); that the reassurance pointer at the end of QUICKSTART sends a
nervous founder straight into an internal Verify transcript (S3). Its named
contradiction (X1, against the security lens's transparency mechanic) it
declared honestly and refused to pre-smooth — and it **dissolved as fact**: the
delivered security verdict never held the opposing position, so 073's
plain-body-plus-technical-footnote design stands for both.

**token-economics (074).** The only lens that did arithmetic: the rate audit
(X4 — the one finding three lenses touched, but only this one quantified: 3.2×
overstatement), the cumulative tier-3 cost a founder never sees ($~80–160 over
a pilot, F2), the OD4 budget audit exposing that the prerequisites tree itself
ran 117% over its granted envelope (F4), and the observation that
cost-without-work-unit telemetry cannot answer the pricing question the pilot
exists to answer (F3). Its named contradiction (X5, an expected UX pushback)
**dissolved as fact** — the UX verdict demanded more cost honesty, not less.
Its F3, however, feeds the live value gate E8-1: more context in telemetry
pulls against the security lens's content silence.

**security-telemetry (075).** The only lens that read the scripts as an
auditor of promises against code. What the others could not see: that no
deliverable installs or schedules push.sh at all — today there is no path from
"founder said yes" to telemetry ever running (F1); that deletion-on-revocation
is a paper promise with zero enforcing lines (F2); that 4 of the 5 whitelisted
files are copied whole and will routinely carry product-descriptive quotes
(F3); that two sibling scripts in one product make opposite promises about
INPUT.md (F4). Its named contradiction — legibility vs silence, the one it
called "the same feature pulling in opposite directions" — is the fan's first
genuine value conflict: fact half reconciled (X2a — no live leak today), value
half **carried, unsmoothed, to E8-1** (X2b).

**owner-capacity (076).** The only lens that costed the human operator, and
the only NO. What the others could not see: that the prerequisites quietly add
4–6 min/day plus 10 min/closure of owner load on top of a baseline already at
the edge of pilot-design criterion 3, and that a single bad day (3 blockers)
or one concurrent duty breaks the SLA with no documented escalation path (F2);
also the uncosted intake-review hour per founder (F6, minor). Its named
contradiction (X6, an expected security clash over cadence) dissolved as fact
— but its core dissent did not dissolve and is not averaged away: it survives
as **E8-2** and as condition 7 of the consolidated answer. One of its four
minors (F3, telemetry scheduling) converged with 075 F1 and was absorbed into
blocking register item 3.

## Integrated view

**Consolidated answer: yes-with-conditions — the pilot must NOT start until
all seven conditions below hold.** Three lenses said yes-with-conditions and
one said no; this synthesis does not average them. The no survives as
condition 7: until the human makes the E8-2 choice, the owner-capacity verdict
stands and the consolidated answer behaves as a no.

The underlying designs are sound — whitelist + consent + OFF-switch is real
deny-by-default code, the founder-facing register is genuinely conversational,
the cost mechanism is honestly constructed. Every blocking gap is a gap
between what the artifacts *promise* and what they *do*, and every one is
patchable inside the current shape. Conditions, each traceable to finding ids:

1. **No dollar figure reaches a founder until the token rate is contracted and
   reconciled in writing** (074-F1, 073-B3, 076-F4 — X4). TIERS gets a
   disclosure line meanwhile; render.sh gets a hard checkstop on the
   placeholder.
2. **CONSENT is rewritten so the signature is honest**: plain-language body per
   the existing glossary + labelled exact-filename footnote (073-B1 — X1);
   plus either content-filter the four whole-file-copied telemetry items or
   disclose the whole-file copying plainly in the consent text (075-F3);
   plus one sentence on the consequence of declining/revoking (073-S4 —
   answer needed from the CEO at G2).
3. **Telemetry actually runs**: bootstrap (or a named sibling) installs
   push.sh + consent into the founder workspace and registers a real daily
   scheduler with an explicit REPO_ROOT (075-F1, 076-F3).
4. **Deletion is enforced, not promised**: a deletion mechanism keyed to the
   signed date, and revocation triggers a delete request — or, at minimum, a
   dated, auditable owner-executed runbook step (075-F2).
5. **QUICKSTART step 0 exists**: one line saying where bootstrap.sh comes from
   and where to open the terminal (073-B2, 071V-M1).
6. **E8-1 answered**: does the TEAM summary (with its Summary-sentence and
   fan-decision fields) cross the perimeter, and under what consent? (075-F4 /
   X2b; 074-F3 resolves downstream of this choice.)
7. **E8-2 answered**: owner capacity — primary-duty commitment at 2 founders,
   or SLA/cohort de-risking; plus the SLA-breach protocol either way (076-F2 /
   X3b).

Significant-but-not-blocking conditions (fix before G2, not before work
starts) are carried in the register below: items 8–16.

## Fix-priority register (по-русски — для CEO на E8/G2; потребители: ATOM-077 и бриф G2)

Все blocking и significant находки четырёх линз + 6 minor-находок двух
blind-verify, дедуплицировано. «Кто решает»: исполнитель = чинится атомом без
человека; CEO = требует решения человека на E8 или G2.

| № | Приоритет | Источник | Артефакт | Направление правки (одна строка) | Кто решает |
| :- | :---- | :---- | :---- | :---- | :---- |
| 1 | blocking | 074-F1 + 073-B3 + 076-F4 (X4) | TIERS.ro/ru.md, cost-line-spec.md, render.sh | Заменить ставку-заглушку $8/M на контрактную до любого показа цифр фаундеру; в TIERS — строка-дисклеймер; в render.sh — жёсткий checkstop на заглушку | исполнитель (ставку подтверждает CEO письменно) |
| 2 | blocking | 073-B1 (X1) | CONSENT.ro/ru.md | Переписать абзац о собираемом простым языком по готовому глоссарию team-summary-spec; точные имена файлов — в отдельную помеченную техническую сноску | исполнитель |
| 3 | blocking | 075-F3 | push.sh, CONSENT.ro/ru.md | Либо контентная фильтрация VERDICT/STATUS/run.log/status.yaml (структурные поля, без свободного текста), либо честное раскрытие в consent, что эти файлы копируются целиком | исполнитель предлагает; выбор варианта — CEO на G2 (это текст подписи) |
| 4 | blocking | 075-F1 + 076-F3 | bootstrap.sh, push.sh | Установка push.sh + consent в workspace фаундера и реальный ежедневный планировщик (cron/launchd) с явным REPO_ROOT — сейчас телеметрия не запустится вообще | исполнитель |
| 5 | blocking | 075-F2 | push.sh + Flow Support runbook | Механика удаления по дате и по отзыву согласия — код или, минимум, датированный аудируемый runbook-шаг владельца; OFF должен инициировать удаление, не только останавливать отправку | исполнитель (вариант «runbook вместо кода» — подтвердить у CEO) |
| 6 | blocking | 073-B2 + 071V-M1 | QUICKSTART.ro/ru.md | Шаг 0: откуда берётся bootstrap.sh и в какой папке открыть терминал — одна строка | исполнитель |
| 7 | blocking | 076-F2 (X3b → E8-2) | pilot-design SLA + consent/setup | Выбор человека: 2 фаундера при письменном «пилот — основная дневная занятость» ИЛИ SLA 2 рабочих дня ИЛИ 1 фаундер; в любом варианте — протокол пробоя SLA (2 из 5 дней → пауза и пересогласование) | **CEO на E8-2** |
| 8 | blocking | 075-F4 (X2b → E8-1) | render.sh, CONSENT, team-summary-spec | Выбор человека: TEAM-сводка с содержательной строкой пересекает периметр по явному согласию ИЛИ остаётся local-only / обрезанной | **CEO на E8-1** |
| 9 | significant | 073-S4 | CONSENT.ro/ru.md | Одно предложение: что происходит при отказе/отзыве — продолжается ли пилот и SLA | **CEO** (ответ), исполнитель (текст) |
| 10 | significant | 074-F2 | TIERS + ATOM-077 intake | Раскрыть авто-эскалацию tier-3 с рабочим примером накопленной стоимости; в intake — секция cost-plan | исполнитель |
| 11 | significant | 074-F3 | push.sh / RESULT cost block | Поле `work_unit` (структурное, без свободного текста) для unit-экономики к re-anchor — финальный вид зависит от ответа E8-1 | исполнитель, после E8-1 |
| 12 | significant | 076-F1 | render.sh / verify-контур | Автопроверки честности (поля cost-line, отсутствие жаргона в TEAM-сводке) вместо ежедневного ручного аудита владельцем; владелец смотрит раз в неделю | исполнитель |
| 13 | significant | 073-S1 | cost-line-spec.md | Явно: фаундеру вставляется только строка «⚙ …»; комментарий-блок — внутренний аудит, наружу не показывается без перевода | исполнитель |
| 14 | significant | 073-S2 | render.sh | Строку fan-decision дистиллировать в одно простое предложение, rule-id (PM4) не показывать | исполнитель |
| 15 | significant | 073-S3 | QUICKSTART.ro/ru.md | Убрать/заменить ссылку на сырой dry-run-transcript одной простой фразой; транскрипт — только для Verify | исполнитель |
| 16 | significant | 073-S5 | dry-run + QUICKSTART | Либо один реальный сетевой clone с замером, либо смягчить финальную фразу: «скриптовая часть — меньше минуты; плюс время загрузки по вашей сети» | исполнитель |
| 17 | significant | 074-F4 | intake / бриф G2 | Опубликовать цену governance-слоя и trade-off economy-варианта явно (решение по конверту уже принято на G1); замерить реальную стоимость после первого пилота | исполнитель |
| 18 | minor (verify) | 071V-M2 | QUICKSTART.ro/ru.md | Windows-путь: явно «откройте Git Bash», иначе шаг 2 падает в PowerShell | исполнитель |
| 19 | minor (verify) | 071V-M3 | TIERS.ro/ru.md | Выровнять косметический дрейф RO/RU формулировок (субстанция идентична) | исполнитель |
| 20 | minor (verify) | 072V-F1 (+074-F5) | render.sh | Реализовать ветку для атомов с потомками (m_roles и чтение SYNTHESIS.md — первый живой рендер будет закрытие ATOM-007); fallback при отсутствии SYNTHESIS.md | исполнитель — **до закрытия ATOM-007** |
| 21 | minor (verify) | 072V-F2 | cost-line-spec / render.sh | Либо выводить четырёхчастную разбивку типов токенов, либо смягчить «always» в спеке | исполнитель |
| 22 | minor (verify) | 072V-F3 | render.sh | Плюрализация «ролей» по M (сейчас захардкожен единственный «роль») | исполнитель |

Дедупликация: 071V-M1 слит с 073-B2 (№6); 076-F3 слит с 075-F1 (№4);
073-B3/076-F4 слиты с 074-F1 (№1); 074-F5 отмечен при 072V-F1 (№20).
Minor-находки линз (073-M1..M3, 074-F5, 075-F5..F7, 076-F3..F6) в реестр не
входят по заданию, кроме поглощённых дедупликацией; они остаются в вердиктах
линз и доступны ATOM-077 по путям.

## E8 block (SY8) — ценностные конфликты, выбор человека

Оба конфликта пережили тест SY6: никакое наблюдение или измерение их не
закрывает — обе стороны правы в своей оптике; выбор — ценностный. Бриф гейта
пишет formulating agent (O8.2), ссылаясь на этот блок (GB3).

### E8-1 — Читаемость команды или молчание содержимого за периметром (X2b)

**«TEAM-сводка показывает „что построено" Startup Moldova — ИЛИ содержимое
продукта не покидает машину фаундера никогда. Обе стороны правы в своей
оптике; выбор — ценностный.»**

- Выбрать читаемость: сводка остаётся продающим артефактом (INFO-007, INPUT
  §3.3) — но первая фраза Summary структурно самая содержательная строка
  записи; обещание «мы никогда не получаем содержание вашего продукта»
  придётся ослабить в тексте подписи. Жертва: чистота консент-обещания.
- Выбрать молчание: строки Summary и fan-decision вырезаются из всего, что
  пересекает периметр; сводка показывает роли и счётчики, но не «что
  сделали». Жертва: сам смысл артефакта, ради которого он создан (урок
  «невидимой команды»).
- **Рекомендация (одна, EP2):** сводка по умолчанию local-only; вариант с
  содержательной строкой пересекает периметр только по отдельному явному
  пункту согласия в CONSENT («одну простую фразу о том, что построено, можно
  показывать Startup Moldova») — фаундер выбирает сам при подписании.
  **Цена:** +1 пункт в consent (трение при онбординге) и неоднородность
  сводок между фаундерами; продающая сила артефакта зависит от доли
  согласившихся.

### E8-2 — Владелец как основная занятость или ослабление SLA (X3b)

**«Пилот на 2 фаундеров с обязательством „это моя основная дневная занятость
8 недель" — ИЛИ ослабить SLA до 2 рабочих дней / сократить когорту до 1.
Обе стороны правы в своей оптике; выбор — ценностный.»**

- Держать 2 фаундеров и однодневный SLA: сила оффера и скорость измерения —
  но математика 076 (50–77 мин/день базово, 80–107 при плохом дне) держится
  только при нулевых прочих обязанностях; срыв придёт на 4-й неделе, когда
  он дороже всего. Жертва: календарь владельца заперт, риск позднего провала
  критериев 3–4.
- Ослабить (SLA 2 дня или 1 фаундер): запас прочности и честность обещания —
  но оффер слабее, измерение медленнее/уже, канальная ценность пилота ниже.
  Жертва: продающая сила и статистика пилота.
- **Рекомендация (одна, EP2):** держать 2 фаундеров + письменная фиксация
  primary-duty в pilot-design + протокол пробоя (SLA сорван 2 из 5
  последовательных дней → автоматическая пауза, пересогласование SLA или
  минус один фаундер) + автоматизация аудитов (реестр №12), снимающая
  ~15–20% нагрузки. **Цена:** 8 недель владельца фактически принадлежат
  пилоту; при нарушении обязательства провал будет поздним и публичным, а не
  ранним и тихим.

Примечание: 073-S4 (что происходит при отказе от телеметрии) — не конфликт
линз, а отсутствующая ветка политики; вопрос CEO на G2, внесён в реестр (№9).

## Residual

- Two value gates raised (E8-1, E8-2) — unanswered at delivery; gate ids to be
  recorded in this file's frontmatter when the decision records exist. Until
  E8-2 is answered, the owner-capacity NO governs: prerequisites are not
  start-safe.
- One CEO policy answer needed at G2: consequence of declining/revoking
  telemetry (register №9).
- A future revisit should reopen: (a) the tonal mismatch between the cost
  line's audit register and the TEAM summary's warm register (073-M3 — format
  locked by INFO-006 P3, next constitutional touch); (b) supply-chain signing
  of the framework dependency (075-F7); (c) re-baselining the prerequisites
  tree cost after the first pilot closes (074-F4); (d) 076-F5's request for a
  stated rationale of the daily cadence — the cadence is an accepted decision
  (INPUT §3.6), only its written justification is missing.

## Handoff

Fold-back per FB1: the parent (ATOM-007) integrates this product into its own
product (FB4 item 1) and references it in the closure acceptance entry.
Direct consumers: ATOM-077 intake design and the G2 brief consume the
fix-priority register; the formulating agent authors E8-1/E8-2 gate briefs
from the E8 block (O8.2, GB3); ATOM-007-VERIFY checks SY9 coverage against
this file.
