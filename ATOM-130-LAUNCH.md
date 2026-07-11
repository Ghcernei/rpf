# ATOM-130 — SEPARATION (framework = продукт, lab = фабрика, kit v0.4)

- **Дерево:** SEPARATION (новое; INFO-036 блок 4, порядок INFO-043)
- **G1:** GATE-031 («го» CEO, план консолидированного пакета)
- **Роль:** pilot-toolsmith (тёплый)
- **Конверт:** ~250k (executor ~180k, verify ~55k targeted blind).
  ⚠️ INFO-019: конверт — flagged practice; исчерпание → честный E4.
- **Релиз:** тег v0.4 + CHANGELOG (INFO-024). Правка install.sh ⇒ после
  приёмки обязателен перезачёт №2 руками CEO (INFO-035).

## Зачем (два потолка)

Ближний: пользователь волны №1 получает чистый инстанс продукта — без
3600 файлов чужой рабочей истории, контекст-шума и «чей это TASKS.md в
моей системе». Дальний: framework-репо становится витриной governed work
system (INFO-043), lab — публичным доказательством самопостроения.

## Мандат (DoD)

1. **dist-manifest** — явный whitelist путей дистрибутива в репо
   (файл `distribution/dist-manifest`): конституция/framework-доки,
   runtime/, скилл, distribution/, docs/, knowledge/, CHANGELOG, README,
   LICENSE, MANIFEST. НОЛЬ: products/, decisions/, TASKS.md, ATOM-*-LAUNCH,
   roles/ рабочие маршруты — точный состав предлагает исполнитель, судит
   verify по принципу «универсально целиком или не едет».
2. **Sparse-вендоринг**: step_framework вендорит ТОЛЬКО manifest-пути
   (sparse-checkout по manifest либо manifest-фильтрованная копия — выбор
   исполнителя, с обоснованием в run.log). Self-update канал (release-теги)
   продолжает работать; существующие инстансы обновляются молча
   (гарантии v0.3 не ломаются — харнесом).
3. **qroky/lab** — публичная фабрика: вся стройка (products/, decisions/,
   NARRATIVE'ы, TASKS.md, launch-файлы, roles/) переезжает туда going
   forward; README framework ссылается «полный журнал самопостроения —
   qroky/lab». Создание репо+push — в объёме GATE-031. Механика работы
   после разъезда (агент пишет решения в lab, продукт в framework) —
   описать в lab/README и docs.
4. **История НЕ переписывается** (констрейнт GATE-031 п.3): чистка
   framework = HEAD going forward; теги и клоны живы. Любое предложение
   переписать историю = E-остановка, не самодеятельность.
5. **Bootstrap-скрипт** (INFO-040 + carry-over «нормальная команда»):
   одностраничный вход `qroky.sh` — install | uninstall | update из любого
   места без знания пути клона (clone-логика с reinstall-обработкой ДО
   install.sh; uninstall находит установку по машинному следу). README:
   рекомендуемый вход = одна команда.
6. **Freeze-проверка** «дистрибутив = только manifest-пути» — скрипт-зерно
   будущего verify.sh (INFO-043), прогоняемый в харнесе.
7. **Харнес**: фальсифицируемый (INFO-037, verify мутационный): sparse-
   вендоринг не тянет products/decisions/TASKS; чистая установка = продукт
   без истории; апдейт живого инстанса v0.3.x → v0.4 молчалив и не ломает
   привязку/данные; bootstrap все три команды; freeze-проверка падает на
   подсунутом не-manifest файле.

## NOT-DOING

Переписывание git-истории; ревизия/редактирование содержимого decisions
(HUMAN-TASK CEO, параллельно); root-README продукт-витрина (ATOM-120);
verify.sh полный (блок 3); переезд уже опубликованных тегов.
