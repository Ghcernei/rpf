# RESULT — ATOM-130 (SEPARATION: framework = продукт, lab = фабрика, kit v0.4)

Mandate: [/ATOM-130-LAUNCH.md](../../../ATOM-130-LAUNCH.md) · G1: GATE-031.
Executor: pilot-toolsmith (warm). Date: 11.07.2026.

## Состав dist-manifest (DoD 1) — отдельная строка для координатора

`distribution/dist-manifest` (whitelist, «универсально целиком или не едет»):
**framework/ · runtime/ · distribution/ · docs/ · knowledge/ · qroky.sh ·
CHANGELOG.md · README.md · LICENSE · MANIFEST.md · .gitignore**.
НОЛЬ: products/, decisions/, TASKS.md, ATOM-*-LAUNCH*, ATOM-001-INPUT,
roles/, RELEASE-v0.1.md, .claude/ (пуст), .DS_Store. Формат: путь на
строку, каталоги с «/», # комментарии. Один файл кормит И вендоринг
инсталлера, И freeze-проверку — разойтись они не могут по построению.
Замечание для CEO-ревизии: docs/advisor/codex-review-2.md и
runtime/claude/heartbeat/{heartbeat.log,out/} — внутри manifest-каталогов,
но по духу — рабочие следы; курирование содержимого = HUMAN-TASK CEO
(constraint 6), в manifest каталоги едут целиком по мандату.

## Путь публикации lab (DoD 3) — отдельная строка для координатора

Выбран путь **«локально bare-ready, пушит координатор»**:
`/Users/ghcernei/Work/qroky-lab` — git-репо, initial commit `842446d`,
582 файла (products/ 580 factory-файлов + README + .gitignore), содержимое
скопировано VERBATIM (constraint 6 — decisions не редактированы; ревизия
чувствительного у CEO ещё идёт, публиковать до неё — необратимое действие,
поэтому push сознательно НЕ выполнен, хотя gh-доступ в объёме гейта).
Публикация после твоего go:
`cd /Users/ghcernei/Work/qroky-lab && gh repo create qroky/lab --public --source . --remote origin --push`.
Снапшот на момент сборки; освежить перед push (мои записи 130 дописались
после снапшота): `rsync -a --delete /Users/ghcernei/Work/rpf/products/ /Users/ghcernei/Work/qroky-lab/products/`
(+ decisions/, TASKS.md — если менялись) и amend/second commit.

## DoD 2 — sparse-вендоринг

Выбор: **git sparse-checkout, non-cone** (обоснование в run.log: копия
остаётся настоящим tag-pinned git-checkout — канал self-update
(fetch/checkout/status/stash) не тронут ни байтом; non-cone потому что
manifest содержит корневые ФАЙЛЫ, а cone-режим принудительно
материализует ВСЕ корневые файлы — утащил бы TASKS.md).
`_framework_apply_manifest()` вызывается после каждого checkout: при
вендоринге и в cmd_apply_update. Дерево БЕЗ manifest (теги v0.3.x и
старше) вендорится целиком — опубликованные релизы не теряют ничего.
Слишком старый git → честная деградация в полный checkout (лог), не
сломанная установка. Молчаливая миграция: жирный v0.3.x-инстанс на первом
v0.4-апдейте сбрасывает фабричную историю; untracked-файлы пользователя
внутри скрываемых каталогов git не трогает (никогда не удаляем чужое).

## DoD 4 — история

Не переписана: ни одной git-операции в framework-репо (working tree only,
коммиты твои). Теги v0.1.2…v0.3.2 и self-update живых инстансов стоят на
старой истории — совместимость доказана сценарием 20. Чистка HEAD =
твой коммит после приёмки: `git rm -r --cached` не нужен — просто удалить
из working tree products/ decisions/ TASKS.md ATOM-* RELEASE-v0.1.md
roles/ и закоммитить (lab уже хранит копию).

