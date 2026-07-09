---
id: INFO-024
date: 2026-07-09
kind: ceo-directive (launch-package addition: self-update in public docs)
status: recorded; ATOM-120-LAUNCH.md amended same day (pre-launch, tree still queued behind ATOM-100)
source: CEO, chat 09.07.2026
feeds: ATOM-120-LAUNCH.md (H1 feature line, new H8 UPDATES page, new H9 CHANGELOG + release-checklist hard criterion)
---

# INFO-024 — Self-update в публичной документации (дополнение к INFO-021)

## Слова CEO (verbatim)

> Дополнение к launch-package (от CEO): (1) в публичном README — одна
> строка о self-update в фичах («checks for releases, asks before
> applying — you're in control»), без раздела; (2) docs/UPDATES.md —
> страница пользователя: механика (heartbeat → fetch → только
> release-теги → явное «да» → мини-атом в decisions), судьба локальных
> правок (reconciliation, конфликты показываются), ручное обновление без
> heartbeat (команды), откат на любой тег (команда), полное отключение
> проверки (команда) — право «не трогайте мой инстанс» описано явно;
> (3) CHANGELOG.md — на каждый release-тег, языком пользы для
> пользователя, рендерится из freeze-сводки правок (S-tier), «релиз без
> changelog не публикуется» — hard-критерий release-чеклиста.

## Interpretation

1. README держит дисциплину «второго эшелона»: self-update — одна
   строка в фичах (формулировка EN дана дословно), никакого раздела;
   вся глубина — на docs/UPDATES.md.
2. UPDATES.md — страница ПРАВ пользователя, не только механики: ручное
   обновление, откат на любой тег, полное отключение проверки — каждое
   одной командой; право «не трогайте мой инстанс» — явный текст, не
   вывод между строк. Это документная половина INFO-023 (механизм) —
   consent-принцип продукта распространён на обновления.
3. CHANGELOG.md — языком пользы («что улучшится у тебя»), источник —
   freeze-сводка правок релиза, рендер S-tier (механический перевод
   уже записанного — та же анти-рационализация, что INFO-016: не
   сочинять, а рендерить). «Релиз без changelog не публикуется» —
   hard-критерий launch-чеклиста (H6 ATOM-120); это же — источник
   3-строчного changelog в дайджесте heartbeat (INFO-023 п.2).
4. Конверт ATOM-120: ~700k → ~750k (страница UPDATES + changelog-
   конвейер в чеклисте).

## Применено (same day)

- `ATOM-120-LAUNCH.md`: H1 дополнен фичей-строкой (verbatim EN); H8
  (docs/UPDATES.md), H9 (CHANGELOG.md + hard-критерий чеклиста)
  добавлены; конверт ~750k.
