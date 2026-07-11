# lang/ru.sh — owner-visible strings of the Telegram head, Russian (DEFAULT).
# ATOM-105: the kit's question 1 language reaches the head via LANGUAGE= in
# profile.conf. These are the ORIGINAL v1 literals verbatim — a machine
# without LANGUAGE set renders byte-identical output. Log lines stay English
# in the scripts (operator-facing, not owner-facing).
# Functions print WITHOUT a trailing newline unless the string embeds one.

T_KROKY_ACK() { printf '%s' "Принял. Запускаю протокол «кроки» — осмотрюсь и пришлю предложение сюда; действий до твоего «го» не будет."; }
T_FREE_ACK() { printf '%s' "Принял, смотрю — отвечу здесь."; }
T_GATE_ACK() { printf 'Принял: «%s» — записываю решение по %s.' "$1" "$2"; }
T_GATE_DECLINE() { printf '%s' "Не нашёл этот вопрос — возможно, он уже закрыт. Если он всё ещё ждёт решения, напиши ответ текстом."; }
T_RISK_BUTTON_REJECT() { printf 'Это подтверждение риск-уровня — кнопкой его принять нельзя. Набери слово %s текстом.' "$1"; }
T_RISK_NONE() { printf '%s' "Сейчас нет ожидающих подтверждений риск-уровня."; }
T_RISK_WHICH() { printf 'Ожидают подтверждения: %s. Уточни: %s <id>.' "$1" "$2"; }
T_RISK_ACK() { printf 'Принял подтверждение по %s — записываю решение.' "$1"; }
T_ROUTE_DECLINE() { printf '%s' "Не нашёл этот переспрос — возможно, он уже закрыт. Напиши мысль заново, лучше сразу с именем проекта."; }
T_ROUTE_ACK() { printf 'Принял — направляю в [%s], оформлю и покажу здесь.' "$1"; }
T_REASK_QUESTION() { printf '%s' "В какой проект это направить? Один тап — и я оформлю."; }
T_BTN_COMMON() { printf '%s' "общий"; }
T_BEAT_MORE() { printf '…(продолжение в %s/NARRATIVE.md)' "$1"; }

T_PROMISE() { printf 'Принял, результат к %s — осматриваюсь по протоколу «кроки».' "$1"; }
T_KROKY_NOLLM() { printf '%s' "Не могу поднять обработчик «кроки» на этой машине (claude CLI недоступен) — запрос сохранён, живая сессия его подхватит. Детали: telegram.log."; }
T_TASK_FILED() { printf 'Оформил как задачу — живая сессия увидит её в %s. Формулировка:' "$1"; }
T_FORMULATE_NOLLM_ROUTED() { printf '%s' "Не могу сформулировать без обработчика (claude CLI недоступен) — сообщение сохранено, живая сессия оформит. Детали: telegram.log."; }
T_FORMULATE_NOLLM() { printf '%s' "Не могу сформулировать без обработчика (claude CLI недоступен) — твой ответ сохранён, живая сессия оформит. Детали: telegram.log."; }
T_CLARIFY_NOLLM() { printf '%s' "Записал. Обработчик на этой машине недоступен (claude CLI) — живая сессия разберёт твоё сообщение из decisions/inbox."; }
T_ORPHAN_PROMISE() { printf 'По обещанию «результат к %s»: работа была прервана и её вход утерян — повтори запрос, пожалуйста. Это честный сбой, он записан.' "$1"; }

T_STATUS_DEAD() { printf '[%s] ⚠ путь из реестра не найден: %s' "$1" "$2"; }
T_STATUS_NOT_FOUND() { printf 'Проект с таким именем в реестре не найден. Зарегистрированы: %s' "$1"; }
T_STATUS_EMPTY() { printf '%s' "Пока нет ни одной задачи в products/ — статусов нет."; }
T_STATUS_EMPTY_BLOCK() { printf '%s' "• пока пусто"; }
T_STATUS_DONE_CLOSED() { printf '%s' "готово/закрыто"; }
T_STATUS_TRUNCATED() { printf '%s' "…(обрезано — полная картина в утреннем дайджесте)"; }

T_DG_GREETING() { printf 'Доброе утро. Дайджест за %s:' "$1"; }
T_DG_GREETING_MERGED() { printf 'Доброе утро. Сводный дайджест за %s:' "$1"; }
T_DG_DONE() { printf '%s' "Сделано:"; }
T_DG_RUN() { printf '%s' "В работе:"; }
T_DG_WAIT_TODAY() { printf '%s' "Ждёт тебя сегодня:"; }
T_DG_WAIT() { printf '%s' "Ждёт тебя:"; }
T_DG_EMPTY_DONE() { printf '%s' "• пока пусто"; }
T_DG_EMPTY_RUN() { printf '%s' "• ничего не бежит"; }
T_DG_NO_DECISIONS() { printf '%s' "• решений не ждём"; }
T_DG_PENDING_SUFFIX() { printf '%s' " — ждёт твоего решения (кнопки в чате выше)"; }
T_DG_SIGNALED_HEADER() { printf '%s' "Уже в ленте сегодня (статус, не тревога):"; }
T_DG_SIGNALED_SUFFIX() { printf '%s' " — уже приходило событием сегодня, без повторной тревоги"; }
T_DG_SPEND_NONE() { printf '%s' "расход: данных за сегодня нет"; }
T_DG_SPEND_NONE_SHORT() { printf '%s' "расход: данных нет"; }
T_DG_SPEND() { printf 'расход: %s' "$1"; }
T_DG_CHANGELOG() { printf 'Обновление правил %s:' "$1"; }
T_DG_QUIET() { printf '[%s] — тихо: изменений нет, решений не ждём' "$1"; }
T_DG_DEAD() { printf '⚠ [%s] — путь из реестра не найден: %s (поправь ~/.qroky/registry)' "$1" "$2"; }
T_DG_TOTAL() { printf 'итого расход (по числовым ledger): %s' "$1"; }
T_DG_TRUNCATED() { printf '%s' "…(обрезано)"; }