## DoD 5 — bootstrap qroky.sh

Одна страница, три команды из любого места: `install` (держит копию кита
в ~/.qroky/kit на свежем релизном теге; занятая не-git папка = честное
предложение, не git fatal), `update` (release-tag checkout кита +
`--apply-update`), `uninstall` (находит установку по МАШИННОМУ следу
`~/.qroky/workdir` — новый санкционированный ~-указатель, пишется на
шаге 2, удаляется uninstall'ом с guard'ом «только если указывает на
удаляемую установку»; installer берётся из копии кита, а офлайн — из
вендоренного framework/distribution самого инстанса). Reinstall-логика
ATOM-106 НЕ дублируется: qroky.sh владеет только входом, диалог занятой
папки — install.sh. README ×3: рекомендуемый вход = одна команда.

## DoD 6 — freeze-проверка

`distribution/verify.sh <tree> [manifest]` — зерно verify.sh INFO-043:
дерево содержит ТОЛЬКО manifest-пути; нарушители перечисляются поимённо;
.git и PROVENANCE.md (собственный след инсталлера) игнорируются. Гоняется
в харнесе; падает на одном подложенном файле с его именем в выводе.

## DoD 7 — харнес

Kit dry-run **23/23** (21 сценарий). Новое:
- **19 sparse+freeze**: junk (products/decisions/TASKS/launch) ЕСТЬ в
  дереве тега (не-вакуумно), НЕТ в worktree; verify.sh зелёный на чистом,
  красный с названным нарушителем на подложенном файле.
- **20 silent migration**: второй old-origin без manifest → жирный
  инстанс (junk довезён — доказано) с живым Telegram → следующий тег
  приносит manifest → `--apply-update` «да»: история сброшена, runtime
  жив, chat_id/profile/token байт-стабильны, ноль интервью-строк, ноль
  лишних отправок, freeze зелёный.
- **21 bootstrap**: qroky.sh из трёх РАЗНЫХ нейтральных папок («скачанный»
  файл, не клон): install (кит в ~/.qroky/kit на теге, sparse-инстанс),
  update (новый тег без единой подсказки о workdir), uninstall (клон-
  pointer принудительно убит — резолв ТОЛЬКО через машинный след),
  повторный uninstall = вежливый no-op.
- Все 20 прежних чеков зелёные при том, что fake-origin теперь несёт
  junk + настоящий manifest — т.е. КАЖДАЯ установка харнеса идёт sparse.
Мутационная готовность: на до-130 коде manifest/verify.sh/qroky.sh не
существуют, junk доезжает до worktree — сценарии 19/20/21 падают целиком.

## Попутные правки

- resolve_candidate_workdir: машинный след как fallback после клон-
  pointer'а (перезаклон находит установку без qroky.sh тоже).
- Сценарий 12: исчерпывающий листинг фейкового HOME учитывает новый
  санкционированный указатель (ровно 4 файла, содержимое проверяется).
- Root README: карта репо без products/decisions/roles-строк, ссылка на
  lab, ссылка на docs/separation.md; шаг «посмотри живой цикл» указывает
  в lab. docs/separation.md — механика двух домов и freeze-правило
  (DoD 3 «описать в lab/README и docs» — обе стороны).

## NOT-DOING — соблюдено

История не тронута; decisions не редактированы (копия в lab verbatim);
root-README витриной не делал (только карта/ссылки — ATOM-120 остаётся);
полный verify.sh не строил (зерно); опубликованные теги не переезжали.

## Релиз

CHANGELOG v0.4 подготовлен. Тег и framework-коммиты — твои после приёмки;
после приёмки CEO ждёт перезачёт №2 (INFO-035 — install.sh изменён).

## Расход

~165k executor из ~180k (INFO-019: в конверте, E4 не понадобился).
Харнес: стабы, 0 сети, 0 реальных токенов; gh НЕ использован (push
отложен сознательно — см. путь публикации выше, это не E1-блок).
