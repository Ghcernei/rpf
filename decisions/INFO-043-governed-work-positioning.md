# INFO-043 — Позиционирование «governed work system» + порядок до волны (разбор Codex-ревью №2)

- **Тип:** INFO (решение CEO по внешнему ревью; позиционирование + порядок;
  **supersedes порядок блоков 3–4 INFO-036 в части verify.sh/freeze** —
  lex posterior)
- **Дата:** 11.07.2026
- **Источник ревью:** `docs/advisor/codex-review-2.md` (перенесён из
  decisions/paste.md по слову CEO — «ему место в журнале»)

## Формулировка CEO (дословно)

> Разбор Codex-ревью №2 (decisions/paste.md — переименуй в
> docs/advisor/codex-review-2.md, ему место в журнале): стратегический
> тезис принят и фиксируется INFO — позиционирование «governed work system,
> не harness для кодинга»: формула «Qroky turns agent work into governed,
> verified, auditable product work» — в hero README (ATOM-120) и питчи;
> «контур ответственности» (кто сформулировал/исполнил/проверил/принял
> риск/что потрачено/что доставлено) — как каноническое описание ценности.
> Структура первого экрана README — его пятипунктовка, включая «что
> остаётся локально/что не уходит наружу» четвёртым пунктом. Порядок работ
> подтверждается с его поправкой: clean-run CEO на v0.3.2 → SEPARATION →
> перезачёт → root-README (ATOM-120) → verify.sh (7686 строк shell =
> critical codebase, его цифра) → волна 2–3 тёплых пользователя → и только
> после их фидбека — freeze/cleanup/touch (мораторий продлевается до
> реального фидбека). NOT-DOING подтверждение: «framework for everyone»
> как позиционирование — отклонено, фокус founders/regulated на первый год.

## Следствия

1. **ATOM-120 H1 amended:** hero-формула дословно; первый экран =
   пятипунктовка Codex (что даёт за 15 минут → как установить → что
   появится после qroky start → что остаётся локально/не уходит наружу →
   только потом how it works); «контур ответственности» — каноническое
   описание ценности в README и питчах.
2. **Канонический порядок (заменяет очерёдность блоков 3–4 INFO-036):**
   зачёт №1 (v0.3.2) → ревизия decisions CEO (без изменений, из AMENDED
   INFO-036) → SEPARATION → перезачёт №2 → ATOM-120 (root-README) →
   scripts/verify.sh → волна №1 (2–3 тёплых) → **фидбек** →
   freeze/cleanup/touch. Shell-tightening и readiness — в блоке
   freeze/cleanup по фидбеку.
3. **Мораторий INFO-036 продлён:** не «до freeze v0.2», а «до реального
   фидбека волны №1» — freeze сам сдвинут за волну.
4. **NOT-DOING:** позиционирование «framework for everyone» отклонено;
   фокус founders/regulated первый год.
