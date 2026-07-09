---
id: INFO-014
date: 2026-07-09
kind: ceo-directive (role mechanics — maturity from precedents)
status: recorded; T1 practice effective immediately, constitutional home in touch №2
source: CEO, chat 09.07.2026 (из CMM-разговора)
feeds: roles/*.md frontmatter (maturity block, on first update); touch queue candidate 12
---

# INFO-014 — Role capability maturity (зрелость ролей из прецедентов)

## Слова CEO (verbatim)

> Role capability maturity (из CMM-разговора): роли несут уровень
> зрелости, растущий из прецедентов использования (число успешных
> прогонов, возвраты verify, rowan-fail rate, точность конвертов);
> полномочия следуют за зрелостью — у зрелой роли шире дефолтный конверт
> и легче verify-режим по F3, у свежей — строже. Механика: maturity-блок
> во frontmatter роли, обновляется при закрытии атомов. Touch-кандидат;
> до touch'а — практика записи прецедентов в роль уже разрешена (T1).

## Interpretation

1. Maturity-блок во frontmatter роли (появляется при первом обновлении
   после закрытия атома с участием роли):
   `maturity: {runs: N, verify_returns: N, rowan_fails: N, envelope_accuracy: <spent/envelope по прогонам>, updated: YYYY-MM-DD}`.
2. Полномочия следуют за зрелостью: зрелая роль — шире дефолтный конверт,
   легче verify-режим в границах F3-мэппинга; свежая — строже. Ослабление
   ниже строки F3 остаётся downward-override по FP9 (риск-акцепт
   человека) — зрелость смягчает в пределах строки, не пробивает её
   до конституционного touch.
3. T1: запись прецедентов в роль при закрытии атомов разрешена уже
   сейчас (это Tier-A самообновление знания, O8.3-совместимо);
   автоматическое расширение полномочий по зрелости — только после
   touch №2 (кандидат 12).

## Применено (same day)

- Практика записи прецедентов в maturity-блок роли объявлена действующей
  (первые блоки появятся при ближайших закрытиях атомов).
- `TASKS.md` — touch-кандидат 12.
- Связь: INFO-013 (rowan-fail rate — входной счётчик зрелости).
