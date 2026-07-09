---
id: INFO-025
date: 2026-07-09
kind: ceo-directive (micro-tier — mature-harness checklist + builder duty)
status: recorded; knowledge + skill + builder roles applied same day
source: CEO, chat 09.07.2026
feeds: knowledge/reference/harness-checklist.md; ~/.claude/skills/qroky/SKILL.md §7 M8; roles/pilot-toolsmith.md, roles/framework-architect.md
---

# INFO-025 — HARNESS-CHECKLIST: чек-лист зрелой обвязки

## Слова CEO (verbatim)

> HARNESS-CHECKLIST (от CEO, micro-tier): собери в knowledge/ чек-лист
> зрелой обвязки из полевых уроков десяти дней
> (render/heartbeat/telemetry/dry-run/install): state-файл и
> резюмируемость; идемпотентность (повторный запуск безопасен); лимит
> автопопыток (2, дальше человеку); редакция секретов (grep-критерий);
> самодостаточный лог с эстафетой в системный журнал; бюджет-строка (что
> жжёт, сколько); зависимости (официальность, план при исчезновении,
> деградация); verify до первого боевого прогона; happy-path-вопрос
> («что если упало на середине / запустили дважды / нет сети»). Правило
> в скилл/роли: строитель харнеса обязан прогнать чек-лист и записать
> ответы в run.log (аналог spawn justification для tools); пропуск
> пункта — с обоснованием, не молча. Прецеденты-иллюстрации: install.sh
> (resume+health-check — канон), G-003 (стоп у секрета — канон границы).

## Interpretation

1. Девять пунктов — обобщение уже принятых частных правил (INFO-022
   state/резюмируемость/≤2 попытки; H4-редакция; heartbeat-уроки) в
   один переиспользуемый инструмент: чек-лист применяется к ЛЮБОЙ
   обвязке до боевого прогона, а не изобретается заново на каждом
   харнесе.
2. Дисциплина — та же, что O5.1 для спавнов: прогнать и записать ответы
   в run.log; пропуск пункта легален только с обоснованием (deletion
   test на месте: молчаливый пропуск = дыра, найденная в поле).
3. ATOM-100 обязан пройти чек-лист целиком (его H-критерии уже
   покрывают пункты 1–4, 9; пункты 5–8 исполнитель закрывает записью).
4. Дом: knowledge/ (инструмент), скилл §7 M8 (machine-wide правило),
   роли-строители (pilot-toolsmith, framework-architect). Конституция
   не трогается — micro-tier по слову CEO.

## Применено (same day)

- `knowledge/reference/harness-checklist.md` — чек-лист с канонами.
- `~/.claude/skills/qroky/SKILL.md` §7 M8 — правило строителя.
- `roles/pilot-toolsmith.md`, `roles/framework-architect.md` — строка
  обязанности в Method Defaults.
