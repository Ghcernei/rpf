# lang/ro.sh — owner-visible strings of the Telegram head, Romanian (ATOM-105).
# Selected by LANGUAGE="ro" in profile.conf. Same function catalog as ru.sh.

T_KROKY_ACK() { printf '%s' "Am primit. Pornesc protocolul «qroky» — mă uit în jur și trimit propunerea aici; nimic nu se întâmplă înainte de go-ul tău explicit."; }
T_FREE_ACK() { printf '%s' "Am primit, mă ocup — răspund aici."; }
T_GATE_ACK() { printf 'Înregistrat: «%s» — scriu decizia pentru %s.' "$1" "$2"; }
T_GATE_DECLINE() { printf '%s' "Nu găsesc această întrebare — poate e deja închisă. Dacă mai așteaptă o decizie, scrie răspunsul ca text."; }
T_RISK_BUTTON_REJECT() { printf 'Aceasta e o confirmare de nivel risc — nu poate fi acceptată cu un buton. Scrie cuvântul %s ca text.' "$1"; }
T_RISK_NONE() { printf '%s' "Acum nu așteaptă nicio confirmare de nivel risc."; }
T_RISK_WHICH() { printf 'Așteaptă confirmare: %s. Precizează: %s <id>.' "$1" "$2"; }
T_RISK_ACK() { printf 'Confirmarea pentru %s acceptată — scriu decizia.' "$1"; }
T_ROUTE_DECLINE() { printf '%s' "Nu găsesc acea întrebare de rutare — poate e deja închisă. Trimite gândul din nou, ideal cu numele proiectului."; }
T_ROUTE_ACK() { printf 'Am primit — direcționez către [%s]; îl formulez și îl arăt aici.' "$1"; }
T_REASK_QUESTION() { printf '%s' "Către ce proiect să meargă? Un tap și îl formulez."; }
T_BTN_COMMON() { printf '%s' "general"; }
T_BEAT_MORE() { printf '…(continuarea în %s/NARRATIVE.md)' "$1"; }

T_PROMISE() { printf 'Am primit, rezultatul până la %s — mă uit în jur conform protocolului «qroky».' "$1"; }
T_KROKY_NOLLM() { printf '%s' "Nu pot porni handler-ul «qroky» pe această mașină (claude CLI indisponibil) — cererea e salvată; o sesiune vie o va prelua. Detalii: telegram.log."; }
T_TASK_FILED() { printf 'Formulat ca sarcină — o sesiune vie o va vedea în %s. Formularea:' "$1"; }
T_FORMULATE_NOLLM_ROUTED() { printf '%s' "Nu pot formula fără handler (claude CLI indisponibil) — mesajul e salvat; o sesiune vie îl va formula. Detalii: telegram.log."; }
T_FORMULATE_NOLLM() { printf '%s' "Nu pot formula fără handler (claude CLI indisponibil) — răspunsul tău e salvat; o sesiune vie îl va formula. Detalii: telegram.log."; }
T_CLARIFY_NOLLM() { printf '%s' "Notat. Handler-ul pe această mașină e indisponibil (claude CLI) — o sesiune vie va prelua mesajul tău din decisions/inbox."; }
T_ORPHAN_PROMISE() { printf 'Despre promisiunea «rezultat până la %s»: lucrul a fost întrerupt și intrarea s-a pierdut — repetă cererea, te rog. E un eșec onest și e înregistrat.' "$1"; }

T_STATUS_DEAD() { printf '[%s] ⚠ cale din registru negăsită: %s' "$1" "$2"; }
T_STATUS_NOT_FOUND() { printf 'Niciun proiect înregistrat cu acest nume. Înregistrate: %s' "$1"; }
T_STATUS_EMPTY() { printf '%s' "Încă nu există sarcini în products/ — nimic de raportat."; }
T_STATUS_EMPTY_BLOCK() { printf '%s' "• deocamdată gol"; }
T_STATUS_DONE_CLOSED() { printf '%s' "gata/închis"; }
T_STATUS_TRUNCATED() { printf '%s' "…(trunchiat — imaginea completă în digestul de dimineață)"; }

T_DG_GREETING() { printf 'Bună dimineața. Digest pentru %s:' "$1"; }
T_DG_GREETING_MERGED() { printf 'Bună dimineața. Digest combinat pentru %s:' "$1"; }
T_DG_DONE() { printf '%s' "Făcut:"; }
T_DG_RUN() { printf '%s' "În lucru:"; }
T_DG_WAIT_TODAY() { printf '%s' "Te așteaptă azi:"; }
T_DG_WAIT() { printf '%s' "Te așteaptă:"; }
T_DG_EMPTY_DONE() { printf '%s' "• deocamdată gol"; }
T_DG_EMPTY_RUN() { printf '%s' "• nimic nu rulează"; }
T_DG_NO_DECISIONS() { printf '%s' "• nu așteptăm decizii"; }
T_DG_PENDING_SUFFIX() { printf '%s' " — așteaptă decizia ta (butoanele în chat mai sus)"; }
T_DG_SIGNALED_HEADER() { printf '%s' "Deja în flux azi (status, nu alarmă):"; }
T_DG_SIGNALED_SUFFIX() { printf '%s' " — a sosit deja ca eveniment azi, fără alarmă repetată"; }
T_DG_SPEND_NONE() { printf '%s' "consum: fără date pentru azi"; }
T_DG_SPEND_NONE_SHORT() { printf '%s' "consum: fără date"; }
T_DG_SPEND() { printf 'consum: %s' "$1"; }
T_DG_CHANGELOG() { printf 'Actualizarea regulilor %s:' "$1"; }
T_DG_QUIET() { printf '[%s] — liniște: fără schimbări, fără decizii în așteptare' "$1"; }
T_DG_DEAD() { printf '⚠ [%s] — cale din registru negăsită: %s (repară ~/.qroky/registry)' "$1" "$2"; }
T_DG_TOTAL() { printf 'consum total (ledgere numerice): %s' "$1"; }
T_DG_TRUNCATED() { printf '%s' "…(trunchiat)"; }
